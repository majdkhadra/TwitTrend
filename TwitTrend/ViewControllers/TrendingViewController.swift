//
//  ViewController.swift
//  TwitTrend
//
//  Created by Majd Khadra on 2022-02-03.
//

import UIKit
import SwifteriOS

class TrendingViewController: UIViewController {
    
    
    // MARK: - Constants
    private let searchTextFieldTopPadding: CGFloat = 10
    private let searchTextFieldBottomPadding: CGFloat = 40
    private let tableViewTopPadding : CGFloat = 20
    private let tableViewBottomPadding : CGFloat = 300
    private let searchTextFieldSidePadding: CGFloat = 30
    private let searchTextFieldHeight: CGFloat = 50
    
    // MARK: - Views
    let searchTextField = UITextField()
    let trendingTitleLabel = UILabel()
    let trendingTableView = UITableView()
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.light))

    // MARK: - Constraint Variables
    var searchTextFieldTopConstraint: NSLayoutConstraint?
    var searchTextFieldBottomConstraint: NSLayoutConstraint?
    var tableViewAfterAnimationConstraint: NSLayoutConstraint?
    var searchFieldCenterConstraint: NSLayoutConstraint?
    
    
    var trends: [Trend] = [Trend]()
    let swifter = Swifter(consumerKey: "8wEUaHJMNMAiOlrSHf6nvpyZz", consumerSecret: "9HMtqp9iH8j7AOhlxLEOcI6A00uZDJ0M7sK2RFlRniQBpw5oyG")

    var didLayoutSubviewsOnce = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(UIView(frame: .zero))
        title = "Whats Trending?"
        
        view.addSubviews(subviews: [trendingTableView, searchTextField])
        
        trendingTableView.dataSource = self
        trendingTableView.delegate = self
        searchTextField.delegate = self

        setupTableView()
        fetchTrends()
        
        self.hideKeyboardWhenTappedAround()
        
        view.backgroundColor = .twitterBlue
    }
    
    func setupConstraints() {
        searchTextFieldTopConstraint = searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: searchTextFieldTopPadding + view.safeAreaInsets.top)
        searchTextFieldBottomConstraint = searchTextField.bottomAnchor.constraint(equalTo: trendingTableView.topAnchor, constant: (-1) * tableViewTopPadding)
        
        
        tableViewAfterAnimationConstraint = trendingTableView.topAnchor.constraint(equalTo: view.topAnchor ,constant:  (tableViewTopPadding + searchTextFieldTopPadding + view.safeAreaInsets.top))
        searchFieldCenterConstraint = searchTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        
        // these always remain true
        searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: searchTextFieldSidePadding).isActive = true
        searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: (-1) * searchTextFieldSidePadding).isActive = true
    }
    
    
    func setupTableView() {
        trendingTableView.rowHeight = 100
        trendingTableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: "TrendingTableViewCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !didLayoutSubviewsOnce {
            setupConstraints()
            manageConstraints()
            normalStateConstraints()
            didLayoutSubviewsOnce = true
        }
        
        setupTextField()
        setupTitleLabel()
    }
    
    func setupTextField() {
        searchTextField.textColor = .blue
        searchTextField.attributedPlaceholder =  NSAttributedString(string: "Search Twitter", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        searchTextField.layer.borderColor = UIColor.blue.cgColor
        searchTextField.layer.cornerRadius = searchTextFieldHeight/2
        searchTextField.layer.borderWidth = 1.0
        searchTextField.setLeftPaddingPoints(10)
    }
    
    func setupTitleLabel() {
        trendingTitleLabel.text = "Trending Today"
        trendingTitleLabel.textAlignment = .center
        trendingTitleLabel.textColor = .blue
        trendingTitleLabel.font = UIFont(name: trendingTitleLabel.font.fontName, size: 30)
    }
    
    func fetchTrends() {
        swifter.getTrendsPlace(with: "1", excludeHashtags: false) { (result) in
            
            let JSON = "\(result)"
            let jsonData = JSON.data(using: .utf8)!
            guard let jsonTrends = try? JSONDecoder().decode([TrendData].self, from: jsonData) else {
                print("JSON Decoder Fail")
                return
            }
            self.trends = jsonTrends[0].trends
            self.trendingTableView.reloadData()
            
            
        } failure: { (error) in
            print(error)
            
        }
    }

}

// MARK: - TableView Delegate
extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // change from string to varialbe somewhere
        let cell = trendingTableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell") as! TrendingTableViewCell
        cell.set(trend: trends[indexPath.row].name)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TrendingTableViewCell
        if let trendingText = cell.trendingTextLabel.text {
            // make launchviewcontroller function
            let tweetsViewController = TweetViewController(searchParameter: trendingText)
            navigationController?.pushViewController(tweetsViewController, animated: true)
        }
    }
    
    
}

// MARK: - TextField Delegate
extension TrendingViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, belowSubview: self.searchTextField)
        UIView.animate(withDuration: 0.3) {
            self.searchingStateConstraints()
            self.view.layoutIfNeeded()
        }
        self.navigationController?.navigationBar.backgroundColor = .clear

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        blurEffectView.removeFromSuperview()
        UIView.animate(withDuration: 0.3) {
            self.normalStateConstraints()
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchText = textField.text {
            // make launchviewcontroller function
            textField.endEditing(true)
            let tweetsViewController = TweetViewController(searchParameter: searchText)
            navigationController?.pushViewController(tweetsViewController, animated: true)
            textField.text = ""
        }
        return true
    }
}

// MARK: - Constraints
extension TrendingViewController {
    func manageConstraints() {
        let views: [String : UIView] = ["ttv": trendingTableView
                                        ,"stf": searchTextField]
        
        let metrics: [String: CGFloat] = ["tvtp": tableViewTopPadding,
                                          "tvbp": tableViewBottomPadding,
                                          "stftp": searchTextFieldTopPadding + view.safeAreaInsets.top,
                                          "stfbp": searchTextFieldBottomPadding,
                                          "stfsp": searchTextFieldSidePadding,
                                          "stfh" : searchTextFieldHeight]
        
        let constraints: [String] = ["H:|[ttv]|",
                                     "V:[ttv]|",
                                     "V:[stf(stfh)]"]
        view.addConstraints(constraints: constraints, metrics: metrics, views: views)
        
    }
    
    func normalStateConstraints() {
        tableViewAfterAnimationConstraint?.isActive = false
        searchFieldCenterConstraint?.isActive = false
        
        searchTextFieldTopConstraint?.isActive = true
        searchTextFieldBottomConstraint?.isActive = true
    }
    
    func searchingStateConstraints() {
        
        searchTextFieldTopConstraint?.isActive = false
        searchTextFieldBottomConstraint?.isActive = false
        
        tableViewAfterAnimationConstraint?.isActive = true
        searchFieldCenterConstraint?.isActive = true
        
        navigationController?.navigationBar.backgroundColor = .twitterBlue
    }
}

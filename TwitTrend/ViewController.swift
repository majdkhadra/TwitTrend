//
//  ViewController.swift
//  TwitTrend
//
//  Created by Majd Khadra on 2022-02-03.
//

import UIKit
// eventually make my own custom tableview for this app so i can reuse it everywhere
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trendingTableView.dequeueReusableCell(withIdentifier: "TrendingTweetCell")
    }
    
    
    // MARK: - Constants
    private let searchTextFieldTopPadding: CGFloat = 10
    private let searchTextFieldBottomPadding: CGFloat = 40
    private let tableViewTopPadding : CGFloat = 20
    private let tableViewBottomPadding : CGFloat = 300
    private let searchTextFieldSidePadding: CGFloat = 30
    private let searchTextFieldHeight: CGFloat = 50
    
    var tweets: [Tweet] = [Tweet]()
    let searchTextField = UITextField()
    let trendingTitleLabel = UILabel()
    let trendingTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(subviews: [trendingTableView, trendingTitleLabel, searchTextField])
        trendingTableView.dataSource = self
        trendingTableView.delegate = self
        view.backgroundColor = .white
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        manageConstraints()
        setupTextField()
        setupTitleLabel()

    }
    
    func setupTextField() {
        searchTextField.textColor = .blue
        searchTextField.attributedPlaceholder =  NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
        searchTextField.layer.borderColor = UIColor.blue.cgColor
        searchTextField.layer.cornerRadius = searchTextFieldHeight/2
        searchTextField.layer.borderWidth = 1.0
        searchTextField.setLeftPaddingPoints(10)
    }
    
    func setupTitleLabel() {
        trendingTitleLabel.text = "What's Trending?"
        trendingTitleLabel.textAlignment = .center
        trendingTitleLabel.textColor = .blue
        trendingTitleLabel.font = UIFont(name: trendingTitleLabel.font.fontName, size: 30)
    }
    

}


extension ViewController {
    func manageConstraints() {
        
        let views: [String : UIView] = ["ttv": trendingTableView
                                        ,"stf": searchTextField,
                                        "ttl": trendingTitleLabel]
        
        let metrics: [String: CGFloat] = ["tvtp": tableViewTopPadding,
                                          "tvbp": tableViewBottomPadding,
                                          "stftp": searchTextFieldTopPadding + view.safeAreaInsets.top,
                                          "stfbp": searchTextFieldBottomPadding,
                                          "stfsp": searchTextFieldSidePadding,
                                          "stfh" : searchTextFieldHeight]
        
        let constraints: [String] = ["H:|[ttv]|",
                                     "H:|-stfsp-[stf]-stfsp-|",
                                     "H:|[ttl]|",
                                     "V:|-stftp-[stf(stfh)]-stfbp-[ttl]-tvtp-[ttv]-tvbp-|"]
        
        view.addConstraints(constraints: constraints, metrics: metrics, views: views)
    }
}

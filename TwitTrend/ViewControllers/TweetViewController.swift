//
//  TweetViewController.swift
//  TwitTrend
//
//  Created by Majd Khadra on 2022-02-07.
//

import UIKit
import SwifteriOS
import SafariServices


class TweetViewController: UIViewController {
    
    // MARK: - Views
    var tweetTableView: UITableView = UITableView()
    
    let swifter = Swifter(consumerKey: "8wEUaHJMNMAiOlrSHf6nvpyZz", consumerSecret: "9HMtqp9iH8j7AOhlxLEOcI6A00uZDJ0M7sK2RFlRniQBpw5oyG") // hide keys
    var tweets: [Tweet] = [Tweet]()
    var tweetSearchString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tweetTableView)
        tweetTableView.backgroundColor = .twitterBlue
        
        manageConstraints()
        
        tweetTableView.delegate = self
        tweetTableView.dataSource = self
        
        setupTableView()
        fetchTrends()
        
        self.title = "Tweets for Topic"
        navigationController?.navigationBar.backgroundColor = .clear
        
        
    }
    
    init(searchParameter: String) {
        super.init(nibName: nil, bundle: nil)
        tweetSearchString = searchParameter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupTableView() {
        tweetTableView.rowHeight = 100
        tweetTableView.register(TweetTableViewCell.self, forCellReuseIdentifier: "TweetTableViewCell")
    }
    
    func fetchTrends() {
        if let tweetSearchString = tweetSearchString {
            swifter.searchTweet(using: tweetSearchString) { (result, error) in
                let JSON = "\(result)"
                let jsonData = JSON.data(using: .utf8)!
                guard let jsonTweets = try? JSONDecoder().decode([Tweet].self, from: jsonData) else {
                    print("JSON Decoder Fail")
                    return
                }
                self.tweets = jsonTweets
                self.tweetTableView.reloadData()
                
            } failure: { (error) in
                print("there was an error")
                print(error)
            }
        }
    }
}

// MARK: - TableViewDelegate
extension TweetViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetTableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell") as! TweetTableViewCell
        cell.set(tweetText: tweets[indexPath.row].text)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweetid = tweets[indexPath.row].id_str
        if let url = URL(string: "https://twitter.com/any/status/\(tweetid)") {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - Constraints
extension TweetViewController {
    func manageConstraints() {
        let views: [String : UIView] = ["ttv":tweetTableView]
        let metrics: [String: CGFloat] = [:]
        let constraints: [String] = ["V:|[ttv]|",
                                     "H:|[ttv]|"]
        
        view.addConstraints(constraints: constraints, metrics: metrics, views: views)
    }
}

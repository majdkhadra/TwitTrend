//
//  TrendingTableViewCell.swift
//  TwitTrend
//
//  Created by Majd Khadra on 2022-02-06.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var trendingTextLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        
        addSubview(trendingTextLabel)
        
        manageConstraints()
        setupTweetTextLabel()
    }
    
    func set(tweetText: String) {
        trendingTextLabel.text = tweetText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTweetTextLabel() {
        trendingTextLabel.numberOfLines = 3
        
    }
}

// MARK: - Constraints
extension TweetTableViewCell {
    func manageConstraints() {
        let views: [String : UIView] = ["ttl":trendingTextLabel]
        let metrics: [String: CGFloat] = [:]
        let constraints: [String] = ["H:|-[ttl]-|",
                                     "V:|[ttl]|"]
        
        addConstraints(constraints: constraints, metrics: metrics, views: views)
    }
}

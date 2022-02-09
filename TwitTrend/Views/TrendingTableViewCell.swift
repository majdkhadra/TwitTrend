//
//  TrendingTableViewCell.swift
//  TwitTrend
//
//  Created by Majd Khadra on 2022-02-06.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {
    
    var trendingTextLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(trendingTextLabel)
        
        manageConstraints()
        setupTrendingTextLabel()
    }
    
    func set(trend: String) {
        trendingTextLabel.text = trend
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTrendingTextLabel() {
        trendingTextLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    
}

// MARK: - Constraints
extension TrendingTableViewCell {
    func manageConstraints() {
        let views: [String : UIView] = ["ttl":trendingTextLabel]
        let metrics: [String: CGFloat] = [:]
        let constraints: [String] = ["H:|-[ttl]-|",
                                     "V:|[ttl]|"]
        
        addConstraints(constraints: constraints, metrics: metrics, views: views)
    }
}

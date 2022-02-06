//
//  TweetTableViewCell.swift
//  TwitTrend
//
//  Created by Majd Khadra on 2022-02-04.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    
    let cellId = "TweetTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TweetTableViewCell {
    func manageConstraints() {
        let views: [String : UIView] = [<#string#>:<#view#>]
        let metrics: [String: CGFloat] = [<#string#>:<#metric#>]
        let constraints: [String] = [<#string#>]
        
        addConstraints(constraints: constraints, metrics: metrics, views: views)
    }
}

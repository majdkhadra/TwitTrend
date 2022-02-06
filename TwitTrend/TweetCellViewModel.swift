//
//  TweetCellViewModel.swift
//  TwitTrend
//
//  Created by Majd Khadra on 2022-02-05.
//

import Foundation

class TweetCellViewModel {
    
    let tweetText: String
    let likeCount: Int
    
    init(tweet: Tweet) {
        tweetText = tweet.text
        likeCount = tweet.public_metrics.like_count
    }
    
}

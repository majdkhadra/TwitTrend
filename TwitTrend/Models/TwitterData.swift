//
//  TwitterData.swift
//  TwitTrend
//
//  Created by Majd Khadra on 2022-02-03.
//

import Foundation

struct Tweets: Codable {
    var data: [Tweet]
    var meta: Meta
}

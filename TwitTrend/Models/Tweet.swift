//
//  Tweet.swift
//  TwitTrend
//
//  Created by Majd Khadra on 2022-02-03.
//

import Foundation

struct Tweet: Codable {
    var id: String
    var text: String
    var public_metrics: PublicMetrics
}

//
//  Meta.swift
//  TwitTrend
//
//  Created by Majd Khadra on 2022-02-03.
//
// Meta Data from twitter response
import Foundation

struct Meta: Codable {
    var newest_id: String
    var oldest_id: String
    result_count: Int
}

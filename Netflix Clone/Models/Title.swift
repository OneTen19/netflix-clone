//
//  Movie.swift
//  Netflix Clone
//
//  Created by OneTen on 7/4/24.
//

import Foundation

struct TrendingTitleResponse : Decodable {
    let results : [Title]
}


struct Title : Decodable {
    let id: Int
    let name: String?
    let title : String?
    let original_language : String?
    let original_title: String?
    let overview: String?
    let poster_path: String?
    let media_type: String?
    let popularity: Double?
    let release_date: String?
    let vote_average: Double?
    let vote_count: Int?
}

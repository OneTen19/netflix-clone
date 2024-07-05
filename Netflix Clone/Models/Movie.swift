//
//  Movie.swift
//  Netflix Clone
//
//  Created by OneTen on 7/4/24.
//

import Foundation

struct TrendingMoviesResponse : Decodable {
    let boxOfficeResult : BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxofficeType: String?
    let showRange: String?
    let weeklyBoxOfficeList: [Movie]
}

struct Movie : Decodable {
    let rnum : String?
    let rankOldAndNew : String?
    let salesAcc : String?
    let salesInten : String?
    let openDt : String?
    let scrnCnt : String?
    let audiInten : String?
    let audiCnt : String?
    let audiChange : String?
    let movieNm : String?
    let movieCd : String?
    let showCnt : String?
    let salesAmt : String?
    let audiAcc : String?
    let rankInten : String?
    let rank : String?
    let salesChange : String?
    let salesShare : String?
}

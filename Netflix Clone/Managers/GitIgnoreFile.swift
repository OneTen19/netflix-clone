//
//  GitIgnoreFile.swift
//  Netflix Clone
//
//  Created by OneTen on 7/5/24.
//

import Foundation

struct Constants {
    static let API_KEY = "fd8f2df19115a92a87c4e38f38d40bfd"
    
    // 주간 박스오피스, 영화 전체목록, 데일리 박스오피스 등등 선택해서 불러오는 곳 (일단 지금은 주간 박스오피스로)
    static let urlString = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key="
    
    static let itemPerPage = "&itemPerPage=10"
    static let targetDt = "&targetDt=20240505"
}

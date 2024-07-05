//
//  APICaller.swift
//  Netflix Clone
//
//  Created by OneTen on 7/3/24.
//

import Foundation


struct Constants {
    static let API_KEY = "fd8f2df19115a92a87c4e38f38d40bfd"
    
    // 주간 박스오피스, 영화 전체목록, 데일리 박스오피스 등등 선택해서 불러오는 곳 (일단 지금은 주간 박스오피스로)
    static let urlString = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key="
    
    static let itemPerPage = "&itemPerPage=10"
    static let targetDt = "&targetDt=20240505"
}


enum APIError {
    case failedTogetData
}


class APICaller {
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        
        let urlString = Constants.urlString + Constants.API_KEY + Constants.itemPerPage + Constants.targetDt

        
        guard let url = URL(string: urlString) else {return}
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{

                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.boxOfficeResult.weeklyBoxOfficeList))
                
            } catch {
                completion(.failure(error))
            }
            
        }
        
        
        task.resume()
        
    }
    
    
    private func decodeUnicode(_ unicodeStr: String) -> String? {
        let tempString = unicodeStr.replacingOccurrences(of: "\\u", with: "\\U")
        let tempString2 = "\"\(tempString)\""
        let data = tempString2.data(using: .utf8)!
        
        if let decodedString = try? PropertyListSerialization.propertyList(
            from: data,
            options: [],
            format: nil
        ) as? String {
            return decodedString.replacingOccurrences(of: "\\r\\n", with: "\n")
        }
        
        return nil
    }
    
}

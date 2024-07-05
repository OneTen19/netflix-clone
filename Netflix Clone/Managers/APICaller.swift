//
//  APICaller.swift
//  Netflix Clone
//
//  Created by OneTen on 7/3/24.
//

import Foundation


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

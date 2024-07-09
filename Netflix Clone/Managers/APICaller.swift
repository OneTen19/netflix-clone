//
//  APICaller.swift
//  Netflix Clone
//
//  Created by OneTen on 7/3/24.
//

import Foundation

// 불러올 API 정하는 곳
struct Constants {
    static let API_KEY = Bundle.main.apiKey
    
    // Trending Movies
    static let baseURL = "https://api.themoviedb.org/3/trending/movie/day?api_key="

    
}


enum APIError {
    case failedTogetData
}


class APICaller {
    static let shared = APICaller()
    
    // Trending Movies
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void){
        let urlString = Constants.baseURL + Constants.API_KEY!

        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    
}

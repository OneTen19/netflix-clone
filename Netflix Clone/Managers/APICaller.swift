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
    static let movieURL = "https://api.themoviedb.org/3/trending/movie/day?api_key="
    
    // Trending TV
    static let tvURL = "https://api.themoviedb.org/3/trending/tv/day?api_key="

    // Upcoming
    static let upcomingURL = "https://api.themoviedb.org/3/movie/upcoming?api_key="
    
    // Popular
    static let popularURL = "https://api.themoviedb.org/3/tv/popular?api_key="
    
    // Top rated
    static let rateURL = "https://api.themoviedb.org/3/tv/top_rated?api_key="
    
}


enum APIError {
    case failedTogetData
}


class APICaller {
    static let shared = APICaller()
    
    // Trending Movies
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void){
        let urlString = Constants.movieURL + Constants.API_KEY!

        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    
    // Trending TV
    func getTrendingTv(completion: @escaping (Result<[Title], Error>) -> Void){
        let urlString = Constants.tvURL + Constants.API_KEY!

        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    
    // Upcoming
    func getUpcoming(completion: @escaping (Result<[Title], Error>) -> Void){
        let urlString = Constants.upcomingURL + Constants.API_KEY!

        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    
    // Popular
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void){
        let urlString = Constants.popularURL + Constants.API_KEY!

        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
    
    
    // Top rated
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void){
        let urlString = Constants.rateURL + Constants.API_KEY!

        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(error))
            }
            
        }
        
        task.resume()
    }
}

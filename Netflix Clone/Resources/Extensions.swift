//
//  Extensions.swift
//  Netflix Clone
//
//  Created by OneTen on 7/5/24.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}

// API KEY 받아오는 곳
extension Bundle {
    var apiKey: String? {
        return infoDictionary?["MOVIE_API_KEY"] as? String
    }
}

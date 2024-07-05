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

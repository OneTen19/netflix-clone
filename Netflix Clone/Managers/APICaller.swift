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


class APICaller {
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (String) -> Void){
        
        let urlString = Constants.urlString + Constants.API_KEY + Constants.itemPerPage + Constants.targetDt

        
        guard let url = URL(string: urlString) else {return}
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                
                // 받아온 API 값 저장
                let resultAPI = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
                
//                print(resultAPI!)
                
                // 1차 유니코드 디코딩 -> 원하는 영화 리스트가 영화결과라는 항목 내에 있어서 두번에 걸쳐서 디코딩해줘야하는걸로 추정
                let boxOfficeResult = resultAPI!["boxOfficeResult"] as? [String: Any]
                
//                print(boxOfficeResult!)
                
                // 2차 유니코드 디코딩 -> 이게 영화 리스트들 저장된 변수
                let weeklyBoxOfficeList = boxOfficeResult!["weeklyBoxOfficeList"] as? [[String: Any]]
                
                weeklyBoxOfficeList?.forEach({ item in
                    print(item)
                    print("\n")
                })
                
                
                
            } catch {
                print(error.localizedDescription)
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

//
//  APICaller.swift
//  Netflix Clone
//
//  Created by OneTen on 7/3/24.
//

import Foundation


struct Constants {
    static let API_KEY = "fd8f2df19115a92a87c4e38f38d40bfd"
    static let itemPerPage = "&itemPerPage=20"
}


class APICaller {
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (String) -> Void){
        
        let urlString = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key="
        + Constants.API_KEY
        + "&targetDt=20230101"
        
        guard let url = URL(string: urlString) else {return}
        
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data , error == nil else {return}
            
            do{
                
                // 받아온 API 값 저장
                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any]
                
                
                // 1차 유니코드 디코딩 -> 박스오피스결과에 박스오피스 리스트가 들어있어서 이렇게 두 번에 걸쳐 디코딩해야 하는 듯??
                let boxOfficeResult = result!["boxOfficeResult"] as? [String: Any]
                
                
                // 2차 유니코드 디코딩 -> 이게 리스트들 저장된 변수
                let dailyBoxOfficeList = boxOfficeResult!["dailyBoxOfficeList"] as? [[String: Any]]
  
                
                dailyBoxOfficeList?.forEach({ item in
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

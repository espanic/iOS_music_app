//
//  MusicApi.swift
//  MusicApp
//
//  Created by 최윤호 on 2023/09/22.
//

import Foundation
import Alamofire

enum CustomError : Error{
    case networkingError
    case dataError
    case parseError
    
}

final class MusicApi {
    
    static let shared = MusicApi()
    
    private init(){}
    
    typealias NetworkCompletion = (Result<[Music], CustomError>) -> Void
    
    func getMusic(searchTerm : String, completion : @escaping NetworkCompletion){
        AF.request(Api.baseUrl, method: .get, parameters: ["term": searchTerm, "media":"music"], encoding: URLEncoding.default,headers: ["Content-Type" : "application/json", "Accept": "application/json"])
            .responseDecodable(of: MusicData.self) { response in
                if response.error != nil {
                    completion(.failure(.networkingError))
                    return
                }
                if let musicData = response.value {
                    completion(.success(musicData.results))
                    return
                }
                completion(.failure(.dataError))
                
                
            
            }
    }
    
    private func parseJson(data : Data) -> [Music]? {
        do {
            let musicData = try JSONDecoder().decode(MusicData.self, from: data)
            return musicData.results
        } catch {
            return nil
        }
    }
    
    
}

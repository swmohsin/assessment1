//
//  APIService.swift
//  assessment1
//
//  Created by Admin on 2018-04-30.
//  Copyright © 2018 Test. All rights reserved.
//

import UIKit

enum APIError: String, Error {
    case noNetwork = "No Network"
    case serverError = "Internal Server Error"
    case invalidRequest = "Invalid Request"
}

protocol APIServiceProtocol {
    func loadTopics(success: @escaping (_ topics:[Topic]) -> (), failure: @escaping (_ error:APIError) -> ())
}

class APIService: APIServiceProtocol {
    let endPoint = "https://api.duckduckgo.com/?q=apple&format=json&pretty=1"
    
    func loadTopics(success: @escaping ([Topic]) -> (), failure: @escaping (APIError) -> ()) {
        let session = URLSession.shared
        guard let url = URL(string: endPoint) else { failure(.invalidRequest); return }
        
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else { failure(.invalidRequest); return }
            guard let data = data else { failure(.serverError); return }
            let decoder = JSONDecoder()
            do {
                let topics = try decoder.decode(Topics.self, from: data)
                success(topics.topics)
            } catch {
                print(error)
                failure(.invalidRequest)
            }
        }
        dataTask.resume()
    }
}

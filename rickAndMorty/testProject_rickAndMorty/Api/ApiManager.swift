//
//  ApiManager.swift
//  testProject_rickAndMorty
//
//  Created by Евгений Л on 07.11.2023.
//

import Foundation

enum NetworkError: Error {
    case badUrl, badData, serverError
}

class ApiManager {
    
    static func path<ResponseApi>(for type: ResponseApi.Type, url: String, completion: @escaping (Result<ResponseApi, NetworkError>) -> ()) where ResponseApi : Decodable {
        let urlString = URL(string: url)
        guard let url = urlString else {
            completion(.failure(NetworkError.badUrl))
            return }
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { dataResponse, _, error in
            if let data = dataResponse, error == nil, let result =  try? JSONDecoder().decode(ResponseApi.self, from: data) {
                completion(.success(result))
            } else {
                completion(.failure(NetworkError.badData))
            }
        }
        task.resume()
    }
}

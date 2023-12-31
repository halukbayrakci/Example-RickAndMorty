//
//  RMServices.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 15.08.2023.
//

/// Primary API service object to get Rick and Morty data

import Foundation

final class RMServices {
    /// Shared Singleton instance
    static let shared =  RMServices()
    
    private let cacheManager = RMAPICacheManager()
    
    enum RMServiceError: Error {
        case failedGetData
        case failedToGetData
    }
    
    
    /// Privatized constructor
    private init() {}
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - type: The type of object we expect to get back
    ///   - completion: Callback with data or error
    public func execute<T: Codable> (_ request: RMRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        if let cachedData = cacheManager.cachedResponse(for: request.endpoint, url: request.url) {
//            print("Using cached API response")

            do {
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                completion(.success(result))
            } catch  {
                completion(.failure(error))
            }
            
            return
        }
        
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedGetData))
            return
        }
//        print("API CALL: \(request.url?.absoluteString ?? "")")
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [ weak self ] data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(for: request.endpoint, url: request.url, data: data)
                completion(.success(result))
            } catch  {
                completion(.failure(error))
            }
        }
        task.resume()
        
    }
    
    //MARK: - Private
    
    private func request(from rmRequest: RMRequest ) -> URLRequest? {
        
        guard let url = rmRequest.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
    
}

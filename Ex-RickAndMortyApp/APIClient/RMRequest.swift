//
//  RMRequest.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 15.08.2023.
//

import Foundation

/// Object that represents a singlet API call
final class RMRequest {
    
    /// API Constants
    private struct Constants {
        static let baseURL = "https://rickandmortyapi.com/api"
    }
    
    /// Desired endpoint
    private let endpoint: RMEndpoint
    /// Path Components for API, if any
    private let pathComponents: [String]
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseURL
        string += "/"
        string += endpoint.rawValue
        
        if !pathComponents.isEmpty {
            string += "/"
            pathComponents.forEach ({
                string += "\($0)"
            })
        }
        
        if !queryParameters.isEmpty {
            string += "?"
            //name=value&name=value
            let argumentString = queryParameters.compactMap {
                guard let value = $0.value else { return nil}
                return "\($0.name)=\(value)"
            }.joined(separator: "&")
            
            string += argumentString
        }
        return string
    }
    
    /// Computed & constructed API url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    /// Desired http method
    public let httpMethod = "GET"
    
    //MARK: - Public
    
    
    /// Construct request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: Collection of path components
    ///   - queryParameters: Collection of query parameters
    public init(endpoint: RMEndpoint,
                pathComponents: [String] = [],
                queryParameters: [URLQueryItem] = []
    ){
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
    
    convenience init?(url: URL) {
        
        let string = url.absoluteString
        
        if !string.contains(Constants.baseURL) {
            return nil
        }
        let trimmed = string.replacingOccurrences(of: Constants.baseURL+"/", with: "")
        if trimmed.contains("/") {
            let compenents = trimmed.components(separatedBy: "/")
            if !compenents.isEmpty {
                let endpointString = compenents[0]
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint)
                    return
                }
            }
        } else if trimmed.contains("?") {
            let compenents = trimmed.components(separatedBy: "?")
            if !compenents.isEmpty, compenents.count >= 2 {
                let endpointString = compenents[0]
                let queryItemsString = compenents[1]
                // value=name&value=name
                
                let queryItems: [URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap {
                    guard $0.contains("=") else {
                        return nil
                    }
                    
                    let parts = $0.components(separatedBy: "=")
                    
                    return URLQueryItem(name: parts[0], value: parts[1])
                }
                if let rmEndpoint = RMEndpoint(rawValue: endpointString) {
                    self.init(endpoint: rmEndpoint, queryParameters: queryItems)
                    return
                }
                
            }
        }
        return nil
    }
    
    
}


extension RMRequest {
    static let listCharacterRequest = RMRequest(endpoint: .character)
}

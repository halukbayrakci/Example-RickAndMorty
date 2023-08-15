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
    
    /// Privatized constructor
    private init() {}
    
    /// Send Rick and Morty API Call
    /// - Parameters:
    ///   - request: Request instance
    ///   - completion: Callback with data or error
    private func execute (_ request: RMRequest, completion: @escaping () -> Void) {
        
    }
    
}

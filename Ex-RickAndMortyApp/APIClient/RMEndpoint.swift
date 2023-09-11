//
//  RMEndpoint.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 15.08.2023.
//

import Foundation

/// Respresents unique API endpoint
@frozen enum RMEndpoint: String, CaseIterable, Hashable {
    /// Endpoint to get character info
    case character
    /// Endpoint to get location info
    case location
    /// Endpoint to get episode info
    case episode
}

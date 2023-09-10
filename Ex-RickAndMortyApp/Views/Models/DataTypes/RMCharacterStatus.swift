//
//  RMCharacterStatus.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 15.08.2023.
//

import Foundation

enum RMCharacterStatus: String, Codable {
        // Alive, Dead or Unknown
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknownw"
        }
    }
}

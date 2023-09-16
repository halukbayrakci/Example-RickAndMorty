//
//  RMLocationViewViewModel.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 16.09.2023.
//

import Foundation

final class RMLocationViewViewModel {
    
    private var locations: [RMLocation] = []
    
    // Location response info
    // Will contain next url, if present
    
    private var cellViewModels: [String] = []
    
    init() {
        
    }
    
    private var hasMoreResults: Bool {
        return false
    }
    
    public func fetchLocations() {
        RMServices.shared.execute(.listLocationsRequest, expecting: String.self) { result in
            switch result {
            case .success(let success):
                break
            case .failure(let failure):
                break
            }
        }
    }
    
  
    
}

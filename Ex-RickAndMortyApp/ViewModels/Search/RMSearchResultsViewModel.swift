//
//  RMSearchResultsViewModel.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 25.09.2023.
//

import Foundation

enum RMSearchResultsViewModel {
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodesCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
    
}

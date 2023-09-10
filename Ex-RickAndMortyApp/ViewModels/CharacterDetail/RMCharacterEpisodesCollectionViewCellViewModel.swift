//
//  RMCharacterEpisodesCollectionViewCellViewModel.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 10.09.2023.
//

import Foundation

final class RMCharacterEpisodesCollectionViewCellViewModel {
    
    private let episodeDataUrl: URL?
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
}
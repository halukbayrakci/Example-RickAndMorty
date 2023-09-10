//
//  RMCharacterInformationCollectionViewCellViewModel.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 10.09.2023.
//

import Foundation

final class RMCharacterInformationCollectionViewCellViewModel {
    public let value: String
    public let title: String
    
    
    init(value: String, title: String) {
        self.value = value
        self.title = title
    }
}

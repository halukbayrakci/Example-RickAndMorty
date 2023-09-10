//
//  RMCharacterDetailViewViewModel.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 20.08.2023.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    private let character: RMCharacter
    
    enum SectionTypes: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    public let sections = SectionTypes.allCases
    
    //MARK: - Init
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    private var requestUrl: URL? {
        return URL(string: character.url)
    }
    
    public var title: String {
        character.name.uppercased()
    }
    
}

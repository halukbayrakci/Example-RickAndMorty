//
//  RMSettingsCellViewModel.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 14.09.2023.
//

import UIKit

struct RMSettingsCellViewModel: Identifiable, Hashable {
    
    let id = UUID()

    private let type: RMSettingsOption
    
    
    //MARK: - Init
    
    init(type: RMSettingsOption) {
        self.type = type
    }
    
    //MARK: - Public
    
    public var image: UIImage? {
        return type.iconImage
    }
    public var title: String {
        return type.displayTitle
    }
    
    public var iconContainerColo: UIColor {
        return type.iconContainerColor
    }
}

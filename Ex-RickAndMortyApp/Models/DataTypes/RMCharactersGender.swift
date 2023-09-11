//
//  RMCharactersGender.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 15.08.2023.
//

import Foundation

enum RMCharactersGender: String, Codable {
   //The gender of the character ('Female', 'Male', 'Genderless' or 'unknown')
    
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown  = "unknown"
}

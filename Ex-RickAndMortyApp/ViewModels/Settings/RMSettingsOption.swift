//
//  RMSettingsOption.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 14.09.2023.
//

import UIKit

enum RMSettingsOption: CaseIterable {
    
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewSeries
    case viewCode
    
    var targetUrl: URL? {
        switch self {
        case .rateApp:
            return nil
        case .contactUs:
            return URL(string: "https://github.com/halukbayrakci")
        case .terms:
            return URL(string: "https://docs.github.com/en/site-policy/github-terms/github-terms-of-service")
        case .privacy:
            return URL(string: "https://docs.github.com/en/site-policy/privacy-policies/github-privacy-statement")
        case .apiReference:
            return URL(string: "https://rickandmortyapi.com/documentation")
        case .viewSeries:
            return URL(string: "https://www.youtube.com/watch?v=EZpZDuOAFKE&list=PL5PR3UyfTWvdl4Ya_2veOB6TM16FXuv4y")
        case .viewCode:
            return URL(string: "https://github.com/halukbayrakci/Example-RickAndMorty")
        }
    }
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Service"
        case .privacy:
            return "Privacy Policy"
        case .apiReference:
            return "API Refence"
        case .viewSeries:
            return "View Video Series"
        case .viewCode:
            return "View App Code"
        }
    }
    
    var iconContainerColor: UIColor {
        switch self {
        case .rateApp:
            return .systemRed
        case .contactUs:
            return .systemBlue
        case .terms:
            return .systemCyan
        case .privacy:
            return .systemMint
        case .apiReference:
            return .systemPink
        case .viewSeries:
            return .systemBrown
        case .viewCode:
            return .systemGreen
        }
    }
    
    var iconImage: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apiReference:
            return UIImage(systemName: "list.clipboard")
        case .viewSeries:
            return UIImage(systemName: "tv.fill")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")

        }
    }
}

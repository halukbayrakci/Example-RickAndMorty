//
//  RMEpisodeDetailViewViewModel.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 11.09.2023.
//

import UIKit

class RMEpisodeDetailViewViewModel {

    private let endpointUrl: URL?
    
    init(endpointUrl: URL?) {
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    
    private func fetchEpisodeData() {
        guard let url = endpointUrl, let request = RMRequest(url: url) else {
            return
        }
        RMServices.shared.execute(request, expecting: RMEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                break
            }
        }
    }
}

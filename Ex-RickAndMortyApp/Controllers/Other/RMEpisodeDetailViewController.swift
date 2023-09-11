//
//  RMEpisodeDetailViewController.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 11.09.2023.
//

import UIKit

/// VC to show details about single episode
final class RMEpisodeDetailViewController: UIViewController {
    
    private let viewModel: RMEpisodeDetailViewViewModel
    
    //MARK: - Init
    
    init(url: URL?) {
        self.viewModel = .init(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Episode"
    }
    

   

}

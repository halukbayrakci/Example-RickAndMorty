//
//  RMEpisodeDetailViewController.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 11.09.2023.
//

import UIKit

/// VC to show details about single episode
final class RMEpisodeDetailViewController: UIViewController, RMEpisodeDetailViewViewModelDelegate, RMEpisodeDetailViewDelegate {
    
    private let viewModel: RMEpisodeDetailViewViewModel
    private let detailView = RMEpisodeDetailView()
    
    //MARK: - Init
    
    init(url: URL?) {
        self.viewModel = RMEpisodeDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        detailView.delegate = self
        title = "Episode"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        viewModel.delegate = self
        viewModel.fetchEpisodeData()

        
        addConsraints()
    }
    
    private func addConsraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

        ])
    }
    
    @objc private func didTapShare() {
        
    }
    
    //MARK: -ViewModel Delegate
    
    func didFetchEpisodeDetails() {
        detailView.configure(with: viewModel)
    }
    
    //MARK: - View Delegate
    
    func rmEpisodeDetailView(_ detailView: RMEpisodeDetailView, didSelect character: RMCharacter) {
        
        let vc = RMCharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }


}

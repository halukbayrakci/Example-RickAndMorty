//
//  RickVsMortyLocationViewController.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 15.08.2023.
//

import UIKit

///  Controller to show and search for Locations
final class RMLocationViewController: UIViewController, RMLocationViewViewModelDelegate, RMLocationViewDelegate {
    
    private let primaryView = RMLocationView()

    private let viewModel = RMLocationViewViewModel()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(primaryView)
        view.backgroundColor = .systemBackground
        title = "Locations"
        primaryView.delegate = self
        addSearchButton()
        addConsraints()
        viewModel.delegate = self
        viewModel.fetchLocations()
    }
    
    private func addConsraints() {
        NSLayoutConstraint.activate([
            
            primaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            primaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor)
        
        ])
    }
    

    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        let vc = RMSearchViewController(config: .init(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - LocationViewModel Delegate
    
    func didFetchInitialLocations() {
        primaryView.configure(with: viewModel)
    }

    //MARK: - RMLocationViewDelegate
    
    func rmLocationView(_ locationView: RMLocationView, didSelect location: RMLocation) {
        let  vc = RMLocationDetailViewController(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    

}

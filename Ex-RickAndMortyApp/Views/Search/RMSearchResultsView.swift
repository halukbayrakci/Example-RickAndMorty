//
//  RMSearchResultsView.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 25.09.2023.
//

import UIKit

/// Shows search results UI(table or collection as needed)
final class RMSearchResultsView: UIView {

    private var viewModel: RMSearchResultsViewModel? {
        didSet{
            self.processViewModel()
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RMLocationTableViewCell.self, forCellReuseIdentifier: RMLocationTableViewCell.cellIdentifier)
        tableView.isHidden = true
        return tableView
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func processViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        
        switch viewModel {
        case .characters(let viewModels):
            setUpCollectionView()
        case .episodes(let viewModels):
            setUpCollectionView()
        case .locations(let viewModels):
            setUpTableView()
        }
    }
    
    private func setUpTableView() {
        tableView.isHidden = false
    }
    
    private func setUpCollectionView() {
        
        
    }
    
    private func  addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        tableView.backgroundColor = .brown
    }
    
    public  func  configure(with viewModel: RMSearchResultsViewModel) {
        self.viewModel = viewModel
    }

}

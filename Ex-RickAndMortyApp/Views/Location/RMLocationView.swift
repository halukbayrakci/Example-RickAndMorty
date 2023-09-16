//
//  RMLocationView.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 16.09.2023.
//

import UIKit

final class RMLocationView: UIView {
    
    private var viewModel: RMLocationViewViewModel? {
        didSet {
            activityIndicator.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
            
        }
    }

    private let tableView: UITableView = {
       
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.alpha = 0
        table.isHidden = true
        return table
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.heightAnchor.constraint(equalToConstant: 100),
            activityIndicator.widthAnchor.constraint(equalToConstant: 100),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
    
    public func configure(with viewModel: RMLocationViewViewModel) {
        self.viewModel = viewModel
    }
  
}

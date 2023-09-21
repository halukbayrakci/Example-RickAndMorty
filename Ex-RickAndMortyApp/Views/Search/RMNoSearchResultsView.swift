//
//  RMNoSearchResultsView.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 18.09.2023.
//

import UIKit

final class RMNoSearchResultsView: UIView {

    private let viewModel = RMNoSearchResultsViewViewModel()
    
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .systemBlue
        iconView.translatesAutoresizingMaskIntoConstraints = false
        return iconView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        addSubview(label)
        isHidden = true
        constraints()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 90),
            iconView.heightAnchor.constraint(equalToConstant: 90),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),        
        ])
    }
    
    private func  configure() {
        iconView.image = viewModel.image
        label.text = viewModel.title
    }
    
}

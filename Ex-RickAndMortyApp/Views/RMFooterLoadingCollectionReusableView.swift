//
//  RMFooterLoadingCollectionReusableView.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 23.08.2023.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
      
    static let identifier = "RMFooterLoadingCollectionReusableView"
    
    private let activityIndicator: UIActivityIndicatorView = {
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(activityIndicator)
        
        addConstraints()
        startAnimating() 
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 100),
            activityIndicator.heightAnchor.constraint(equalToConstant: 100),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    public func startAnimating() {
        activityIndicator.startAnimating()
    }
}

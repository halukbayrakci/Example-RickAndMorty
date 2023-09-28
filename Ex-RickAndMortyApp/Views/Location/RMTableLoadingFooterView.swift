//
//  RMTableLoadingFooterView.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 26.09.2023.
//

import UIKit

final class RMTableLoadingFooterView: UIView {

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            activityIndicator.widthAnchor.constraint(equalToConstant: 55),
            activityIndicator.heightAnchor.constraint(equalToConstant: 55),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),

        ])
    }

}

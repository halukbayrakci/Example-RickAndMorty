//
//  RMCharacterEpisodesCollectionViewCell.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 10.09.2023.
//

import UIKit

final class RMCharacterEpisodesCollectionViewCell: UICollectionViewCell {
   
    static let cellIdentifer = "RMCharacterEpisodesCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUpConstraints() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMCharacterEpisodesCollectionViewCellViewModel) {
        
    }
}

//
//  RMLocationTableViewCell.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 16.09.2023.
//

import UIKit

final class RMLocationTableViewCell: UITableViewCell {

    static let cellIdentifier = "RMLocationTableViewCell"
    
//    private let viewModel: RMLocationTableViewCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: RMLocationTableViewCellViewModel) {
        
    }
    
}

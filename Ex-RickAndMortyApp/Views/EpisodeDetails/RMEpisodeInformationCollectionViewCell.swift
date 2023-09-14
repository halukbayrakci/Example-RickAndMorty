//
//  RMEpisodeInformationCollectionViewCell.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 13.09.2023.
//

import UIKit

final class RMEpisodeInformationCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "RMEpisodeInformationCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(titleLabel)
        contentView.addSubview(valueLabel)
        setUpLayer()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    private func  addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.47),
            valueLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)

        ])
    }
    
    private func setUpLayer() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    func  configure(with viewModel: RMEpisodeInformationCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}

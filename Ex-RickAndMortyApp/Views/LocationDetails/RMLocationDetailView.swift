//
//  RMLocationDetailView.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 18.09.2023.
//

import UIKit

protocol RMLocationDetailViewDelegate: AnyObject {
    func RMLocationDetailView(_ detailView: RMLocationDetailView, didSelect character: RMCharacter)
}

final class RMLocationDetailView: UIView {
    
    public weak var delegate: RMLocationDetailViewDelegate?

    private var viewModel: RMLocationDetailViewViewModel? {
        didSet {
            activityIndicator.stopAnimating()
            self.collectionView?.reloadData()
            self.collectionView?.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.collectionView?.alpha = 1
            }
        }
    }
    private var collectionView: UICollectionView?
    private let activityIndicator: UIActivityIndicatorView = {
        
    let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        addSubview(activityIndicator)
        addSubview(collectionView)
        
        activityIndicator.startAnimating()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private  func addConstraints() {
        
        guard let collectionView = collectionView else { return }
        
        NSLayoutConstraint.activate([
            activityIndicator.heightAnchor.constraint(equalToConstant: 100),
            activityIndicator.widthAnchor.constraint(equalToConstant: 100),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { section, _ in
            return self.layout(for: section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RMEpisodeInformationCollectionViewCell.self, forCellWithReuseIdentifier: RMEpisodeInformationCollectionViewCell.cellIdentifier)
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }
    
    public func configure(with viewModel: RMLocationDetailViewViewModel)  {
        self.viewModel = viewModel
    }
    
}

extension RMLocationDetailView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = viewModel?.cellViewModels else {
            return 0
        }
        let sectionType = sections[section]
        switch sectionType {
        case .information(let viewModels):
            return viewModels.count
        case .characters(let viewModels):
            return viewModels.count
            
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sections = viewModel?.cellViewModels else {
            fatalError("No viewModel")
        }
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .information(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  RMEpisodeInformationCollectionViewCell.cellIdentifier, for: indexPath) as? RMEpisodeInformationCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: cellViewModel)
            return cell
        case .characters(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
                fatalError()
            }
            cell.configure(with: cellViewModel)
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let viewModel = viewModel else {
            return
        }
        let sections = viewModel.cellViewModels
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .information:
            break
        case .characters:
            guard let character = viewModel.character(at: indexPath.row) else {
                return
            }
            delegate?.RMLocationDetailView(self, didSelect: character)
        }
    }
    
    
}


extension RMLocationDetailView {
    
    private func layout(for section: Int) -> NSCollectionLayoutSection {
        guard let sections = viewModel?.cellViewModels else {
            return createInfolayout()
        }
        
        switch sections[section] {
        case .information:
            return createInfolayout()
        case .characters:
            return createCharacterlayout()
        }
    }
    
    private func  createInfolayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(85)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func createCharacterlayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIDevice.isIphone ? 0.5 : 0.25), heightDimension: .fractionalHeight(1.0)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(UIDevice.isIphone ? 260 : 320)), subitems: UIDevice.isIphone ? [item, item] : [item, item, item, item])
        
        let section = NSCollectionLayoutSection(group: group)
       
        return section
    
    }
}

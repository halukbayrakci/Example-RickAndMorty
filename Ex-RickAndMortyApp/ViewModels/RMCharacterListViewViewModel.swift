//
//  CharacterListViewViewModel.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 17.08.2023.
//

import UIKit

final class RMCharacterListViewViewModel: NSObject {
    
    func fetchCharacter() {
        RMServices.shared.execute(.listCharacterRequest, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Page result count: "+String(model.results.first?.image ?? "ali"))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension RMCharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RMCharacterCollectionViewCell.cellIdentifier, for: indexPath) as? RMCharacterCollectionViewCell else {
            
            fatalError()
        }
        
        let viewModel = RMCharacterCollectionViewCellViewModel(characterName: "HALUK", characterStatus: .alive, characterImageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"))
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(width: width , height: width*1.5 )
    }
    
}

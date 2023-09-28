//
//  RMSearchResultsType.swift
//  Ex-RickAndMortyApp
//
//  Created by HALUK BAYRAKCI on 25.09.2023.
//

import Foundation

final class RMSearchResultsViewModel {
    public private(set) var results: RMSearchResultsType
    private var next: String?
    
    init(results: RMSearchResultsType, next: String?) {
        self.results = results
        self.next = next
    }
    
    public private(set) var isLoadingMoreResults = false
    
    public var shouldShowLoadMoreIndicator: Bool {
        return next != nil
    }
    
    public func fetchAdditionalLocations(completion: @escaping ([RMLocationTableViewCellViewModel]) -> Void) {
        //fetch characters
        
        guard !isLoadingMoreResults else {
            return
        }
        
        guard  let nextUrlString = next,
               let url = URL(string: nextUrlString)  else {
            return
        }
        
        isLoadingMoreResults = true
        
        guard let  request = RMRequest(url: url) else {
            isLoadingMoreResults = false
            return
        }
        
        RMServices.shared.execute(request, expecting: RMGetAllLocationsResponse.self) { [ weak self ] result in
            
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let responseModel):
                
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.next = info.next // Capture new pagination url
                
                let additionalLocations = moreResults.compactMap({
                    return RMLocationTableViewCellViewModel(location: $0)
                })
                
                var newResults: [RMLocationTableViewCellViewModel] = []
                
                switch strongSelf.results {
                case .characters, .episodes:
                    break
                case .locations(let existingResults):
                    newResults = existingResults + additionalLocations
                    strongSelf.results = .locations(newResults)
                    break
                }
                
                DispatchQueue.main.async {
                    strongSelf.isLoadingMoreResults = false
                    
                    // Notify via callback
                    completion(newResults)
                }
            case .failure(let error):
                print(String(describing: error))
                self?.isLoadingMoreResults = false
                 
            }
        }
    }
    
    public func fetchAdditionalResults(completion: @escaping ([any Hashable]) -> Void) {
        //fetch characters
        
        guard !isLoadingMoreResults else {
            return
        }
        
        guard  let nextUrlString = next,
               let url = URL(string: nextUrlString)  else {
            return
        }
        
        isLoadingMoreResults = true
        
        guard let  request = RMRequest(url: url) else {
            isLoadingMoreResults = false
            return
        }
        
        switch results {
        case .characters(let existingResults):
            RMServices.shared.execute(request, expecting: RMGetAllCharactersResponse.self) { [ weak self ] result in
                
                guard let strongSelf = self else {
                    return
                }
                
                switch result {
                case .success(let responseModel):
                    
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.next = info.next // Capture new pagination url
                    
                    let additionalResults = moreResults.compactMap({
                        return RMCharacterCollectionViewCellViewModel(characterName: $0.name,
                                                                      characterStatus: $0.status,
                                                                      characterImageUrl: URL(string: $0.image))
                    })
                    
                    var newResults: [RMCharacterCollectionViewCellViewModel] = []
                    newResults = existingResults + additionalResults
                    strongSelf.results = .characters(newResults)
                    
                    DispatchQueue.main.async {
                        strongSelf.isLoadingMoreResults = false
                        
                        // Notify via callback
                        completion(newResults)
                    }
                case .failure(let error):
                    print(String(describing: error))
                    self?.isLoadingMoreResults = false
                     
                }
            }
        case .episodes(let existingResults):
            RMServices.shared.execute(request, expecting: RMGetAllEpisodesResponse.self) { [ weak self ] result in
                
                guard let strongSelf = self else {
                    return
                }
                
                switch result {
                case .success(let responseModel):
                    
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.next = info.next // Capture new pagination url
                    
                    let additionalResults = moreResults.compactMap({
                        return RMCharacterEpisodesCollectionViewCellViewModel(episodeDataUrl: URL(string: $0.url))
                    })
                    
                    var newResults: [RMCharacterEpisodesCollectionViewCellViewModel] = []
                    newResults = existingResults + additionalResults
                    strongSelf.results = .episodes(newResults)
                    
                    DispatchQueue.main.async {
                        strongSelf.isLoadingMoreResults = false
                        
                        // Notify via callback
                        completion(newResults)
                    }
                case .failure(let error):
                    print(String(describing: error))
                    self?.isLoadingMoreResults = false
                     
                }
            }
        case .locations:
            // TableView Case
            break
        }
        
    
    }
}

enum RMSearchResultsType {
    case characters([RMCharacterCollectionViewCellViewModel])
    case episodes([RMCharacterEpisodesCollectionViewCellViewModel])
    case locations([RMLocationTableViewCellViewModel])
    
}

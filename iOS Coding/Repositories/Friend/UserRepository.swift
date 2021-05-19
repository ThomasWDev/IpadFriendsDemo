//
//  PhotoRepository.swift
//
//  Created by Thomas Woodfin on 5/19/21.
//

import Foundation

typealias FriendRepositoryCompletion = (Result<[User], Error>) -> Void

class UserRepository {
    
    var networkDataSource: FriendDataSource
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        
        networkDataSource = FriendNetworkDataSource(networkManager: networkManager)
    }
    
    func fetchFriends(completion: FriendRepositoryCompletion?) {
        networkDataSource.fetchFriends() { result in
            switch result {
            case .success(let items):
                completion?(.success(items))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}

//
//  PhotoNetworkDataSource.swift
//
//  Created by Thomas Woodfin on 5/19/21.
//

import Foundation

class FriendNetworkDataSource: FriendDataSource {
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchFriends(completion: FriendDataSourceCompletion?) {
        let requestConfiguration = RequestConfiguration(endpoint: "https://randomuser.me/api/?results=10", httpMethod: .get, parameters: nil)
        networkManager.executeRequest(requestConfiguration: requestConfiguration, responseModel: Friends.self) { result in
            switch result {
            case .success(let dataResponse):
                if let friends = dataResponse.data as? Friends {
                    completion?(.success(friends.results ?? []))
                } else {
                    completion?(.success([]))
                }
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}

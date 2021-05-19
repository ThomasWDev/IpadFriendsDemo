//
//  PhotoDataSource.swift
//
//  Created by Thomas Woodfin on 5/19/21.
//

import Foundation

typealias FriendDataSourceCompletion = (Result<[User], Error>) -> Void

protocol FriendDataSource {
    
    func fetchFriends(completion: FriendDataSourceCompletion?)
}

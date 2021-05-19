//
//  FriendResponse.swift
//  IpadFriendsDemo
//
//  Created by Thomas Woodfin on 5/19/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation

struct FriendResponse: Decodable, CustomStringConvertible {
    var description: String{
        return ""
    }
    
    var userDetails: [UserDetailsList]?
    
    enum CodingKeys: String, NestableCodingKey {
        case userDetails          = "results"
    }
}

struct UserDetailsList: Decodable, CustomStringConvertible {
    var description: String{
        return ""
    }
    
    var gender: String?
    @NestedKey
    var titleName: String?
    @NestedKey
    var firstName: String?
    @NestedKey
    var lastName: String?
    @NestedKey
    var streetNumber: Int?
    @NestedKey
    var streetName: String?
    @NestedKey
    var city: String?
    @NestedKey
    var state: String?
    @NestedKey
    var country: String?
    @NestedKey
    var postcode: Int?
    var email: String?
    var phone: String?
    var cell: String?
    @NestedKey
    var largeLmg: String?
    @NestedKey
    var mediumImg: String?
    @NestedKey
    var thumbnailImg: String?

    enum CodingKeys: String, NestableCodingKey {
        case gender
        case titleName   = "name/title"
        case firstName   = "name/first"
        case lastName    = "name/last"
        case streetNumber = "location/street/number"
        case streetName = "location/street/name"
        case city = "location/city"
        case state = "location/state"
        case country = "location/country"
        case postcode = "location/postcode"
        case email
        case phone
        case cell
        case largeLmg = "picture/large"
        case mediumImg = "picture/medium"
        case thumbnailImg = "picture/thumbnail"
    }
}

//
//  URLPaths.swift
//  IpadFriendsDemo
//
//  Created by Thomas Woodfin on 5/19/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation



#if DEVELOPMENT
let KBasePath = "https://randomuser.me"
#else
let KBasePath = "https://randomuser.me"
#endif

enum OauthPath: String {
    case friendList                     = "/api/"
}

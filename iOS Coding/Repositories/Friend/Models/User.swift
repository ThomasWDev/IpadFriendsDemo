//
//  Photo.swift
//
//  Created by Thomas Woodfin on 5/19/21.
//

import Foundation

struct Friends: Codable {

    let results : [User]?
    let info : Info?

}

struct Info: Codable {

    let seed: String?
    let results: Int?
    let page: Int?
    let version: String?

}


struct User: Codable & Hashable {

    let name: UserName?
    let location: Location?
    let picture: Picture?
    let gender: String?
    let email: String?
    let phone: String?
    let cell: String?
    let nat: String?
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.email == rhs.email
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(email)
    }
}

struct UserName: Codable {

    let title: String?
    let first: String?
    let last: String?

    var fullname : String {
        var name = ""
        if let first = first {
            name.append(first)
        }
        if let last = last {
            name.append(" \(last)")
        }
        return name
    }

}

struct Location: Codable {

    let city: String?
    let state: String?
    let country: String?
    let street: Street?

    var shortAddress : String {
        var address = ""
        if let city = city {
            address.append("\(city)")
        }
        if let state = state {
            address.append(", \(state)")
        }
        if let country = country {
            address.append(", \(country)")
        }
        return address
    }

    var address : String {
        var fullAddress = ""
        if let number = street?.number {
            fullAddress.append("\(number)")
        }
        if let name = street?.name {
            fullAddress.append(" \(name)")
        }
        if let city = city {
            fullAddress.append(", \(city)")
        }
        if let state = state {
            fullAddress.append(", \(state)")
        }
        if let country = country {
            fullAddress.append(", \(country)")
        }
        return fullAddress
    }

}

struct Street: Codable {

    let number: Int?
    let name: String?

}

struct Picture: Codable {

    let large: String?
    let medium: String?
    let thumbnail: String?

}

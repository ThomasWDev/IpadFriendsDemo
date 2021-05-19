//
//  FDDashboardVM.swift
//  IpadFriendsDemo
//
//  Created by Thomas Woodfin on 5/19/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import Foundation

class FDDashboardVM{
    
    private var friendList: [UserDetailsList]?
    
    func getFriendList(completion: @escaping (_ success: Bool) -> Void){
        
        let url = KBasePath + OauthPath.friendList.rawValue
        APIClient.shared.objectAPICall(url: url, modelType: FriendResponse.self, method: .get, parameters: [String: Any]()) { (response) in
            switch response {
            case .success(let value):
                self.friendList = value.userDetails
                completion(true)
            case .failure((let code, let data, let error)):

                print("code = \(code)")
                print("data = \(String(describing: data))")
                print("error = \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    
    func getFriendList()-> [UserDetailsList]?{
        return friendList
    }
    
    func getFullName(index: Int)-> String{
        guard let title = friendList?[index].titleName else{return "N/A"}
        guard let firstName = friendList?[index].firstName else{return "N/A"}
        guard let lastName = friendList?[index].lastName else{return "N/A"}
        let fullName = "\(title) \(firstName) \(lastName)"
        return fullName
    }
    
    func getMediumImageName(index: Int)-> String{
        guard let image = friendList?[index].mediumImg else{return ""}
        return image
    }
    
    func getLargeImageName(index: Int)-> String{
        guard let image = friendList?[index].largeLmg else{return ""}
        return image
    }
    
    func getThumbnailImageName(index: Int)-> String{
        guard let image = friendList?[index].thumbnailImg else{return ""}
        return image
    }
    
    func getAddress(index: Int)-> String{
        guard let streetName = friendList?[index].streetName else{return "N/A"}
        guard let streetNumber = friendList?[index].streetNumber else{return "N/A"}
        guard let city = friendList?[index].city else{return "N/A"}
        guard let state = friendList?[index].state else{return "N/A"}
        guard let country = friendList?[index].country else{return "N/A"}
        
        let fullAddress = "\(streetNumber), \(streetName), \(state), \(city), \(country)"
        return fullAddress
    }
    
    func getCity(index: Int)-> String{
        guard let city = friendList?[index].city else{return "N/A"}
        return city
    }
    
    func getState(index: Int)-> String{
        guard let state = friendList?[index].state else{return "N/A"}
        return state
    }
    
    func getCountry(index: Int)-> String{
        guard let country = friendList?[index].country else{return "N/A"}
        return country
    }
    
    func getEmail(index: Int)-> String{
        guard let email = friendList?[index].email else{return "N/A"}
        return email
    }
    
    func getPhone(index: Int)-> String{
        guard let phone = friendList?[index].phone else{return "N/A"}
        return phone
    }
}

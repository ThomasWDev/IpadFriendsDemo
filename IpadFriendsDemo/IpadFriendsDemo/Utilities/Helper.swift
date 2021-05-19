//
//  Helper.swift
//  IpadFriendsDemo
//
//  Created by Thomas Woodfin on 5/19/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

struct Helper {
    static func emptyMessageInTableView(_ tableView: UITableView,_ title: String){
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.textColor        = UIColor(red: 67, green: 67, blue: 67, alpha: 1)
        noDataLabel.font             = UIFont(name: "Open Sans", size: 15)
        noDataLabel.textAlignment    = .center
        tableView.backgroundView = noDataLabel
        tableView.separatorStyle = .none
        noDataLabel.text = title
    }
    
    //MARK:- Alert Helpers

    static func showAlert(msg: String) {
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        let mwindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
        guard let parentVC = mwindow?.visibleViewController() else {return}
        parentVC.present(alert, animated: true, completion: nil)
    }
    
    static func changeSpecificTxtColor(mainString: String, stringToColor: String)-> NSMutableAttributedString{
        let range = (mainString as NSString).range(of: stringToColor)
        let mutableAttributedString = NSMutableAttributedString.init(string: mainString)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.link, range: range)
        return mutableAttributedString
    }

}

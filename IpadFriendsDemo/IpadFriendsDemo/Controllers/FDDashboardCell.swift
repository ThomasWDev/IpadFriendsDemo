//
//  FDDashboardCell.swift
//  IpadFriendsDemo
//
//  Created by Thomas Woodfin on 5/19/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit

class FDDashboardCell: UITableViewCell {
    
    static let identifier = "FDDashboardCell"
    
    @IBOutlet weak private var bgView: UIView!
    @IBOutlet weak private var portraitImageView: UIImageView!
    @IBOutlet weak private var fullNameLbl: UILabel!
    @IBOutlet weak private var countryLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        portraitImageView.layer.cornerRadius = 50
    }
    
    func configureCell(vm: FDDashboardVM, index: Int){
        fullNameLbl.sizeToFit()
        countryLbl.sizeToFit()
        
        fullNameLbl.text = "Name: \(vm.getFullName(index: index))"
        countryLbl.text = "Country: \(vm.getCountry(index: index))"
        let imageURL = vm.getMediumImageName(index: index)
        portraitImageView.downloaded(from: imageURL)
    }

}

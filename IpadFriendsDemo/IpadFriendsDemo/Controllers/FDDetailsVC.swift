//
//  FDDetailsVC.swift
//  IpadFriendsDemo
//
//  Created by Thomas Woodfin on 5/19/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//

import UIKit
import MessageUI

class FDDetailsVC: UIViewController {
    
    @IBOutlet weak private var portraitImageView: UIImageView!
    @IBOutlet weak private var fullNameLbl: UILabel!
    @IBOutlet weak private var addressLbl: UILabel!
    @IBOutlet weak private var cityLbl: UILabel!
    @IBOutlet weak private var stateLbl: UILabel!
    @IBOutlet weak private var countryLbl: UILabel!
    @IBOutlet weak private var emailLbl: UILabel!
    @IBOutlet weak private var phoneLbl: UILabel!
    
    var viewModel: FDDashboardVM?
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        portraitImageView.layer.cornerRadius = 8
        emailLbl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapOnEmail)))
        
        setData()
    }
    
    private func setData(){
        guard let vm = viewModel else {return}
        title = "\(vm.getFullName(index: currentIndex)) Details"
        let imageURL = vm.getLargeImageName(index: currentIndex)
        fullNameLbl.text = "Name: \(vm.getFullName(index: currentIndex))"
        addressLbl.text = "Address: \(vm.getAddress(index: currentIndex))"
        cityLbl.text = "City: \(vm.getCity(index: currentIndex))"
        stateLbl.text = "State: \(vm.getState(index: currentIndex))"
        countryLbl.text = "Country: \(vm.getCountry(index: currentIndex))"
        emailLbl.attributedText = Helper.changeSpecificTxtColor(mainString: "Email: \(vm.getEmail(index: currentIndex))", stringToColor: vm.getEmail(index: currentIndex))
        phoneLbl.attributedText = Helper.changeSpecificTxtColor(mainString: "Phone: \(vm.getPhone(index: currentIndex))", stringToColor: vm.getPhone(index: currentIndex))
        portraitImageView.downloaded(from: imageURL)
    }

    @objc func tapOnPhone(){
        guard let vm = viewModel else {return}
        let phone = vm.getPhone(index: currentIndex)
        
        callNumber(phoneNumber: phone)
    }
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc func tapOnEmail(){
        guard let vm = viewModel else {return}
        let email = vm.getEmail(index: currentIndex)
        openMail(email: email)
    }
    
    private func openMail(email: String){
        let recipientEmail = email
        let subject = "Test Email"
        let body = "This is test email send from iOS device."
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([recipientEmail])
            mail.setSubject(subject)
            mail.setMessageBody(body, isHTML: false)
            
            present(mail, animated: true)
            
        } else if let emailUrl = createEmailUrl(to: recipientEmail, subject: subject, body: body) {
            UIApplication.shared.open(emailUrl)
        }
    }
    
    private func createEmailUrl(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let gmailUrl = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookUrl = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMail = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkUrl = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let defaultUrl = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")
        
        if let gmailUrl = gmailUrl, UIApplication.shared.canOpenURL(gmailUrl) {
            return gmailUrl
        } else if let outlookUrl = outlookUrl, UIApplication.shared.canOpenURL(outlookUrl) {
            return outlookUrl
        } else if let yahooMail = yahooMail, UIApplication.shared.canOpenURL(yahooMail) {
            return yahooMail
        } else if let sparkUrl = sparkUrl, UIApplication.shared.canOpenURL(sparkUrl) {
            return sparkUrl
        }
        
        return defaultUrl
    }
}

extension FDDetailsVC: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

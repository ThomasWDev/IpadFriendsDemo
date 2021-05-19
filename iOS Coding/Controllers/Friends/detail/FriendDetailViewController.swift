//
//  FriendDetailViewController.swift
//  Friends App
//
//  Created by Thomas Woodfin on 5/19/21.
//

import UIKit
import MessageUI

class FriendDetailViewController: UIViewController {

    /// IBOutlet
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityStateCountryLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cellPhoneLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    /// Private
    private let emailComposeVC = MFMailComposeViewController()
    /// Public
    public var user : User?

    override func viewDidLoad() {
        super.viewDidLoad()
        avatarImageView.cornerRadius(avatarImageView.frame.height/2)
        addTapGestureRecognizer()
        loadUserInfo()
    }

    private func loadUserInfo() {
        if let user = user {
            if let large = user.picture?.large {
                ImageHelper.shared.loadImageUsingCache(withUrl: large, target:avatarImageView)
            }
            fullnameLabel.text = user.name?.fullname
            addressLabel.text = user.location?.address
            cityStateCountryLabel.text = user.location?.shortAddress
            emailLabel.text = user.email
            cellPhoneLabel.text = user.cell
        }
    }

    @objc private func openEmail() {
        if MFMailComposeViewController.canSendMail() {
            let emailTitle = "Friends App"
            let messageBody = user?.name?.fullname ?? ""
            let toRecipents = [user?.email ?? ""]
            emailComposeVC.mailComposeDelegate = self
            emailComposeVC.setSubject(emailTitle)
            emailComposeVC.setMessageBody(messageBody, isHTML: false)
            emailComposeVC.setToRecipients(toRecipents)
            self.present(emailComposeVC, animated: true, completion: nil)
        } else {
            self.showAlert(title: "Friends App", message: "E-mail does not support this device.")
        }

    }

    private func addTapGestureRecognizer() {
        emailLabel.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openEmail))
        emailLabel.addGestureRecognizer(tapGestureRecognizer)
    }

}

extension FriendDetailViewController : MFMailComposeViewControllerDelegate {

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

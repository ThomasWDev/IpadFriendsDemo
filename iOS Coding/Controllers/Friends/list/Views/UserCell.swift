//
//  UserCell.swift
//  Friends App
//
//  Created by Thomas Woodfin on 5/19/21.
//

import UIKit

class UserCell: UICollectionViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullnameLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var backdropView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.backgroundColor = .darkGray
        avatarImageView.cornerRadius(avatarImageView.frame.height/2)
        backdropView.cornerRadius(5)
    }

    public func configCellWith( user : User) {
        fullnameLabel.text = user.name?.fullname
        countryLabel.text = user.location?.country
        if let large = user.picture?.large {
            ImageHelper.shared.loadImageUsingCache(withUrl: large, target:avatarImageView)
        } else {
            avatarImageView.image = nil
        }
    }

}

extension UIView {

    public func cornerRadius(_ radius : CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
}

class ImageHelper {

    static let shared = ImageHelper()

    private let imageCache = NSCache<NSString, UIImage>()

    public func loadImageUsingCache(withUrl urlString : String, target : UIImageView) {
        let url = URL(string: urlString)
        if url == nil {return}
        target.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            target.image = cachedImage
            return
        }

        let activityIndicator = UIActivityIndicatorView.init(style:.large)
        let superView = target.superview
        superView?.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = superView?.center ?? .zero
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    target.image = image
                    activityIndicator.removeFromSuperview()
                }
            }

        }).resume()
    }
}

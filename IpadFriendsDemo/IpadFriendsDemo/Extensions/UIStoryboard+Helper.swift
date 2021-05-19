//
//  UIStoryboard+Customization.swift
//  IpadFriendsDemo
//
//  Created by Thomas Woodfin on 5/19/21.
//  Copyright © 2021 Thomas Woodfin. All rights reserved.
//


import UIKit

extension UIStoryboard {
    enum Storyboard: String {
        case dashboard  = "Main"
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
    }
    
    func instantiateViewController<T>(withIdentifier identifier: T.Type) -> T where T: StoryboardIdentifiable {
        let className = String(describing: identifier)
        weak var weakSelf = self
        guard let vc =  weakSelf?.instantiateViewController(withIdentifier: className) as? T else {
            fatalError("Cannot find controller with identifier \(className)")
        }
        return vc
    }
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController : StoryboardIdentifiable { }


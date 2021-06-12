//
//  UIViewController+Extension.swift
//  MovieApp
//
//  Created by bahadir on 11.06.2021.
//

import UIKit

extension UIViewController {
    
    enum Storyboards:String {
        case main = "Main"
        case detail = "Detail"
    }
    
    static func instantiateViewController(with identifier: String) -> Self {
        let storyboard = UIStoryboard(name: Storyboards.main.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! Self
        return viewController
    }
}

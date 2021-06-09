//
//  UICollectionReusableView+Extension.swift
//  MovieApp
//
//  Created by bahadir on 9.06.2021.
//

import UIKit

extension UICollectionReusableView {
    static var identifier: String {
        return String(describing: self)
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

//
//  UICollectionView+Extension.swift
//  MovieApp
//
//  Created by bahadir on 9.06.2021.
//

import UIKit

extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    func dequeCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
    
    func registerView(cellType: UICollectionReusableView.Type, kind: String = UICollectionView.elementKindSectionHeader) {
        register(cellType.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: cellType.identifier)
    }
    
    func dequeView<T: UICollectionReusableView>(cellType: T.Type, kind: String = UICollectionView.elementKindSectionHeader, indexPath: IndexPath) -> T {
        guard let reusableView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError()
        }
        return reusableView
    }
}

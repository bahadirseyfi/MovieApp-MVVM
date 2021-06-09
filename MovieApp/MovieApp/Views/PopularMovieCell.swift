//
//  PopularMovieCell.swift
//  MovieApp
//
//  Created by bahadir on 9.06.2021.
//

import UIKit

class PopularMovieCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.text = "Yıldız Savaşları"
    }
}

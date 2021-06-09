//
//  NowPlayingMovieCell.swift
//  MovieApp
//
//  Created by bahadir on 10.06.2021.
//

import UIKit
import SDWebImage

class NowPlayingMovieCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 15
    }
    
    func configure(date: String, title: String, image: String) {
        dateLabel.text = date
        titleLabel.text = title
        prepareImage(with: image)
    }
    
    private func prepareImage(with urlString: String?) {
        if let urlMovieString = urlString, let url = URL(string: urlMovieString) {
            imageView.sd_setImage(with: url)
        }
    }
}

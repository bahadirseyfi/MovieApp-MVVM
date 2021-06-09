//
//  PopularMovieCell.swift
//  MovieApp
//
//  Created by bahadir on 9.06.2021.
//

import UIKit
import SDWebImage

final class PopularMovieCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 15
    }
    
    func configureCell(image: String) {
        prepareImage(with: image)
    }
    
    private func prepareImage(with urlString: String?) {
        if let urlMovieString = urlString, let url = URL(string: urlMovieString) {
            imageView.sd_setImage(with: url)
        }
    }
}

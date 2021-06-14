//
//  TopRatedMovieCell.swift
//  MovieApp
//
//  Created by bahadir on 9.06.2021.
//

import UIKit
import SDWebImage

final class TopRatedMovieCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        layer.cornerRadius = 8
    }
    
    func configureCell(name: String, image: String) {
        nameLabel.text = name
        prepareImage(with: image)
    }
    
    private func prepareImage(with urlString: String?) {
        if let urlMovieString = urlString, let url = URL(string: urlMovieString) {
            imageView.sd_setImage(with: url)
        }
    }
}

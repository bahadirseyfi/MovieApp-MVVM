//
//  CastCrewCell.swift
//  MovieApp
//
//  Created by bahadir on 13.06.2021.
//

import UIKit

final class CastCrewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        imageView.layer.cornerRadius = imageView.layer.frame.width / 2
    }
    
    func configureCell(imageUrl: String, name: String) {
        nameLabel.text = name
        prepareImage(with: imageUrl)
    }
    
    private func prepareImage(with urlString: String?) {
        if let urlMovieString = urlString, let url = URL(string: urlMovieString) {
            imageView.sd_setImage(with: url)
        }
    }
}

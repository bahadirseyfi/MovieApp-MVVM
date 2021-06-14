//
//  NowPlayingMovieCell.swift
//  MovieApp
//
//  Created by bahadir on 10.06.2021.
//

import UIKit
import SDWebImage

final class NowPlayingMovieCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var rightTitleLabel: UILabel!
    @IBOutlet private weak var leftTitleLabel: UILabel!
    @IBOutlet private weak var rightBlurView: UIVisualEffectView!
    @IBOutlet private weak var leftBlurView: UIVisualEffectView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    func configure(index: Int, title: String, image: String) {
        prepareImage(with: image)
        prepareBlur(index, title: title)
    }
    
    private func prepareImage(with urlString: String?) {
        if let urlMovieString = urlString, let url = URL(string: urlMovieString) {
            imageView.sd_setImage(with: url)
        }
    }
    
    private func prepareBlur(_ index: Int, title: String) {
        if index % 2 == 0 {
            leftBlurView.isHidden = true
            rightTitleLabel.text = title
        } else {
            rightBlurView.isHidden = true
            leftTitleLabel.text = title
        }
    }
}

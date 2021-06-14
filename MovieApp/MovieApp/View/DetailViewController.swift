//
//  DetailViewController.swift
//  MovieApp
//
//  Created by bahadir on 11.06.2021.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var mainImage: UIImageView!
    @IBOutlet private weak var headerImage: UIImageView!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var genresLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var popularityLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var viewModel: DetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        viewModel.load()
        mainImage.layer.cornerRadius = mainImage.layer.frame.height / 2
        overviewLabel.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(DetailViewController.handleTapDescription))
        overviewLabel.addGestureRecognizer(tap)
    }
    
    private func prepareImage(with urlString: String?, image: UIImageView) {
        if let urlMovieString = urlString, let url = URL(string: urlMovieString) {
            image.sd_setImage(with: url)
        }
    }
    
    @objc
    private func handleTapDescription(_ sender: UITapGestureRecognizer?) {
        if let overview = overviewLabel {
            overview.numberOfLines = overview.numberOfLines == 0 ? 2 : 0
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: [.allowUserInteraction],
                           animations: {
                            self.view.layoutIfNeeded()
                           }, completion: nil)
        }
    }
}

extension DetailViewController: DetailViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func configureUI() {
        prepareImage(with: viewModel.mainImage, image: mainImage)
        prepareImage(with: viewModel.headerImage, image: headerImage)
        titleLabel.text = viewModel.title
        overviewLabel.text = viewModel.overview
        genresLabel.text = viewModel.genres
        languageLabel.text = viewModel.language
        popularityLabel.text = viewModel.popularity
    }
    
    func prepareCollection() {
        collectionView.register(cellType: CastCrewCell.self)
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: CastCrewCell.self, indexPath: indexPath)
        if let cast = viewModel.castCrew(indexPath.item) {
            let castImage =  MovieDBBaseAPI.BaseImagePath + (cast.profilePath ?? "")
            cell.configureCell(imageUrl: castImage, name: cast.name ?? "")
        }
        return cell
    }
}

//
//  ViewController.swift
//  MovieApp
//
//  Created by bahadir on 9.06.2021.
//

import UIKit

final class MovieViewController: UIViewController {

    @IBOutlet private weak var topRatedCollectionView: UICollectionView!
    @IBOutlet private weak var popularCollectionView: UICollectionView!
    @IBOutlet private weak var nowPlayingCollectionView: UICollectionView!
    
    var viewModel: MovieViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.load()
        title = "Movies"
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "full_primary")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    private func redirectTo(movieID: Int) {
        self.view.endEditing(true)
        let vc: DetailViewController = DetailViewController.instantiate(storyboards: .detail)
        vc.viewModel = DetailViewModel(movieID: movieID)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topRatedCollectionView {
            let cell = topRatedCollectionView.dequeCell(cellType: TopRatedMovieCell.self, indexPath: indexPath)
            if let movie = viewModel.topRatedMovie(indexPath.item) {
                let movieImage =  MovieDBBaseAPI.BaseImagePath + movie.backDropPath
                cell.configureCell(name: movie.title, image: movieImage)
            }
            return cell
        }
        
        if collectionView == popularCollectionView {
            let cell = popularCollectionView.dequeCell(cellType: PopularMovieCell.self, indexPath: indexPath)
            if let movie = viewModel.popularMovie(indexPath.item) {
                let movieImage =  MovieDBBaseAPI.BaseImagePath + movie.backDropPath
                cell.configureCell(image: movieImage)
            }
            return cell
        }

        if collectionView == nowPlayingCollectionView {
            let cell = nowPlayingCollectionView.dequeCell(cellType: NowPlayingMovieCell.self, indexPath: indexPath)
            if let movie = viewModel.nowPlayingMovie(indexPath.item) {
                let movieImage =  MovieDBBaseAPI.BaseImagePath + movie.posterPath
                cell.configure(index: indexPath.item, title: movie.title, image: movieImage)
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topRatedCollectionView {
            guard let movieID = viewModel.topRatedMovie(indexPath.item)?.movieId else {
                print("Başarız ID ")
                return
            }
            redirectTo(movieID: movieID)
        }
        
        if collectionView == popularCollectionView {
            guard let movieID = viewModel.popularMovie(indexPath.item)?.movieId else {
                print("Başarız ID ")
                return
            }
            redirectTo(movieID: movieID)
        }

        if collectionView == nowPlayingCollectionView {
            guard let movieID = viewModel.nowPlayingMovie(indexPath.item)?.movieId else {
                print("Başarız ID ")
                return
            }
            redirectTo(movieID: movieID)
        }
    }
}

extension MovieViewController: MovieViewModelDelegate {
    func prepareCollectionViews() {
        topRatedCollectionView.register(cellType: TopRatedMovieCell.self)
        popularCollectionView.register(cellType: PopularMovieCell.self)
        nowPlayingCollectionView.register(cellType: NowPlayingMovieCell.self)
        
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        
        topRatedCollectionView.delegate = self
        topRatedCollectionView.dataSource = self
    }
    
    func reloadTopRated() {
        topRatedCollectionView.reloadData()
    }
    
    func reloadPopular() {
        popularCollectionView.reloadData()
    }
    
    func reloadNowPlaying() {
        nowPlayingCollectionView.reloadData()
    }
}




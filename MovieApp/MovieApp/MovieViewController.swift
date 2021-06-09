//
//  ViewController.swift
//  MovieApp
//
//  Created by bahadir on 9.06.2021.
//

import UIKit
import API

final class MovieViewController: UIViewController {

    private var networkManager: NetworkManager<MovieEndpoint> = NetworkManager()
    var movies: [Movie] = []
    
    @IBOutlet private weak var topRatedCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovies()
        prepareCollectionView()
        title = "Movies"
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "blue_square")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    private func fetchMovies() {
        networkManager.request(endpoint: .topRated, type: MoviesResponse.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.movies = response.results
                self?.relaodData()
                break
            case .failure(let error):
                print("Failure : ", error)
                break
            }
        }
    }
}

extension MovieViewController {
    private func prepareCollectionView() {
        topRatedCollectionView.register(cellType: TopRatedMovieCell.self)
        topRatedCollectionView.delegate = self
        topRatedCollectionView.dataSource = self
    }
    private func relaodData() {
        topRatedCollectionView.reloadData()
    }
}

extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topRatedCollectionView.dequeCell(cellType: TopRatedMovieCell.self, indexPath: indexPath)
        let movie = movies[indexPath.item]
        let movieImage =  MovieDBBaseAPI.BaseImagePath + movie.posterPath
        cell.configureCell(name: movie.title, image: movieImage)
        return cell
    }
}




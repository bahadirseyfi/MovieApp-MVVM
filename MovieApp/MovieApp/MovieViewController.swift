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
    
    private var topRatedMovies: [Movie] = []
    private var popularMovies: [Movie] = []
    private var nowPlayingMovies: [Movie] = []
    
    @IBOutlet private weak var topRatedCollectionView: UICollectionView!
    @IBOutlet private weak var popularCollectionView: UICollectionView!
    @IBOutlet private weak var nowPlayingCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNowPlayingMovies()
        fetchTopRatedMovies()
        fetchPopularMovies()
        prepareCollectionView()
        title = "Movies"
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "full_primary")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    private func fetchTopRatedMovies() {
        networkManager.request(endpoint: .topRated, type: MoviesResponse.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.topRatedMovies = response.results
                self?.reloadTopRatedCollectionView()
                break
            case .failure(let error):
                print("Failure : ", error)
                break
            }
        }
    }
    
    private func fetchPopularMovies() {
        networkManager.request(endpoint: .popular, type: MoviesResponse.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.popularMovies = response.results
                self?.reloadPopularCollectionView()
                break
            case .failure(let error):
                print("Failure : ", error)
                break
            }
        }
    }
    
    private func fetchNowPlayingMovies() {
        networkManager.request(endpoint: .nowPlaying, type: MoviesResponse.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.nowPlayingMovies = response.results
                self?.reloadNowPlayingCollectionView()
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
        popularCollectionView.register(cellType: PopularMovieCell.self)
       // nowPlayingCollectionView.register(cellType: NowPlayingMovieCell.self)
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.dataSource = self
        popularCollectionView.delegate = self
        popularCollectionView.dataSource = self
        topRatedCollectionView.delegate = self
        topRatedCollectionView.dataSource = self
    }
    
    private func reloadTopRatedCollectionView() {
        topRatedCollectionView.reloadData()
    }
    
    private func reloadPopularCollectionView() {
        popularCollectionView.reloadData()
    }
    
    private func reloadNowPlayingCollectionView() {
        nowPlayingCollectionView.reloadData()
    }
}

extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return topRatedMovies.count
        case 1:
            return popularMovies.count
        default:
            return nowPlayingMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == topRatedCollectionView {
            let cell = topRatedCollectionView.dequeCell(cellType: TopRatedMovieCell.self, indexPath: indexPath)
            let movie = topRatedMovies[indexPath.item]
            let movieImage =  MovieDBBaseAPI.BaseImagePath + movie.backDropPath
            cell.configureCell(name: movie.title, image: movieImage)
            return cell
        }
        
        if collectionView == popularCollectionView {
            let cell = popularCollectionView.dequeCell(cellType: PopularMovieCell.self, indexPath: indexPath)
            let movie = popularMovies[indexPath.item]
            let movieImage =  MovieDBBaseAPI.BaseImagePath + movie.posterPath
            cell.configureCell(image: movieImage)
            return cell
        }
        
        if collectionView == nowPlayingCollectionView {
          //  let cell = nowPlayingCollectionView.dequeCell(cellType: NowPlayingMovieCell.self, indexPath: indexPath)
            let cell = nowPlayingCollectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingMovieCell", for: indexPath) as! NowPlayingMovieCell
            let movie = nowPlayingMovies[indexPath.item]
            let movieImage =  MovieDBBaseAPI.BaseImagePath + movie.posterPath
            cell.configure(date: movie.releaseDate, title: movie.title, image: movieImage)
            return cell
        }
        return UICollectionViewCell()
    }
}




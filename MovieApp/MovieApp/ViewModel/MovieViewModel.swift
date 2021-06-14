//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by bahadir on 11.06.2021.
//

import Foundation
import API

protocol MovieViewModelProtocol {
    var delegate: MovieViewModelDelegate? { get set }
    func load()
    func numberOfItems(_ section: Int) -> Int?
    func popularMovie(_ index: Int) -> Movie?
    func topRatedMovie(_ index: Int) -> Movie?
    func nowPlayingMovie(_ index: Int) -> Movie?
    func showLoading()
    func hideLoading()
}

protocol MovieViewModelDelegate: AnyObject {
    func reloadTopRated()
    func reloadPopular()
    func reloadNowPlaying()
    func prepareCollectionViews()
}

final class MovieViewModel {
    private var networkManager: NetworkManager<MovieEndpoint> = NetworkManager()
    
    private var topRatedMovies: [Movie] = []
    private var popularMovies: [Movie] = []
    private var nowPlayingMovies: [Movie] = []
    weak var delegate: MovieViewModelDelegate?
    
    init(networkManager: NetworkManager<MovieEndpoint>) {
        self.networkManager = networkManager
    }
    
    private func fetchTopRatedMovies() {
        showLoading()
        networkManager.request(endpoint: .topRated, type: MoviesResponse.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.hideLoading()
                self?.topRatedMovies = response.results
                self?.delegate?.reloadTopRated()
                break
            case .failure(let error):
                print("Failure : ", error)
                break
            }
        }
    }
    
    private func fetchPopularMovies() {
        showLoading()
        networkManager.request(endpoint: .popular, type: MoviesResponse.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.hideLoading()
                self?.popularMovies = response.results
                self?.delegate?.reloadPopular()
                break
            case .failure(let error):
                print("Failure : ", error)
                break
            }
        }
    }
    
    private func fetchNowPlayingMovies() {
        showLoading()
        networkManager.request(endpoint: .nowPlaying, type: MoviesResponse.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.hideLoading()
                self?.nowPlayingMovies = response.results
                self?.delegate?.reloadNowPlaying()
                break
            case .failure(let error):
                print("Failure : ", error)
                break
            }
        }
    }
}

extension MovieViewModel: MovieViewModelProtocol {
    
    func load() {
        delegate?.prepareCollectionViews()
        fetchPopularMovies()
        fetchNowPlayingMovies()
        fetchTopRatedMovies()
    }
    
    func popularMovie(_ index: Int) -> Movie? {
        popularMovies[index]
    }
    
    func topRatedMovie(_ index: Int) -> Movie? {
        topRatedMovies[index]
    }
    
    func nowPlayingMovie(_ index: Int) -> Movie? {
        nowPlayingMovies[index]
    }
    
    func numberOfItems(_ section: Int) -> Int? {
        switch section {
        case 0:
            return topRatedMovies.count
        case 1:
            return popularMovies.count
        case 2:
            return nowPlayingMovies.count
        default:
            return 0
        }
    }
    
    func showLoading() {
        ProgressView.shared.show()
    }
    
    func hideLoading() {
        ProgressView.shared.hide()
    }
}

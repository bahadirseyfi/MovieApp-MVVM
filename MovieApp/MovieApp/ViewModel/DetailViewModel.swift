//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by bahadir on 12.06.2021.
//

import Foundation
import API

protocol DetailViewModelProtocol {
    var delegate: DetailViewModelDelegate? { get set }
    func load()
    var mainImage: String { get }
    var headerImage: String { get }
    var title: String { get }
    var overview: String { get }
    var genres: String { get }
    var language: String { get }
    var popularity: String { get }
}

protocol DetailViewModelDelegate: AnyObject {
    func configureUI()
}

final class DetailViewModel {
    private var networkManager: NetworkManager<MovieEndpoint> = NetworkManager()
    
    private var movieID: Int = 0
    private var movie: Movie?
    weak var delegate: DetailViewModelDelegate?
    
    init(movieID: Int) {
        self.movieID = movieID
    }
    
    private func fetchMovie() {
        networkManager.request(endpoint: .detail(id: movieID), type: Movie.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.movie = response
                self?.delegate?.configureUI()
                break
            case .failure(let error):
                print("Detail Error: ",error)
                break
            }
        }
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    var overview: String {
        movie?.overview ?? ""
    }
    
    var genres: String {
        "Drama, Crime, TV Moviess"
    }
    
    var language: String {
        movie?.originalLanguage.uppercased() ?? ""
    }
    
    var popularity: String {
        "12112"
    }
    
    var title: String {
        movie?.title.uppercased() ?? ""
    }
    
    var mainImage: String {
        (MovieDBBaseAPI.BaseImagePath + (movie?.posterPath ?? ""))
    }
    
    var headerImage: String {
        (MovieDBBaseAPI.BaseImagePath + (movie?.backDropPath ?? ""))
    }
    
    func load() {
        fetchMovie()
    }

    var releaseDate: String {
        movie?.releaseDate ?? ""
    }
}

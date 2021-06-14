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
    var numberOfItem: Int { get }
    func castCrew(_ indexPath: Int) -> Cast?
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
    func prepareCollection()
    func reloadData()
}

final class DetailViewModel {
    private var networkManager: NetworkManager<MovieEndpoint> = NetworkManager()
    
    private var movieID: Int = 0
    private var movie: Movie?
    private var castCrew: [Cast] = []
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
    
    private func fetchCredits() {
        networkManager.request(endpoint: .credits(id: movieID), type: Credits.self) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.castCrew = response.cast ?? []
                self?.delegate?.reloadData()
            case .failure(let error):
                print("Cast Network Error: ",error)
            }
        }
    }
}

extension DetailViewModel: DetailViewModelProtocol {
    func castCrew(_ indexPath: Int) -> Cast? {
        castCrew[indexPath]
    }
    
    var numberOfItem: Int {
        castCrew.count
    }
    
    var overview: String {
        movie?.overview ?? ""
    }
    
    var genres: String {
        "Drama, Crime, TV"
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
        delegate?.prepareCollection()
        fetchMovie()
        fetchCredits()
    }

    var releaseDate: String {
        movie?.releaseDate ?? ""
    }
}

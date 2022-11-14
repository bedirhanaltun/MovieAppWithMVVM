//
//  DetailsVCModel.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 15.10.2022.
//

import Foundation

protocol DetailViewModelInterface: AnyObject {
    var view: DetailsVCInterface? {get set}
    func viewDidLoad()
    func takeMovies()
}

final class DetailViewModel {
    weak var view: DetailsVCInterface?
    private let service = MovieService()
    private var page = 1
    var similarMoviesList: [MovieSimilarResults] = []
}

extension DetailViewModel: DetailViewModelInterface {
    func takeMovies() {
        
    }
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configurePosterImageView()
        view?.downloadPosterImage()
        view?.configureTitleLabel()
        view?.configureDateLabel()
        view?.configureOverviewLabel()
        view?.configurePopularityLabel()
        view?.configureCollectionViewSimilar()
    }
    func getSimilarMovies(id: Int) {
        service.downloadSimilar(id: id) { [weak self] returnedSimilarMovies in
            guard let self = self else {return}
            guard let returnedSimilarMovies = returnedSimilarMovies else {return}
            
            self.similarMoviesList = returnedSimilarMovies
            
        }
    }
    
    
}

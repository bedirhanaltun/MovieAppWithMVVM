//
//  HomeViewModel.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 14.10.2022.
//

import Foundation

protocol HomeViewModelProtocol {
    var view: HomeVCProtocol? {get set}
    
    func viewDidLoad()
    func getMovies()
}

final class HomeViewModel {
    weak var view: HomeVCProtocol?
    private let service = MovieService()
    var moviesList: [MovieResults] = []
    private var page: Int = 1
}

extension HomeViewModel: HomeViewModelProtocol {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
        getMovies()
        
    }
    
    func getMovies() {
        service.downloadMovies(page: page) { [weak self] returnedMovies in
            guard let self = self else {return}
            guard let returnedMovies = returnedMovies else {return}
            
            self.moviesList.append(contentsOf: returnedMovies)
            self.page += 1
            self.view?.reloadCollectionView()
            
        }
    }
    
    func getDetails(id: Int) {
        service.downloadDetail(id: id) { [weak self] returnedDetail in
            guard let self = self else {return}
            guard let returnedDetail = returnedDetail else {return}
            
            self.view?.pushToDetailVC(movie: returnedDetail)
        }
    }
    
}

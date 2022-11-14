//
//  MovieService.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 14.10.2022.
//

import Foundation

final class MovieService {
    
    func downloadMovies(page: Int, completion: @escaping ([MovieResults]?) -> Void) {
        guard let url = URL(string: APIURLs.movies(page: page)) else {return}
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            
            guard let self = self else {return}
            
            switch result {
            case .success(let data):
                completion(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
            }
            
        }
    }
    
    func downloadDetail(id: Int, completion: @escaping (MovieResults?) -> Void) {
        guard let url = URL(string: APIURLs.details(id: id)) else {return}
        
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case.success(let data):
                completion(self.handleWithData(data))
            case.failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    func downloadSimilar(id: Int, completion: @escaping ([MovieSimilarResults]?) -> Void) {
        
        guard let url = URL(string: APIURLs.similar(id: id)) else {return}
         
        
        NetworkManager.shared.download(url: url) { [weak self] resultSimilar in
            guard let self = self else {return}
            
            switch resultSimilar {
            case .success(let data):
                completion(self.handleWithData(data))
                print(data)
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }
    
    
    
    private func handleWithError(_ error: Error) {
        print(error.localizedDescription)
    }
    
    private func handleWithData(_ data: Data) -> [MovieResults]? {
        do {
            let movie = try JSONDecoder().decode(Movie.self, from: data)
            return movie.results
            
        } catch let error {
            print(error)
            return nil
        }
    }
    
    private func handleWithData(_ data: Data) -> MovieResults? {
        do {
            let details = try JSONDecoder().decode(MovieResults.self, from: data)
            return details
        } catch {
            print(error)
            return nil
        }
    }
    
    private func handleWithData(_ data: Data) -> [MovieSimilarResults]? {
        do {
            let details = try JSONDecoder().decode([MovieSimilarResults].self, from: data)
            return details
        } catch {
            print(error)
            return nil
        }
    }
    
    
    
}

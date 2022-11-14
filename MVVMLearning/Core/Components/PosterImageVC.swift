//
//  PosterImageVC.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 15.10.2022.
//

import UIKit

final class PosterImageVC: UIImageView {
    
    private var dataTask: URLSessionDataTask?
    private var dataTaskSimilar: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadImage(movie: MovieResults) {
        guard let url = URL(string: APIURLs.imageURL(posterPath: movie._posterPath)) else {return}
        
        dataTask = NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async { self.image = UIImage(data: data) }
            case.failure(_):
                break
            }
        }
    }
    
    func downloadSimilarImage(movie: MovieSimilarResults) {
        guard let url = URL(string: APIURLs.imageURL(posterPath: movie._posterPath)) else {return}
        
        dataTaskSimilar = NetworkManager.shared.download(url: url, completion: { [weak self] resultSimilar in
            guard let self = self else {return}
            
            switch resultSimilar {
            
            case .success(let data):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            case .failure(_):
                break
            }
        })
    }
    
    func cancelDownloading() {
        dataTask?.cancel()
        dataTask = nil
    }
}

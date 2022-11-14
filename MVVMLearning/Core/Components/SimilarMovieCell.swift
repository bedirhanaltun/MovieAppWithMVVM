//
//  SimilarMovieCell.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 19.10.2022.
//

import UIKit

class SimilarMovieCell: UICollectionViewCell {
    static let similarId = "SimilarMovieCell"
    private var posterImageView: PosterImageVC!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellSettings() {
        backgroundColor = .systemGray4
        layer.cornerRadius = 15
        //Taşan kısımları kes.
        clipsToBounds = true
        backgroundColor = .orange
    }
    
    private func setCellISimilar(movie: MovieSimilarResults) {
        posterImageView.downloadSimilarImage(movie: movie)
    }
    
    
    
//
//
//    func setCellImageSimilar(movie: MovieSimilarResults) {
//        posterImageVC.downloadSimilarImage(movie: movie)
//    }
    
}

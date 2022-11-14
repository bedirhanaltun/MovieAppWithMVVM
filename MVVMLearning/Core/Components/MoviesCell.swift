//
//  MoviesCell.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 14.10.2022.
//

import UIKit

class MoviesCell: UICollectionViewCell {
    static let reuseID = "MoviesCell"
    private var posterImageVC: PosterImageVC!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        configureCell()
        configurePosterImageVC()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Override func'larda super çağırmam gerekiyor.
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageVC.image = nil
        posterImageVC.cancelDownloading()
    }
    
    func setCellImage(movie: MovieResults) {
        posterImageVC.downloadImage(movie: movie)
    }
    
    private func configureCell() {
        backgroundColor = .systemGray4
        layer.cornerRadius = 15
        //Taşan kısımları kes.
        clipsToBounds = true
    }
    
    private func configurePosterImageVC() {
        posterImageVC = PosterImageVC(frame: .zero)
        addSubview(posterImageVC)
        
        posterImageVC.pinToEdgesOf(view: self)
    }
}

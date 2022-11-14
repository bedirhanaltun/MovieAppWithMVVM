//
//  DetailsVC.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 15.10.2022.
//

import UIKit

protocol DetailsVCInterface: AnyObject {
    func configureVC()
    func configurePosterImageView()
    func downloadPosterImage()
    func configureTitleLabel()
    func configureDateLabel()
    func configureOverviewLabel()
    func configurePopularityLabel()
    func configureCollectionViewSimilar()
}

class DetailsVC: UIViewController {
    
    private let movie: MovieResults
    private let detailsViewModel = DetailViewModel()
    
    private let padding: CGFloat = 15
    
    private var posterImage: PosterImageVC!
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var overviewLabel: UILabel!
    private var popularityLabel: UILabel!
    private var similarCollectionView: UICollectionView!
    
    init(movie: MovieResults) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("Hey")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsViewModel.view = self
        detailsViewModel.viewDidLoad()
    }
    
}

extension DetailsVC: DetailsVCInterface {
    
    func configureCollectionViewSimilar() {
        similarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createSimilarFlowLayout())
        view.addSubview(similarCollectionView)
        
        //Storyboard ile uğraşmıyorken bu satırı yazmamız gerekiyor.
        similarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
        similarCollectionView.register(SimilarMovieCell.self, forCellWithReuseIdentifier: SimilarMovieCell.similarId)

        
        NSLayoutConstraint.activate([
            similarCollectionView.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor,constant: padding),
            similarCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            similarCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            similarCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: padding)

        ])
        
        
    }
    
    func configurePosterImageView() {
        posterImage = PosterImageVC(frame: .zero)
        view.addSubview(posterImage)
        
        let posterWidth = CGFloat(.deviceWidth * 0.4)
        posterImage.layer.cornerRadius = 15
        posterImage.clipsToBounds = true
        
        
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            posterImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            posterImage.widthAnchor.constraint(equalToConstant: posterWidth),
            posterImage.heightAnchor.constraint(equalToConstant: posterWidth * 1.5)
        ])
    }
    
    func configureVC() {
        view.backgroundColor = .tertiarySystemBackground
    }
    
    func downloadPosterImage() {
        posterImage.downloadImage(movie: movie)
    }
    
    func configureTitleLabel() {
        titleLabel = UILabel(frame: .zero)
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = movie._title
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImage.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureDateLabel() {
        dateLabel = UILabel(frame: .zero)
        view.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.text = movie._releaseDate
        dateLabel.font = .boldSystemFont(ofSize: 16)
        dateLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: padding * 1.5)
        ])
    }
    
    func configureOverviewLabel() {
        overviewLabel = UILabel(frame: .zero)
        view.addSubview(overviewLabel)
        
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        overviewLabel.text = movie._overview
        overviewLabel.font = .systemFont(ofSize: 20)
        overviewLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: posterImage.bottomAnchor,constant: 2 * padding),
            overviewLabel.leadingAnchor.constraint(equalTo: posterImage.leadingAnchor),
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
            
        ])
    }
    
    func configurePopularityLabel() {
        popularityLabel = UILabel(frame: .zero)
        view.addSubview(popularityLabel)
        
        popularityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        popularityLabel.text = String("Popularity: \(movie._popularity)")
        popularityLabel.font = .systemFont(ofSize: 16)
        popularityLabel.textColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            popularityLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 2 * padding),
            popularityLabel.leadingAnchor.constraint(equalTo: posterImage.trailingAnchor, constant: padding),
            popularityLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        
        ])
    }
    
}

extension DetailsVC: UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = similarCollectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCell.similarId, for: indexPath) as! SimilarMovieCell
        
        similarCollectionView.backgroundColor = .tertiarySystemBackground
        return cell
    }
}

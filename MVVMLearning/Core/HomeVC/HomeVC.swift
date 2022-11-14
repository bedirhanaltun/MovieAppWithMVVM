//
//  HomeVC.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 14.10.2022.
//

import UIKit

protocol HomeVCProtocol: AnyObject {
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
    func pushToDetailVC(movie: MovieResults)
}

final class HomeVC: UIViewController {
    
    private let homeViewModel = HomeViewModel()
    private let detailsViewModel = DetailViewModel()
    
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeViewModel.view = self
        homeViewModel.viewDidLoad()
    }
}

extension HomeVC: HomeVCProtocol {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        
        //Storyboard ile uğraşmıyorken bu satırı yazmamız gerekiyor.
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MoviesCell.self, forCellWithReuseIdentifier: MoviesCell.reuseID)
        
        collectionView.pinToEdgesOf(view: view)
        
        
    }
    
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Popular Movies 🥳"
    }
    
    func reloadCollectionView() {
        collectionView.reloadOnMainThread()
    }
   
    func pushToDetailVC(movie: MovieResults) {
        DispatchQueue.main.async {
            let detailsVC = DetailsVC(movie: movie)
            self.navigationController?.pushViewController(detailsVC, animated: true)
            
        }
    }
    
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        homeViewModel.moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCell.reuseID, for: indexPath) as! MoviesCell
        
        cell.setCellImage(movie: homeViewModel.moviesList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeViewModel.getDetails(id: homeViewModel.moviesList[indexPath.item]._id)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (height * 2) {
            homeViewModel.getMovies()
        }
    }
    
    
}

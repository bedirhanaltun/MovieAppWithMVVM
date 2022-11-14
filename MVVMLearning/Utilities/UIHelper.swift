//
//  UIHelper.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 14.10.2022.
//

import UIKit

enum UIHelper {
    static func createHomeFlowLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: .deviceWidth , height: .deviceWidth * 1.5)
        layout.minimumLineSpacing = 40
        
        return layout
    }
    
    static func createSimilarFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: .deviceWidth / 3, height: (.deviceWidth / 3) * 2)
        layout.minimumLineSpacing = 30
        
        return layout
    }
}

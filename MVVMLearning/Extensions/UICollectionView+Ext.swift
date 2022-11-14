//
//  UICollectionView+Ext.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 15.10.2022.
//

import UIKit

extension UICollectionView {
    func reloadOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}

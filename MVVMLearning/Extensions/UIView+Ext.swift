//
//  UIView+Ext.swift
//  MVVMLearning
//
//  Created by Bedirhan Altun on 14.10.2022.
//

import UIKit

extension UIView {
    func pinToEdgesOf(view: UIView) {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            //Sol
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //Sağ
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}


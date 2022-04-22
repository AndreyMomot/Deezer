//
//  UIView.swift
//  Deezer
//
//  Created by Andrii Momot on 20.04.2022.
//

import UIKit

extension UIView {
    
    func fill(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

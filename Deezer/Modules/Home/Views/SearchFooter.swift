//
//  SearchFooter.swift
//  Deezer
//
//  Created by Andrii Momot on 23.04.2022.
//

import UIKit

final class SearchFooter: UIView {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureView()
    }
    
    override func draw(_ rect: CGRect) {
        label.frame = bounds
    }
    
    func setFooter(with count: Int) {
        if count == 0 {
            label.text = "No artists match your query"
            showFooter()
        } else {
            label.text = ""
            hideFooter()
        }
    }
        
    func hideFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 0.0
        }
    }
    
    func showFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 1.0
        }
    }
    
    func configureView() {
        backgroundColor = AppColor.background
        alpha = 0.0
        
        label.textAlignment = .center
        label.textColor = .white
        addSubview(label)
    }
}

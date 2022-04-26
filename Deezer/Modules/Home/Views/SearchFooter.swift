//
//  SearchFooter.swift
//  Deezer
//
//  Created by Andrii Momot on 23.04.2022.
//

import UIKit

final class SearchFooter: UIView {
    private let label = UILabel()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
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
        
    private func hideFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 0.0
        }
    }
    
    private func showFooter() {
        UIView.animate(withDuration: 0.7) {
            self.alpha = 1.0
        }
    }
    
    private func configureView() {
        backgroundColor = AppColor.background
        alpha = 0.0
        
        label.textAlignment = .center
        label.textColor = .white
        addSubview(label)
    }
}

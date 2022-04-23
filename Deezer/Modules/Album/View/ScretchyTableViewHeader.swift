//
//  ScretchyTableViewHeader.swift
//  Deezer
//
//  Created by Andrii Momot on 22.04.2022.
//

import UIKit

final class StretchyTableHeaderView: UIView {
    private var imageViewHeight = NSLayoutConstraint()
    private var imageViewBottom = NSLayoutConstraint()
    
    private var containerView: UIView!
    var imageView: LoadableImageView!
    
    private var containerViewHeight = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        setViewConstraints()        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func createViews() {
        // Container View
        containerView = UIView()
        self.addSubview(containerView)
        
        // ImageView for background
        imageView = LoadableImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = AppColor.background
        imageView.contentMode = .scaleAspectFill
        containerView.addSubview(imageView)
    }
    
    private func setViewConstraints() {
        // UIView Constraints
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            self.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            self.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        // Container View Constraints
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        // ImageView Constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageViewBottom.isActive = true
        imageViewHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageViewHeight.isActive = true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageViewBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageViewHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
}

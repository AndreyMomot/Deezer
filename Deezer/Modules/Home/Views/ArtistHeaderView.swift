//
//  ArtistHeaderView.swift
//  Deezer
//
//  Created by Andrii Momot on 23.04.2022.
//

import UIKit

final class ArtistHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppColor.background
        
        let label = UILabel()
        label.frame = CGRect(x: 5, y: 5, width: frame.width-10, height: frame.height-10)
        label.text = "Artists".uppercased()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .white
        
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

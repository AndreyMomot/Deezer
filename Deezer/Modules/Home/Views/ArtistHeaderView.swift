//
//  ArtistHeaderView.swift
//  Deezer
//
//  Created by Andrii Momot on 23.04.2022.
//

import UIKit

final class ArtistHeaderView: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = AppColor.background
        titleLabel.text = "Artists".uppercased()
    }
}

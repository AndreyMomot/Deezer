//
//  ArtistCell.swift
//  Deezer
//
//  Created by Andrii Momot on 21.04.2022.
//

import UIKit

class ArtistCell: UITableViewCell {
    
    @IBOutlet private weak var artistImageView: CustomImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        artistImageView.setupActivity()
        
    }
    
    func configure(with artist: Artist?) {
        nameLabel.text = artist?.name
        guard let imageUrl = artist?.picture else { return }
        artistImageView.loadImageWithUrl(urlString: imageUrl)
    }
}

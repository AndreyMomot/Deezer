//
//  ArtistCell.swift
//  Deezer
//
//  Created by Andrii Momot on 21.04.2022.
//

import UIKit

final class ArtistCell: UITableViewCell {
    
    @IBOutlet private weak var artistImageView: LoadableImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    func configure(with artist: Artist?) {
        nameLabel.text = artist?.name
        guard let imageUrl = artist?.picture else { return }
        artistImageView.loadImageWithUrl(urlString: imageUrl)
    }
}

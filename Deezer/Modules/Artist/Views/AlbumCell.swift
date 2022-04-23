//
//  AlbumCell.swift
//  Deezer
//
//  Created by Andrii Momot on 22.04.2022.
//

import UIKit

final class AlbumCell: UICollectionViewCell {
    
    @IBOutlet private weak var albumImageView: LoadableImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    func configure(with album: Album?) {
        titleLabel.text = album?.title ?? "Unknown"
        subtitleLabel.text = album?.artist?.name ?? "Unknown"
        guard let imageUrl = album?.cover else { return }
        albumImageView.loadImageWithUrl(urlString: imageUrl)
    }
    
}

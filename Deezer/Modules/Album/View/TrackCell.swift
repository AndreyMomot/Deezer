//
//  TrackCell.swift
//  Deezer
//
//  Created by Andrii Momot on 22.04.2022.
//

import UIKit

final class TrackCell: UITableViewCell {
    
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with track: Track?) {
        guard let index = track?.index else { return }
        numberLabel.text = "\(index)."
        titleLabel.text = track?.title
        subtitleLabel.text = track?.artist?.name
        
        guard let interval = track?.duration else { return }
        durationLabel.text = interval.convertToTime()
    }
}


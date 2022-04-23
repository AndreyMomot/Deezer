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
    
    func configure(with track: Track?) {
        titleLabel.text = track?.title
        subtitleLabel.text = track?.artist?.name
        
        if let index = track?.index {
            numberLabel.text = "\(index)."
        }
        
        if let interval = track?.duration {
            durationLabel.text = interval.convertToTime()
        }
    }
}


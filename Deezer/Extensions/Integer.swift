//
//  Integer.swift
//  Deezer
//
//  Created by Andrii Momot on 22.04.2022.
//

import Foundation

extension Int {
    
    func convertToTime() -> String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        let duration = formatter.string(from: TimeInterval(self))
        return duration
    }
}

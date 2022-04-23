//
//  HelpersTests.swift
//  DeezerTests
//
//  Created by Andrii Momot on 23.04.2022.
//

import XCTest
@testable import Deezer

class HelpersTests: XCTestCase {
    
    func testIntExtension() {
        let time = 62
        let convertedTime = time.convertToTime() ?? ""
        let correctAnswer = "1:02"
        XCTAssertEqual(convertedTime, correctAnswer, "Converted \(convertedTime) not equal to \(correctAnswer)")
    }
    
    func testCache() {
        let key = "tempKey"
        let cache = ImageCache.shared
        let image = UIImage(named: "swift") ?? UIImage()
        
        cache.save(image: image, forKey: key)
        
        let loaded = cache.getImage(forKey: key) ?? UIImage()
        
        XCTAssertEqual(image, loaded, "Images should be equal")
    }

}

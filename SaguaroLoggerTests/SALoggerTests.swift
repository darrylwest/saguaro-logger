//
//  SALoggerTests.swift
//  SaguaroLogger
//
//  Created by Darryl West on 6/20/15.
//  Copyright © 2015 darryl.west@raincitysoftware.com. All rights reserved.
//

import XCTest
@testable import SaguaroLogger

class SALoggerTests: XCTestCase {
    
    func testInstance() {
        let logger = SALogger(category:"SALoggerTests")
        
        XCTAssertNotNil(logger, "should not be nil")
        XCTAssertEqual(logger.level, LogLevel.Info, "should be info level")

    }
    
}

//
//  SALogManagerTests.swift
//  SaguaroLogger
//
//  Created by Darryl West on 6/9/15.
//  Copyright (c) 2015 darryl.west@raincitysoftware.com. All rights reserved.
//

import UIKit
import XCTest
import SaguaroLogger

class SALogManagerTests: XCTestCase {

    func testInstance() {
        let manager = SALogManager( domain:"TestDomain" )
        
        XCTAssertEqual(manager.domain, "TestDomain", "domain should match")
        XCTAssertEqual(manager.appenders.count, 0, "should be empty")
        XCTAssertEqual(manager.loggers.count, 0, "should be empty")
    }
    
    func testAddAppender() {
        let manager = SALogManager( domain:"TestDomain" )
        
        XCTAssertEqual(manager.appenders.count, 0, "should be empty")
        
        manager.addAppender(ConsoleLogAppender(level: .Info))
        
        XCTAssertEqual(manager.appenders.count, 1, "should have an appender")
    }
    
    func testRemoveAdapters() {
        let manager = SALogManager( domain:"TestDomain" )
        let adapter = ConsoleLogAppender(level: .Info)
        
        XCTAssertEqual(manager.appenders.count, 0, "should be empty")
        
        manager.addAppender( adapter )
        
        XCTAssertEqual(manager.appenders.count, 1, "should have an appender")
        
        let adap = manager.removeAppender( adapter )
        
        XCTAssertTrue(adap != nil, "should not be nil")
        XCTAssertEqual(manager.appenders.count, 0, "should be empty")
    }


}

//
//  SALogManagerTests.swift
//  SaguaroLogger
//
//  Created by Darryl West on 6/20/15.
//  Copyright © 2015 darryl.west@raincitysoftware.com. All rights reserved.
//

import XCTest
@testable import SaguaroLogger

class SALogManagerTests: XCTestCase {
    
    func createLoggers(_ manager: SALogManager) {
        for cat in [ "Flarb", "Another", "AThird", "AndTheLast"] {
            manager.createLogger( "\( cat )-\( arc4random() )" )
        }
    }
    
    func testInstance() {
        let manager = SALogManager( domain:"TestDomain" )
        
        XCTAssertEqual(manager.domain, "TestDomain", "domain should match")
        XCTAssertEqual(manager.appenders.count, 0, "should be empty")
        XCTAssertEqual(manager.loggers.count, 0, "should be empty")
    }
    
    func testAddAppender() {
        let manager = SALogManager( domain:"TestDomain" )
        
        XCTAssertEqual(manager.appenders.count, 0, "should be empty")
        
        manager.addAppender(ConsoleLogAppender(level: .info))
        
        XCTAssertEqual(manager.appenders.count, 1, "should have an appender")
    }
    
    func testFindAppenderByName() {
        let manager = SALogManager( domain:"TestDomain" )
        let appender = ConsoleLogAppender(level: LogLevel.debug)
        
        manager.addAppender(appender)
        
        let ap1 = manager.findAppenderByName( appender.name )
        
        XCTAssertEqual( ap1!.name, appender.name, "should find an apender")
        
        let ap2 = manager.findAppenderByName( "flarbenstien" )
        
        XCTAssertTrue( ap2 == nil, "should not find an apender")
    }
    
    func testCreateLogger() {
        let manager = SALogManager( domain:"TestDomain" )
        let logger = manager.createLogger("TestLogger", level: .warn)
        
        XCTAssertEqual(logger.category, "TestLogger", "category should match")
        XCTAssertEqual(logger.level, LogLevel.warn, "levels should match")
        
        XCTAssertEqual(manager.loggers.count, 1, "should have one logger")
        
        createLoggers( manager )
        
        XCTAssertEqual(manager.loggers.count, 5, "should have 5 logger")
    }
    
    func testFindLoggerByCategory() {
        let manager = SALogManager( domain:"TestDomain" )
        let logger = manager.createLogger("TestLogger", level: .warn)
        
        createLoggers( manager )
        
        XCTAssertEqual(manager.loggers.count, 5, "should have 5 logger")
        
        XCTAssertEqual(logger.category, "TestLogger", "category should match")
        XCTAssertEqual(logger.level, LogLevel.warn, "levels should match")
        
        let log = manager.findLoggerByCategory("TestLogger")
        XCTAssertEqual(log!.category, logger.category, "should find match")
    }
    
    
    func testSetAllLoggerLevels() {
        let manager = SALogManager( domain:"TestDomain" )
        let appender = ConsoleLogAppender(level: LogLevel.debug)
        
        manager.addAppender(appender)
        
        for appender in manager.appenders {
            XCTAssertEqual(appender.level, LogLevel.debug, "check error")
        }
        
        for logger in manager.loggers {
            XCTAssertEqual(logger.level, LogLevel.debug, "level check")
        }
        
        manager.setAllLevels( LogLevel.error )
        
        for appender in manager.appenders {
            XCTAssertEqual(appender.level, LogLevel.error, "check error")
        }
        
        for logger in manager.loggers {
            XCTAssertEqual(logger.level, LogLevel.error, "level check")
        }
    }
}


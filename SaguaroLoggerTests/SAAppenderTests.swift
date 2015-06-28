//
//  SAAppenderTests.swift
//  SaguaroLogger
//
//  Created by Darryl West on 6/20/15.
//  Copyright © 2015 darryl.west@raincitysoftware.com. All rights reserved.
//

import XCTest
@testable import SaguaroLogger

class SAAppenderTests: XCTestCase {
    
    func testAbastractLogAppender() {
        let appender = AbstractLogAppender()
        
        XCTAssertNotNil(appender, "should not be nil")
        XCTAssertEqual(appender.name, "AbstractLogAppender", "name check")
        XCTAssertEqual(appender.level, LogLevel.Debug, "should be debug level")
        
        appender.write("this is an empty message")
        
        let a2 = AbstractLogAppender(level: LogLevel.Warn, dateFormat: "mm:ss.SSS")
        XCTAssertEqual(a2.level, LogLevel.Warn, "should be warn level")
    }
    
    func testConsoleLogAppender() {
        let appender = ConsoleLogAppender()
        
        XCTAssertEqual(appender.name, "ConsoleLogAppender", "name check")
        XCTAssertEqual(appender.level, LogLevel.Debug, "should be debug level")
        
        let str = appender.format(category: "MyCategory", levelName: "debug", message: "my message")
        
        XCTAssertEqual(str.characters.count, 40, "character count")
        
        appender.level = LogLevel.Warn
        XCTAssertEqual(appender.level, LogLevel.Warn, "should be warn level")
        appender.level = LogLevel.Error
        XCTAssertEqual(appender.level, LogLevel.Error, "should be error level")
    }
    
    func testNSLogAppender() {
        let appender = NSLogAppender(level: .Debug)
        
        XCTAssertEqual(appender.name, "NSLogAppender", "name check")
        XCTAssertEqual(appender.level, LogLevel.Debug, "should be debug level")
        
        let msg = appender.format(category: "MyCategory", levelName: "debug", message: "my message")
        
        appender.write( msg )
        
        appender.level = LogLevel.Warn
        XCTAssertEqual(appender.level, LogLevel.Warn, "should be warn level")
        appender.level = LogLevel.Error
        XCTAssertEqual(appender.level, LogLevel.Error, "should be error level")
    }

    func testMockLogAppender() {
        let appender = MockLogAppender()
        
        XCTAssertEqual(appender.name, "MockLogAppender", "name check")
        XCTAssertEqual(appender.level, LogLevel.Debug, "should be debug level")
        
        XCTAssertEqual(appender.messages.count, 0, "message count should be zero")
        
        let msg = appender.format(category: "MyCategory", levelName: "debug", message: "my message")

        appender.write( msg )
        
        XCTAssertEqual(appender.messages.count, 1, "one message")
        
        appender.clear()
        XCTAssertEqual(appender.messages.count, 0, "message count should be zero")
    }
    
}

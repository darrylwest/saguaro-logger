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
    
    func writeLogStatements(log: SALogger) {
        log.debug("this is a debug statement test...")
        log.info("and an info test")
        log.warn("warning!")
        
        let fn = __FILE__.componentsSeparatedByString("/")
        log.error("this is an error in file: \( fn.last! ) in func: \( __FUNCTION__ ) on line \( __LINE__ )")
    }
    
    func testInstance() {
        let logger = SALogger(category:"SALoggerTests")
        
        XCTAssertNotNil(logger, "should not be nil")
        XCTAssertEqual(logger.level, LogLevel.Info, "should be info level")
        
        XCTAssertEqual(logger.appenderList.count, 1, "should have one appender")
        
        if let appender = logger.findAppenderByName("ConsoleLogAppender") {
            XCTAssertNotNil(appender.name, "should not be nil")
        } else {
            XCTFail("appender not found")
        }
        
        if let appender = logger.findAppenderByName("flarb") {
            print(appender.name)
            XCTFail("should not find a badly named appender")
        }
    }
    
    func testDebugLevel() {
        let log = SALogger(category:"DebugLogger", level: .Debug)
        
        XCTAssertNotNil(log, "should not be nil")
        XCTAssertEqual(log.level, LogLevel.Debug, "should be debug level")
        
        writeLogStatements( log )
    }
    
    func testWarnLevel() {
        let appender = MockLogAppender(level: .Warn)
        let log = SALogger(category:"WarnLogger", level: .Warn, appenders: [ appender ])
        
        XCTAssertNotNil(log, "should not be nil")
        XCTAssertEqual(log.level, LogLevel.Warn, "logger should be debug level")
        XCTAssertEqual(appender.level, LogLevel.Warn, "appender should be debug level")
        
        XCTAssertEqual( appender.messages.count, 0, "should be zero messages")
        
        writeLogStatements( log )
        
        // println( appender.messages )
        XCTAssertEqual( appender.messages.count, 2, "should be 2 messages")
    }
    
    func testMockLogAppender() {
        let appender = MockLogAppender(level: .Debug)
        let log = SALogger(category:"MockLogger", level: .Debug, appenders: [ appender ])
        
        XCTAssertNotNil(log, "should not be nil")
        XCTAssertEqual(log.level, LogLevel.Debug, "logger should be debug level")
        XCTAssertEqual(appender.level, LogLevel.Debug, "appender should be debug level")
        
        XCTAssertEqual( appender.messages.count, 0, "should be zero messages")
        
        writeLogStatements( log )
        
        // println( appender.messages )
        XCTAssertEqual( appender.messages.count, 4, "should be 4 messages")
    }

    func testFunctionParams() {
        let appender = MockLogAppender(level: .Debug)
        let log = SALogger(category:"MockLogger", level: .Debug, appenders: [ appender ])

        XCTAssertNotNil(log, "should not be nil")
        XCTAssertEqual(log.level, LogLevel.Debug, "logger should be debug level")
        XCTAssertEqual(appender.level, LogLevel.Debug, "appender should be debug level")

        XCTAssertEqual( appender.messages.count, 0, "should be zero messages")

        log.info("this is a test: %@", "my string")

        XCTAssertTrue( appender.messages[0].hasSuffix("my string") )

        log.warn("this is a number: %x", 12345)
        print( appender.messages )
        XCTAssertTrue( appender.messages[1].hasSuffix("3039"))

        log.error("this is a number: %d", 12345)
        print( appender.messages )
        XCTAssertTrue( appender.messages[2].hasSuffix("12345"))
    }
    
    func testMultipleAppenders() {
        let mock = MockLogAppender(level: .Debug)
        let appenders:[ LogAppenderType ] = [ mock, ConsoleLogAppender(level: .Info) ]
        let log = SALogger(category:"MockLogger", level: .Debug, appenders: appenders)
        
        XCTAssertNotNil(log, "should not be nil")
        XCTAssertEqual(log.level, LogLevel.Debug, "logger should be debug level")
        
        XCTAssertEqual( mock.messages.count, 0, "should be zero messages")
        
        writeLogStatements( log )
        
        // println( appender.messages )
        XCTAssertEqual( mock.messages.count, 4, "should be 4 messages")
    }
    
    func testNSLogAppender() {
        
        let log = SALogger(category: "NSTest", level: .Info, appenders:[ NSLogAppender() ])
        
        XCTAssertNotNil( log, "should not be nil" )
        
        log.info("my NS log message")
    }
    
}

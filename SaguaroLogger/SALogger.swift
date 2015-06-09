//
//  SALogger.swift
//  SaguaroLogger
//
//  Created by Darryl West on 6/9/15.
//  Copyright (c) 2015 darryl.west@raincitysoftware.com. All rights reserved.
//

import Foundation

public enum LogLevel: Int {
    case Trace, Debug, Info, Warn, Error, Off
}

public protocol Logger {
    var isDebug:Bool { get }
    func debug(msg:String)
    func info(msg:String)
    func warn(msg:String)
    func error(msg:String)
    var level:LogLevel { get set }
    var appenderList:[ LogAppenderType ] { get }
    func findAppenderByName(name: String) -> LogAppenderType?
}

public protocol LogAppenderType {
    var name:String { get }
    func format(category cat:String, levelName name:String, message msg:String) -> String
    func write(msg: String) -> Void
    var level:LogLevel { get set }
}

public class AbstractLogAppender {
    let dateFormatter: NSDateFormatter
    public var level:LogLevel
    
    public func format(category cat:String, levelName name: String, message msg: String) -> String {
        let dt = dateFormatter.stringFromDate( NSDate() )
        let str = "\( cat ) \( dt ) \( name ) \( msg )"
        
        return str
    }
    
    public func write(msg:String) {
        // noop
    }
    
    public init(level:LogLevel, dateFormat:String? = "HH:mm:ss.SSS") {
        self.level = level
        
        self.dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = dateFormat!
    }
}

public class ConsoleLogAppender: AbstractLogAppender, LogAppenderType {
    public let name:String = "ConsoleLogAppender"
    
    override public func write(msg:String) {
        println( msg )
    }
}

public class MockLogAppender: AbstractLogAppender, LogAppenderType {
    public let name:String = "MockLogAppender"
    public var messages = [String]()
    
    override public func write(msg: String) {
        self.messages.append( msg )
    }
}

// TODO: file appender, rolling file appender, remote appender, web socket appender
// TODO: ability to add and remove appenders

public class SALogger: Logger {
    private var appenders:[ LogAppenderType ]
    public let category: String
    public var level: LogLevel
    
    private func log(levelName:String, _ msg:String) {
        // loop through the log appenders and send out...
        for appender in appenders {
            if appender.level.rawValue <= self.level.rawValue {
                appender.write( appender.format( category:category, levelName:levelName, message:msg ))
            }
        }
    }
    
    public var isDebug:Bool {
        return level.rawValue <= LogLevel.Debug.rawValue
    }
    
    public func debug(msg: String) {
        if isDebug {
            log("debug", msg)
        }
    }
    
    public func info(msg: String) {
        if level.rawValue <= LogLevel.Info.rawValue {
            log("info ", msg)
        }
    }
    
    public func warn(msg: String) {
        if level.rawValue <= LogLevel.Warn.rawValue {
            log("warn ", msg)
        }
    }
    
    public func error(msg: String) {
        log("error", msg)
    }
    
    public var appenderList:[ LogAppenderType ] {
        return appenders
    }
    
    public func findAppenderByName(name: String) -> LogAppenderType? {
        for appender in appenders {
            if appender.name == name {
                return appender
            }
        }
        
        return nil
    }
    
    public convenience init(category: String) {
        var lvl = LogLevel.Info
        var app = [ ConsoleLogAppender(level: lvl) as LogAppenderType ]
        self.init(category: category, level: lvl, appenders: app )
    }
    
    public convenience init(category: String, level:LogLevel) {
        var app = [ ConsoleLogAppender(level: level) as LogAppenderType ]
        self.init(category: category, level: level, appenders: app)
    }
    
    /**
    create a default info level logger with console appender; appender is created at the same level
    */
    public init(category: String, level:LogLevel = .Info, appenders:[LogAppenderType]) {
        self.category = category
        
        self.level = level
        
        self.appenders = appenders
    }
}
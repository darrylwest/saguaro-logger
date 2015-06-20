//
//  SALogger.swift
//  SaguaroLogger
//
//  Created by Darryl West on 6/20/15.
//  Copyright © 2015 darryl.west@raincitysoftware.com. All rights reserved.
//

import Foundation

public enum LogLevel: Int {
    case Trace, Debug, Info, Warn, Error, Off
}

public protocol Logger {
    var category:String { get }
    var isDebug:Bool { get }
    func debug(msg:String)
    func info(msg:String)
    func warn(msg:String)
    func error(msg:String)
    var level:LogLevel { get set }
    var appenderList:[ LogAppenderType ] { get }
    func findAppenderByName(name: String) -> LogAppenderType?
}

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
        let lvl = LogLevel.Info
        let apps = [ ConsoleLogAppender(level: lvl) as LogAppenderType ]
        self.init(category: category, level: lvl, appenders: apps )
    }
    
    public convenience init(category: String, level:LogLevel) {
        let app = [ ConsoleLogAppender(level: level) as LogAppenderType ]
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
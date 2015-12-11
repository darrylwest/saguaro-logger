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
    func debug(msg:String, _ obj:Any...)
    func info(msg: String, _ obj:Any...)
    func warn(msg: String, _ obj:Any...)
    func error(msg: String, _ obj:Any...)
    var level:LogLevel { get set }
    var appenderList:[ LogAppenderType ] { get }
    func findAppenderByName(name: String) -> LogAppenderType?
}

public class SALogger: Logger {
    private var appenders:[ LogAppenderType ]
    final public let category: String
    final public var level: LogLevel
    
    private func log(levelName:String, _ msg:String) {
        // loop through the log appenders and send out...
        for appender in appenders {
            if appender.level.rawValue <= self.level.rawValue {
                appender.write( appender.format( category:category, levelName:levelName, message:msg ))
            }
        }
    }
    
    final public var isDebug:Bool {
        return level.rawValue <= LogLevel.Debug.rawValue
    }
    
    final public func debug(msg: String, _ obj:Any...) {
        if isDebug {
            log("DEBUG", msg)
        }
    }
    
    final public func info(msg: String, _ obj:Any...) {
        if level.rawValue <= LogLevel.Info.rawValue {
            log("INFO ", msg)
        }
    }
    
    final public func warn(msg: String, _ obj:Any...) {
        if level.rawValue <= LogLevel.Warn.rawValue {
            log("WARN ", msg)
        }
    }
    
    final public func error(msg: String, _ obj:Any...) {
        log("ERROR", msg)
    }
    
    final public var appenderList:[ LogAppenderType ] {
        return appenders
    }
    
    final public func findAppenderByName(name: String) -> LogAppenderType? {
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
    public init(category: String, level:LogLevel, appenders:[LogAppenderType]) {
        self.category = category
        
        self.level = level
        
        self.appenders = appenders
    }
}
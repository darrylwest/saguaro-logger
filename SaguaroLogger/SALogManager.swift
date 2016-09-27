//
//  SALogManager.swift
//  SaguaroLogger
//
//  Created by Darryl West on 6/20/15.
//  Copyright © 2015 darryl.west@raincitysoftware.com. All rights reserved.
//

import Foundation

open class SALogManager {
    open let domain:String
    
    open fileprivate(set) var appenders:[LogAppenderType] = [LogAppenderType]()
    open fileprivate(set) var loggers:[Logger] = [Logger]()

    public init(domain:String) {
        self.domain = domain
    }

    open func addAppender(_ appender: LogAppenderType) -> LogAppenderType {
        appenders.append( appender )
        
        // add this appender to all current loggers
        
        return appender
    }
    
    /// set the level to all appenders
    open func setAppenderLevels(_ level:LogLevel) {
        for var appender in appenders {
            appender.level = level
        }
    }
    
    /// set the level of all loggers
    open func setLoggerLevels(_ level:LogLevel) {
        for var logger in loggers {
            logger.level = level
        }
    }
    
    /// set the level of all appenders and loggers
    open func setAllLevels(_ level:LogLevel) {
        setLoggerLevels( level )
        setAppenderLevels( level )
    }
    
    open func findAppenderByName(_ name: String) -> LogAppenderType? {
        for appender in appenders {
            if appender.name == name {
                return appender
            }
        }
        
        return nil
    }
    
    open func findLoggerByCategory(_ category: String) -> Logger? {
        for logger in loggers {
            if logger.category == category {
                return logger
            }
        }
        
        return nil
    }
    
    open func createLogger(_ category:String, level:LogLevel? = .info) -> Logger {
        var logger:Logger? = self.findLoggerByCategory(category)
        
        if logger == nil {
            logger = SALogger(category: category, level: level!, appenders: appenders )
        }
        
        loggers.append( logger! )
        
        return logger!;
    }

}

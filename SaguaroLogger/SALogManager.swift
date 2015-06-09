//
//  SALogManager.swift
//  SaguaroLogger
//
//  Created by Darryl West on 6/9/15.
//  Copyright (c) 2015 darryl.west@raincitysoftware.com. All rights reserved.
//

import Foundation

public class SALogManager {
    public let domain:String
    
    public private(set) var appenders:[LogAppenderType] = [LogAppenderType]()
    public private(set) var loggers:[Logger] = [Logger]()
    
    public func addAppender(appender: LogAppenderType) -> LogAppenderType {
        appenders.append( appender )
        
        // add this appender to all current loggers
        
        return appender
    }
    
    public func removeAppender(appender: LogAppenderType) -> LogAppenderType? {
        
        var idx:Int = -1
        
        // find the index
        for (index, ap) in enumerate( appenders ) {
            if ap.name == appender.name {
                idx = index
            }
        }
        
        if idx >= 0 {
            appenders.removeAtIndex( idx )
        }

        return appender
    }
    
    public func findAppenderByName(name: String) -> LogAppenderType? {
        for appender in appenders {
            if appender.name == name {
                return appender
            }
        }
        
        return nil
    }
    
    public func findLoggerByCategory(category: String) -> Logger? {
        for logger in loggers {
            if logger.category == category {
                return logger
            }
        }
        
        return nil
    }
    
    public func createLogger(category:String, level:LogLevel? = .Info) -> Logger {
        var logger:Logger? = self.findLoggerByCategory(category)
        
        if logger == nil {
            logger = SALogger(category: category, level: level!, appenders: appenders )
        }
        
        loggers.append( logger! )
        
        return logger!;
    }
    
    public init(domain:String) {
        self.domain = domain
    }
}
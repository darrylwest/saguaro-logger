//
//  SALogManager.swift
//  SaguaroLogger
//
//  Created by Darryl West on 6/20/15.
//  Copyright © 2015 darryl.west@raincitysoftware.com. All rights reserved.
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

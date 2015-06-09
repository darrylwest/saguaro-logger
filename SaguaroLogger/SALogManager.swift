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
        var appender:LogAppenderType?
        
        return appender
    }
    
    public func createLogger(category:String, level:LogLevel? = .Info) -> Logger {
        var logger = SALogger(category: category, level: level!, appenders: appenders )
        
        return logger;
    }
    
    public init(domain:String) {
        self.domain = domain
    }
}
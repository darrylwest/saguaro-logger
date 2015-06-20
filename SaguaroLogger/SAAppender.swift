//
//  SAAppender.swift
//  SaguaroLogger
//
//  Created by Darryl West on 6/20/15.
//  Copyright © 2015 darryl.west@raincitysoftware.com. All rights reserved.
//

import Foundation

public protocol LogAppenderType {
    var name:String { get }
    func format(category cat:String, levelName name:String, message msg:String) -> String
    func write(msg: String) -> Void
    var level:LogLevel { get set }
}

/*
public class AbstractLogAppender {
    let dateFormatter: NSDateFormatter
    public var level:LogLevel
    
    public func format(category cat:String, levelName name: String, message msg: String) -> String {
        let dt = dateFormatter.stringFromDate( NSDate() )
        let str = "\( dt ) \( cat ) \( name ) \( msg )"
        
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
        print( msg )
    }
}

public class MockLogAppender: AbstractLogAppender, LogAppenderType {
    public let name:String = "MockLogAppender"
    public var messages = [String]()
    
    override public func write(msg: String) {
        self.messages.append( msg )
    }
}
*/

// TODO: file appender, rolling file appender, remote appender, web socket appender
// TODO: ability to add and remove appenders
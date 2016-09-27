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
    func write(_ msg: String) -> Void
    
    var level:LogLevel { get set }
}

open class AbstractLogAppender: LogAppenderType {
    open var name:String {
        return "AbstractLogAppender"
    }
    
    let dateFormatter: DateFormatter
    open var level:LogLevel
    
    open func format(category cat:String, levelName name: String, message msg: String) -> String {
        let dt = dateFormatter.string( from: Date() )
        let str = "\( dt ) \( cat ) \( name ) \( msg )"
        
        return str
    }
    
    open func write(_ msg:String) {
        // noop
    }
    
    public init(level:LogLevel? = .debug, dateFormat:String? = "HH:mm:ss.SSS") {
        self.level = level!
        
        self.dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat!
    }
}

public final class ConsoleLogAppender: AbstractLogAppender {
    override public var name:String {
        return "ConsoleLogAppender"
    }
    
    override public func write(_ msg:String) {
        print( msg )
    }
}

public final class NSLogAppender: LogAppenderType {
    public var name:String {
        return "NSLogAppender"
    }
    
    public var level:LogLevel
    
    public func format(category cat:String, levelName name: String, message msg: String) -> String {
        let str = "\( cat ) \( name ) \( msg )"
        
        return str
    }
    
    public func write(_ msg:String) {
        NSLog( msg )
    }
    
    public init(level:LogLevel? = .debug) {
        self.level = level!
    }
}

public final class MockLogAppender: AbstractLogAppender {
    override public var name:String {
        return "MockLogAppender"
    }
    
    public var messages = [String]()
    public func clear() {
        messages.removeAll()
    }
    
    override public func write(_ msg: String) {
        self.messages.append( msg )
    }
}


// TODO: file appender, rolling file appender, remote appender, web socket appender

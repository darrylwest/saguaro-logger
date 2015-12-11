# Saguaro Logger 

_A swift 2.0 multi-level, multi-target logger for iOS/OSX applications_

<a href="https://developer.apple.com/swift/"><img src="http://raincitysoftware.com/swift2-badge.png" alt="" width="65" height="20" border="0" /></a>
[![Build Status](https://travis-ci.org/darrylwest/saguaro-logger.svg?branch=master)](https://travis-ci.org/darrylwest/saguaro-logger)

## Features

* log levels: debug, info, warn, error, and off levels
* log message includes category (class name)
* flexible formatters with default to `category HH:mm:ss.SSS LEVEL message`
* appenders to specify targets like console, file, rolling file, websockets, json, etc
* ability to change log levels on the fly by category or appender target
* simple protocol gives the ability to easily create add custom appenders
* log manager to create a pool of managed logs

## Installation

* cocoapods (unpublished, so pull from repo)
* git subproject/framework (from repo)

## How to use

### The simplest uses case:

```
// create a console logger with the default info log level
let log = SALogger( category: "MyCategory" )

log.info("hex message: %x", 15) // 13:34:44.244 MyCategory info hex message: ff
// .. <other code> ..
log.warn("warning: %@", "scary!") // 13:34:45.533 MyCategory warning: scary!
```

### A simple logger that writes to NSLog:

_Note: NSLog is buggy, and should not be use it for production builds..._

```
let log = SALogger( category: "MyNSCat", level: .Info, appenders: [ NSLogAppender() ])

log.info("my NS log message") 
// 2015-06-20 12:22:53.244 xctest[10994:981258] NSTest info  my NS log message
```

### Using the log manager to control a pool of loggers and appenders:

```
let manager = SALogManager( domain: "My Domain")
manager.addAppender( ConsoleLogAppender() )
manager.addAppender( FileLogAppender(level: .Warn, file: "warnings.log") )

// then some factory accesses the manager to create loggers
log = manager.createLogger("MyCategory", level:.Debug)

```

## License: MIT

Use as you wish.  Please fork and help out if you can.

- - -
darryl.west@raincitysoftware.com | Version 00.91.21

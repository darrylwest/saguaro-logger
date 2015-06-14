# Saguaro Logger
_A swift multi-level, multi-target logger for iOS/OSX applications_

## Features

* log levels: trace, debug, info, warn, error levels
* log message includes category (class name)
* flexible formatters with default to `category HH:mm:ss.SSS LEVEL message`
* appenders to specify targets like console, file, rolling file, websockets, json, etc
* ability to change log levels on the fly by category or appender target
* simple protocol gives the ability to easily create add custom appenders
* log manager to create a pool of managed logs

## Installation

* cocoapods (from repo)
* git subproject/framework (from repo)

## How to use

The simplest uses case:

```
// create a console logger with the default info log level
let log = SALogger( "MyCategory" )

log.info("this is a message") // 13:34:44.244 MyCategory info this is a message
// .. <other code> ..
log.warn("a warning")         // 13:34:45.533 MyCategory warn a warning
```

Using the log manager to control a pool of loggers and appenders:

```
let manager = SALogManager("My Domain")
manager.addAppender( ConsoleLogAppender(level: .Debug) )
manager.addAppender( FileLogAppender(level: .Warn, file: "warnings.log") )

// .. 

log = manager.createLogger("MyCategory", level:.Debug)

```

## License: MIT

Use as you wish.  Please fork and help out if you can.

- - -
darryl.west@raincitysoftware.com | Version 00.90.13

# Saguaro Logger
_A multi-level, multi-target logger for iOS/OSX applications_

## Features

* log levels: trace, debug, info, warn, error levels
* log message includes category (class name)
* flexible formatters with default to `category HH:mm:ss.SSS LEVEL message`
* appenders to specify targets like console, file, rolling file, websockets, json, etc
* ability to change log levels on the fly by category or appender target
* simple protocol gives the ability to easily create add custom appenders
* log manager to create a pool of managed logs

## Installation

* cocoapods
* git subproject/framework

## How to use

```
// create a console logger with the default info log level
let log = SALogger().createLogger( "MyCategory" )

log.info("this is a message") // MyCategory 13:34:44.244 info this is a message
// .. <other code> ..
log.warn("a warning")         // MyCategory 13:34:45.533 warn a warning
```

- - -
darryl.west@raincitysoftware.com | Version 00.90.11

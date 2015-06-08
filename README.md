# saguaro logger
_A multi-level logger for iOS/OSX applications_

## Features

* log levels: trace, debug, info, warn, error and fatal levels
* flexible formatters with default to `category HH:MM:ss.SSS LEVEL message`
* appenders to specify targets like console, file, rolling file, websockets, etc
* ability to change log levels on the fly
* domain and category attributes
* ability to add custom appenders

## Installation

* cocoapods
* git subproject/framework

## How to use

```
// create a logger with the default log level
let log = SALogger().createLogger( "MyCategory" )

log.info("this is a message") // MyCategory 13:34:44.244 info this is a message
// .. <other code> ..
log.warn("a warning")         // MyCategory 13:34:45.533 warn a warning
```

- - -
darryl.west@raincitysoftware.com | Version 00.90.101
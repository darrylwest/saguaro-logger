
PROJECT = SaguaroLogger
PLATFORM = 'platform=iOS Simulator,name=iPhone 6,OS=9.0'

all:
	@make test

clean:
	xcodebuild -project $(PROJECT).xcodeproj -scheme "$(PROJECT)" clean

test:
<<<<<<< HEAD
	xcodebuild test -project $(PROJECT).xcodeproj -scheme $(PROJECT) -destination $(PLATFORM) | xcpretty -c
=======
	xcodebuild -project $(PROJECT).xcodeproj -scheme "$(PROJECT)" -sdk iphonesimulator -destination $(PLATFORM) test | xcpretty -c
	@( pod lib lint --quick )

build:
	xcodebuild -project $(PROJECT).xcodeproj -scheme "$(PROJECT)" -sdk iphonesimulator -destination $(PLATFORM) build
>>>>>>> 5831d9f48d3ae01ebe3db70a13383bd2cf162b62

watch:
	@( ./watcher.js )

version:
	@( pod lib lint --quick )

.PHONY:	test
.PHONY:	version
.PHONY:	publish


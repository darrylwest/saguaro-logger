
PROJECT = SaguaroLogger
PLATFORM = 'platform=iOS Simulator,name=iPhone 6,OS=9.1'

all:
	@make test

clean:
	xcodebuild -project $(PROJECT).xcodeproj -scheme "$(PROJECT)" clean

test:
	xcodebuild -project $(PROJECT).xcodeproj -scheme "$(PROJECT)" -sdk iphonesimulator -destination $(PLATFORM) test | xcpretty -c
	@( pod lib lint --quick )

build:
	xcodebuild -project $(PROJECT).xcodeproj -scheme "$(PROJECT)" -sdk iphonesimulator -destination $(PLATFORM) build

watch:
	@( ./watcher.js )

version:
	@( pod lib lint --quick )

.PHONY:	test
.PHONY:	version
.PHONY:	publish


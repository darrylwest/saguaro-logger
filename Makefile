
PROJECT = SaguaroLogger
PLATFORM = 'platform=iOS Simulator,name=iPhone 6,OS=9.0'

all:
	@make test

test:
	xcodebuild test -project $(PROJECT).xcodeproj -scheme "$(PROJECT)" -destination $(PLATFORM) | xcpretty -c
	pod lib lint --quick

watch:
	@( ./watcher.js )

version:
	@( echo "what?" )

.PHONY:	test
.PHONY:	version
.PHONY:	publish


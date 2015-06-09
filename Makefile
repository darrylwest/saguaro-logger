
PROJECT = SaguaroLogger
PLATFORM = 'platform=iOS Simulator,name=iPhone 6,OS=8.3'

all:
	@make test

test:
	xcodebuild test -project $(PROJECT).xcodeproj -scheme $(PROJECT) -destination $(PLATFORM)

watch:
	@( ./watcher.js )

version:
	@( echo "what?" )

.PHONY:	test
.PHONY:	version
.PHONY:	publish


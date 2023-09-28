set -eo pipefail

xcodebuild -workspace Example/CollectionExtension.xcworkspace \
            -scheme CollectionExtension-Example \
            -destination platform=iOS\ Simulator,OS=16.1,name=iPhone\ 14 \
            clean test | xcpretty
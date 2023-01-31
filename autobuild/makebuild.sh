#!/bin/bash

#export PROJECTNAME=${1}
export WORKSPACE=$PWD

#xcodebuild -workspace "Basic Example.xcworkspace" -scheme "Basic Example" -destination "platform=iOS Simulator,name=iPhone 8 Plus" 

#xcodebuild -workspace "Basic Example.xcworkspace" -scheme "Basic Example"  -sdk iphoneos16.2  -archivePath "${WORKSPACE}/Build/BasicApp.xcarchive" archive
xcodebuild -exportArchive -archivePath "${WORKSPACE}/Build/BasicApp.xcarchive" -exportPath "${WORKSPACE}/Build/BasicFolder" -allowProvisioningUpdates -exportOptionsPlist "${WORKSPACE}/ExportOptions.plist"
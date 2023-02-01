#!/bin/bash

# do this iin root folder > export WORKSPACE=$PWD
#Eg Usage:
# ../autobuild/makebuild.sh -list
# ../autobuild/makebuild.sh -run "Basic Example" C39E0F97-9DA6-41D0-9A95-76A8544BE7CD com.bitheads.Example-Basic
# ../autobuild/makebuild.sh -pack "Basic Example"
# ../autobuild/makebuild.sh -run  "brainCloudSwiftUI" 5DF2472F-B32F-4636-9993-4563E0979EDD com.bitheads.brainCloudSwiftUI
# ../autobuild/makebuild.sh -pack  "brainCloudSwiftUI" 

# xcworkspace 
PROJECTNAME=${2}
# from xcode
SCHEME=${PROJECTNAME}
# from list
DEVICE=${3}
# from xcode
BUNDLE=$(echo "${PROJECTNAME}" |  sed 's/ //g')


SDK='iphoneos16.2'

if  [ ${1} == -list ]
then
	xcrun simctl list
	xcodebuild -showsdks
else if  [ ${1} == -run ]
then
	# eg. to run in simulator
	xcodebuild -workspace "${PROJECTNAME}.xcworkspace" -scheme "${SCHEME}" -destination "id=${DEVICE}" SYMROOT="${WORKSPACE}/Build/"
	xcrun simctl boot ${DEVICE}
	xcrun simctl install ${DEVICE} "${WORKSPACE}/Build/Debug-iphonesimulator/${PROJECTNAME}.app"
	xcrun simctl launch ${DEVICE} "${BUNDLE}"
else if  [ ${1} == -pack ]
then
	# to generate .ipa package for ios deployment
	xcodebuild -workspace "${PROJECTNAME}.xcworkspace" -scheme "${SCHEME}"  -sdk ${SDK}  -archivePath "${WORKSPACE}/Build/${PROJECTNAME}.xcarchive" archive
	xcodebuild -exportArchive -archivePath "${WORKSPACE}/Build/${PROJECTNAME}.xcarchive" -exportPath "${WORKSPACE}/Build/${PROJECTNAME}Export" -allowProvisioningUpdates -exportOptionsPlist "./ExportOptions.plist"
else
	echo Choose -list, -run or -pack.
fi
fi
fi
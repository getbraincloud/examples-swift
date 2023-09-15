#!/bin/bash

# do this iin root folder > export WORKSPACE=$PWD
#Eg Usage:
# ../autobuild/makebuild.sh -list
# ../autobuild/makebuild.sh -run "Basic Example" C39E0F97-9DA6-41D0-9A95-76A8544BE7CD
# ../autobuild/makebuild.sh -pack "Basic Example"
# ../autobuild/makebuild.sh -run  "brainCloudSwiftUI" 5DF2472F-B32F-4636-9993-4563E0979EDD
# ../autobuild/makebuild.sh -pack  "brainCloudSwiftUI" 

if [ -z ${WORKSPACE} ]
then
echo 'Please set workspace environment.'
exit 2
fi

# xcworkspace matches bundle name
PROJECTNAME=${2}
# from xcode project
SCHEME=${PROJECTNAME}
# from list
DEVICE=${3}
# from xcode project
BUNDLE=com.bitheads.$(echo "${PROJECTNAME}" |  sed 's/ //g')
SDK='iphoneos16.4'

case "$1" in
    -list)
		xcodebuild -showsdks
		xcrun xctrace list devices
		;;
	-clean)
		xcodebuild clean		
		xcodebuild -workspace "${PROJECTNAME}.xcworkspace" -scheme "${SCHEME}" -destination "id=$DEVICE" SYMROOT="${WORKSPACE}/Build/"
		;;
	-build)
		xcodebuild -workspace "${PROJECTNAME}.xcworkspace" -scheme "${SCHEME}" -destination "id=$DEVICE" SYMROOT="${WORKSPACE}/Build/"
		;;
 	-run)
		# eg. to run in simulator
		xcodebuild -workspace "${PROJECTNAME}.xcworkspace" -scheme "${SCHEME}" -destination "id=${DEVICE}" SYMROOT="${WORKSPACE}/Build/"
		xcrun simctl shutdown ${DEVICE}
		xcrun simctl erase ${DEVICE}
		xcrun simctl boot ${DEVICE}
		xcrun simctl install ${DEVICE} "${WORKSPACE}/Build/Debug-iphonesimulator/${PROJECTNAME}.app"
		xcrun simctl launch ${DEVICE} "${BUNDLE}"
		;;
	-pack)
		# to generate .ipa package for ios deployment
		xcodebuild -workspace "${PROJECTNAME}.xcworkspace" -scheme "${SCHEME}"  -sdk ${SDK}  -archivePath "${WORKSPACE}/Build/${PROJECTNAME}.xcarchive" archive
		xcodebuild -exportArchive -archivePath "${WORKSPACE}/Build/${PROJECTNAME}.xcarchive" -exportPath "${WORKSPACE}/Build/${PROJECTNAME}-Export" -allowProvisioningUpdates -exportOptionsPlist "./ExportOptions.plist"
		;;
	 *)
        echo Choose -list, -run or -pack.
        exit 1
 
esac
exit 0

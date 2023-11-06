#!/bin/bash

# do this in root folder > export WORKSPACE=$PWD
#Eg Usage:
# ../autobuild/makebuild.sh -list "Basic Example"

# ../autobuild/makebuild.sh -build bcchat "platform=iOS Simulator,name=iPhone 8 Plus"
#     or "platform=OS X,arch=arm64", or "generic/platform=iOS", or "id=263BA950-9A09-4A6E-82E9-BFF76D53B3FF"
#     output is: ${WORKSPACE}/Build/Debug-iphonesimulator/bcchat.app

# ../autobuild/makebuild.sh -run "brainCloudSwiftUI" C39E0F97-9DA6-41D0-9A95-76A8544BE7CD

# ../autobuild/makebuild.sh -pack  "Basic Example"
# ../autobuild/makebuild.sh -upload  "Basic Example"
#     output is: "${WORKSPACE}/Build/Basic Example-Export/Basic Example.ipa"

if [ -z "${WORKSPACE}" ];
then
echo 'Please set workspace environment.'
exit 2
fi

# xcworkspace matches bundle name
PROJECTNAME=${2}
# from xcode project
SCHEME=${PROJECTNAME}
# from list device / available destinations for scheme
DEVICE=${3}
PLATFORM=${3}
BUILD_CONFIG=Debug
TEAM_ID=3HU3N8Z2U7

# using xcode project name (remove spaces)
BUNDLENAME=$(echo "${PROJECTNAME}" |  sed 's/ //g')


case "$1" in
    -list)
		xcodebuild -showsdks
		xcrun simctl list
		xcodebuild build -workspace "${PROJECTNAME}.xcworkspace" -scheme "${SCHEME}" -showdestinations
		;;
	-clean)
    rm -rf "${WORKSPACE}/Build/"
    rm -rf "~/Library/Developer/Xcode/DerivedData/$(echo "${PROJECTNAME}" |  sed 's/ /_/g')*"
		xcodebuild clean
		;;
	-build)
		xcodebuild build -workspace "${PROJECTNAME}.xcworkspace" -scheme "${SCHEME}" -destination "${PLATFORM}" -configuration $BUILD_CONFIG DEVELOPMENT_TEAM=$TEAM_ID SYMROOT="${WORKSPACE}/Build/${PROJECTNAME}-Build" -allowProvisioningUpdates
		;;
 	-run)
		# eg. to run in simulator
		xcodebuild build -workspace "${PROJECTNAME}.xcworkspace" -scheme "${SCHEME}" -destination "id=${DEVICE}" -configuration $BUILD_CONFIG SYMROOT="${WORKSPACE}/Build/${PROJECTNAME}-Build"
		#xcrun simctl shutdown ${DEVICE}
		#xcrun simctl erase ${DEVICE}
		xcrun simctl boot ${DEVICE}
		xcrun simctl install ${DEVICE} "${WORKSPACE}/Build/${PROJECTNAME}-Build/Debug-iphonesimulator/${PROJECTNAME}.app"
		xcrun simctl launch ${DEVICE} "com.bitheads.${BUNDLENAME}"
		;;
	-pack)
		# to generate .ipa package for ios deployment
		xcodebuild -workspace "${PROJECTNAME}.xcworkspace" -scheme "${SCHEME}" -destination "${PLATFORM}" DEVELOPMENT_TEAM=$TEAM_ID -archivePath "${WORKSPACE}/Build/${PROJECTNAME}.xcarchive" archive
		xcodebuild -exportArchive -archivePath "${WORKSPACE}/Build/${PROJECTNAME}.xcarchive" -exportPath "${WORKSPACE}/Build/${PROJECTNAME}-Export" -allowProvisioningUpdates -exportOptionsPlist "./ExportOptions.plist"
		;;
	-upload)
		if [ -z "$BRAINCLOUD_TOOLS" ];
		then
  			export BRAINCLOUD_TOOLS=~/braincloud-client-master
		fi

		if ! [ -d "${BRAINCLOUD_TOOLS}/bin" ];
		then
		    echo "Error: Can't find brainCloud tools in path ${BRAINCLOUD_TOOLS}"
    		exit 1
		fi
		${BRAINCLOUD_TOOLS}/bin/upload-package.sh "${WORKSPACE}/Build/${PROJECTNAME}-Export/${PROJECTNAME}.ipa"
		;;
	 *)
        echo Choose -list, -run or -pack.
        exit 1
 
esac
exit 0

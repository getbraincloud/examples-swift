#!/bin/bash
# run this in your project root folder

if [ -z "$BRAINCLOUD_TOOLS" ];
then
  export BRAINCLOUD_TOOLS=~/braincloud-client-master
fi

if ! [ -d "${BRAINCLOUD_TOOLS}/bin" ];
then
    echo "Error: Can't find brainCloud tools in path ${BRAINCLOUD_TOOLS}"
    exit 1
fi

if [ -z $1 ];
then
  if [ -z $SERVER_ENVIRONMENT ];
  then
    SERVER_ENVIRONMENT=internal
  fi
else
  SERVER_ENVIRONMENT=$1
fi

cd "`dirname "$0"`"/..

export WORKSPACE=$PWD

${BRAINCLOUD_TOOLS}/bin/setupexamplesswift.sh $SERVER_ENVIRONMENT 
${BRAINCLOUD_TOOLS}/bin/copy-ids.sh -o "bcchat Example/bcchat/Resources" -p bcchat -x xcconfig -s $SERVER_ENVIRONMENT
${BRAINCLOUD_TOOLS}/bin/copy-ids.sh -o "BCLibDemo/BCLibDemo" -p clientapp -x xcconfig -s $SERVER_ENVIRONMENT

echo "-- No worries, excluding from worktree now."
git update-index --assume-unchanged "bcchat Example/bcchat/Resources/BrainCloudConfig.xcconfig"
git update-index --assume-unchanged "BCLibDemo/BCLibDemo/BrainCloudConfig.xcconfig"

if [[ $1 == "-getlibs" ]];
then
  pushd BCLibDemo
  curl -OL https://github.com/getbraincloud/braincloud-objc/releases/download/5.0.1/brainCloudClient_iOS_ObjC_5.0.1.zip
  unzip brainCloudClient_iOS_ObjC_5.0.1.zip
  popd

  git clone https://github.com/getbraincloud/braincloud-objc.git
  pushd braincloud-objc
  git clone --recursive https://github.com/getbraincloud/braincloud-cpp.git
  popd
fi

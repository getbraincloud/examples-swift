#~/bin/bash
# pull the repos to braincloud-objc/ folder and braincloud-objc/braincloud-cpp/
# checkout to the branch you'd like to test
# Run from the folder where the podspec is

set -e

if [ "${1}" == "OFF" ]
then
    export PODSOURCE=""
    export CPPSOURCE=""
    export JSONSOURCE=""
    sed -i '' "s,'USER_HEADER_SEARCH_PATHS' => .*$,'USER_HEADER_SEARCH_PATHS' => '\"\${PODS_ROOT}/BrainCloudCpp/include\"',g" "$WORKSPACE/braincloud-objc/BrainCloud.podspec"
    sed -i '' "s,'USER_HEADER_SEARCH_PATHS' => .*$,'USER_HEADER_SEARCH_PATHS' => '\"\${PODS_ROOT}/BrainCloudCpp/include\"',g" "$WORKSPACE/braincloud-objc/braincloud-cpp/BrainCloudCpp.podspec"
else
    export PODSOURCE="${WORKSPACE}/braincloud-objc" # This will prevent from fetch remote pod, and use local clone instead for cpp
    export CPPSOURCE="${WORKSPACE}/braincloud-objc/braincloud-cpp" # This will prevent from fetch remote pod, and use local clone instead for cpp
    export JSONSOURCE="${WORKSPACE}/braincloud-objc/braincloud-cpp/lib/jsoncpp-1.0.0"

  # seems necessary in swift project to set the search path for cpp in order to compile
  sed -i '' "s,'USER_HEADER_SEARCH_PATHS' => .*$,'USER_HEADER_SEARCH_PATHS' => '\"${WORKSPACE}/braincloud-objc/braincloud-cpp/include/\"',g" "$WORKSPACE/braincloud-objc/BrainCloud.podspec"
  sed -i '' "s,'USER_HEADER_SEARCH_PATHS' => .*$,'USER_HEADER_SEARCH_PATHS' => '\"${WORKSPACE}/braincloud-objc/braincloud-cpp/include/\"',g" "$WORKSPACE/braincloud-objc/braincloud-cpp/BrainCloudCpp.podspec"
fi

pod deintegrate
rm -rf Podfile.lock
pod install --repo-update

pod update

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ACL.hh"
#import "AuthenticationTypeObjc.hh"
#import "BrainCloudAsyncMatch.hh"
#import "BrainCloudAuthentication.hh"
#import "BrainCloudClient.hh"
#import "brainCloudClientObjc.hh"
#import "BrainCloudCompletionBlocks.hh"
#import "BrainCloudDataStream.hh"
#import "BrainCloudEntity.hh"
#import "BrainCloudEvent.hh"
#import "BrainCloudFile.hh"
#import "BrainCloudFriend.hh"
#import "BrainCloudGamification.hh"
#import "BrainCloudGlobalApp.hh"
#import "BrainCloudGlobalEntity.hh"
#import "BrainCloudGlobalStatistics.hh"
#import "BrainCloudGroup.hh"
#import "BrainCloudIdentity.hh"
#import "BrainCloudLeaderboard.hh"
#import "BrainCloudMail.hh"
#import "BrainCloudMatchMaking.hh"
#import "BrainCloudOneWayMatch.hh"
#import "BrainCloudPlaybackStream.hh"
#import "BrainCloudPlayerState.hh"
#import "BrainCloudPlayerStatistics.hh"
#import "BrainCloudPlayerStatisticsEvent.hh"
#import "BrainCloudProduct.hh"
#import "BrainCloudProfanity.hh"
#import "BrainCloudPushNotification.hh"
#import "BrainCloudRedemptionCode.hh"
#import "BrainCloudS3Handling.hh"
#import "BrainCloudSaveDataHelper.h"
#import "BrainCloudScript.hh"
#import "BrainCloudTime.hh"
#import "BrainCloudTournament.hh"
#import "BrainCloudWrapper.hh"
#import "FriendPlatformObjc.hh"
#import "PlatformObjc.hh"
#import "ReasonCodes.hh"
#import "ServiceName.hh"
#import "ServiceOperation.hh"
#import "StatusCodes.hh"

FOUNDATION_EXPORT double BrainCloudVersionNumber;
FOUNDATION_EXPORT const unsigned char BrainCloudVersionString[];


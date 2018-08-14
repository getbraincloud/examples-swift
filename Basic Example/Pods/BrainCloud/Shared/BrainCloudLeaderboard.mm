//
//  BrainCloudLeaderboard.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-07.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include <string>
#include <vector>

#include "BrainCloudCallback.hh"
#include "braincloud/BrainCloudClient.h"
#import "BrainCloudClient.hh"
#import "BrainCloudLeaderboard.hh"

@interface BrainCloudLeaderboard ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudLeaderboard

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)getSocialLeaderboard:(NSString *)leaderboardId
                 replaceName:(bool)replaceName
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->getSocialLeaderboard(
        [leaderboardId UTF8String], replaceName, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getMultiSocialLeaderboard:(NSArray *)leaderboardIds
           leaderboardResultCount:(NSInteger)leaderboardResultCount
                      replaceName:(bool)replaceName
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject
{
    std::vector<std::string> lbIds;
    for (NSString *nsid in leaderboardIds)
    {
        std::string lbId = [nsid UTF8String];
        lbIds.push_back(lbId);
    }
    _client->getSocialLeaderboardService()->getMultiSocialLeaderboard(
        lbIds, (int)leaderboardResultCount, replaceName, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalLeaderboardPage:(NSString *)leaderboardId
                       sortOrder:(SortOrder)sortOrder
                      startIndex:(int)startIndex
                        endIndex:(int)endIndex
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->getGlobalLeaderboardPage(
        [leaderboardId UTF8String], (BrainCloud::SortOrder)sortOrder, startIndex, endIndex,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalLeaderboardPageByVersion:(NSString *)leaderboardId
                                sortOrder:(SortOrder)sortOrder
                               startIndex:(int)startIndex
                                 endIndex:(int)endIndex
                                versionId:(int)versionId
                          completionBlock:(BCCompletionBlock)cb
                     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                 cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->getGlobalLeaderboardPageByVersion(
        [leaderboardId UTF8String], (BrainCloud::SortOrder)sortOrder, startIndex, endIndex, versionId,
        new BrainCloudCallback(cb, ecb, cbObject));
}


- (void)getGlobalLeaderboardView:(NSString *)leaderboardId
                       sortOrder:(SortOrder)sortOrder
                     beforeCount:(int)beforeCount
                      afterCount:(int)afterCount
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->getGlobalLeaderboardView(
        [leaderboardId UTF8String], (BrainCloud::SortOrder)sortOrder, beforeCount, afterCount,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalLeaderboardViewByVersion:(NSString *)leaderboardId
                                sortOrder:(SortOrder)sortOrder
                              beforeCount:(int)beforeCount
                               afterCount:(int)afterCount
                                versionId:(int)versionId
                          completionBlock:(BCCompletionBlock)cb
                     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                 cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->getGlobalLeaderboardViewByVersion(
        [leaderboardId UTF8String], (BrainCloud::SortOrder)sortOrder, beforeCount, afterCount, versionId,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalLeaderboardEntryCount:(NSString *)leaderboardId
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->getGlobalLeaderboardEntryCount(
        [leaderboardId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalLeaderboardEntryCountByVersion:(NSString *)leaderboardId
                                      versionId:(int32_t)versionId
                                completionBlock:(BCCompletionBlock)cb
                           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                       cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->getGlobalLeaderboardEntryCountByVersion(
        [leaderboardId UTF8String], versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGlobalLeaderboardVersions:(NSString *)leaderboardId
                     completionBlock:(BCCompletionBlock)cb
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->getGlobalLeaderboardVersions(
        [leaderboardId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postScoreToLeaderboard:(NSString *)leaderboardId
                         score:(int)score
                 jsonOtherData:(NSString *)jsonOtherData
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->postScoreToLeaderboard(
        [leaderboardId UTF8String], score, [jsonOtherData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postScoreToDynamicLeaderboard:(NSString *)leaderboardId
                                score:(int)score
                             jsonData:(NSString *)jsonData
                      leaderboardType:(LeaderboardType)leaderboardType
                         rotationType:(RotationType)rotationType
                       roatationReset:(NSDate *)rotationReset
                        retainedCount:(int)retainedCount
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject
{
    time_t time = [rotationReset timeIntervalSince1970];
    struct tm *timeStruct = localtime(&time);

    _client->getSocialLeaderboardService()->postScoreToDynamicLeaderboard(
        [leaderboardId UTF8String], score, [jsonData UTF8String], (BrainCloud::SocialLeaderboardType)leaderboardType,
        (BrainCloud::RotationType)rotationType, timeStruct, retainedCount, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)postScoreToDynamicLeaderboardDays:(NSString *)leaderboardId
                                    score:(int)score
                                 jsonData:(NSString *)jsonData
                          leaderboardType:(LeaderboardType)leaderboardType
                           roatationReset:(NSDate *)rotationReset
                            retainedCount:(int)retainedCount
                          numDaysToRotate:(int)numDaysToRotate
                          completionBlock:(BCCompletionBlock)cb
                     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                 cbObject:(BCCallbackObject)cbObject
{
    time_t time = [rotationReset timeIntervalSince1970];
    struct tm *timeStruct = localtime(&time);

    _client->getSocialLeaderboardService()->postScoreToDynamicLeaderboardDays(
        [leaderboardId UTF8String], score, [jsonData UTF8String], (BrainCloud::SocialLeaderboardType)leaderboardType,
        timeStruct, retainedCount, numDaysToRotate, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)removePlayerScore:(NSString *)leaderboardId
                versionId:(int)versionId
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->removePlayerScore(
        [leaderboardId UTF8String], versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getGroupSocialLeaderboard:(NSString *)leaderboardId
                          groupId:(NSString *)groupId
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->getGroupSocialLeaderboard(
        [leaderboardId UTF8String], [groupId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getPlayersSocialLeaderboard:(NSString *)leaderboardId
                         profileIds:(NSArray *)profileIds
                    completionBlock:(BCCompletionBlock)cb
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject
{
    std::vector<std::string> lbIds;
    for (NSString *nsid in profileIds)
    {
        std::string lbId = [nsid UTF8String];
        lbIds.push_back(lbId);
    }

    _client->getSocialLeaderboardService()->getPlayersSocialLeaderboard(
        [leaderboardId UTF8String], lbIds, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)listAllLeaderboards:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->listAllLeaderboards(
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getPlayerScore:(NSString *)leaderboardId
               versionId:(int)versionId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getSocialLeaderboardService()->getPlayerScore(
        [leaderboardId UTF8String], versionId, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getPlayerScoresFromLeaderboards:(NSArray *)leaderboardIds
                        completionBlock:(BCCompletionBlock)cb
                   errorCompletionBlock:(BCErrorCompletionBlock)ecb
                               cbObject:(BCCallbackObject)cbObject
{
    std::vector<std::string> lbIds;
    for (NSString *nsid in leaderboardIds)
    {
        std::string lbId = [nsid UTF8String];
        lbIds.push_back(lbId);
    }

    _client->getSocialLeaderboardService()->getPlayerScoresFromLeaderboards(
        lbIds, new BrainCloudCallback(cb, ecb, cbObject));
}

@end

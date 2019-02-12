//
//  BrainCloudLobby.m
//  BrainCloud-iOS
//
//  Created by Ryan Ruth on 2018-11-06.
//  Copyright © 2018 BitHeads Inc. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"
#include "TypeHelpers.hh"
#import "BrainCloudLobby.hh"
#import "BrainCloudClient.hh"

@interface BrainCloudLobby()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudLobby

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];
    
    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }
    
    return self;
}


-(void)createLobby:(NSString *)lobbyType
              rating:(int)rating
      otherUserCxIds:(NSArray *)otherUserCxIds
             isReady:(bool)isReady
           extraJson:(NSString *) extraJson
            teamCode:(NSString *)teamCode
            settings:(NSString *)settings
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getLobbyService()->createLobby([lobbyType UTF8String], rating, TypeHelpers::NSStringArrayToVector(otherUserCxIds),
        isReady, [extraJson UTF8String], [teamCode UTF8String], [settings UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

-(void)findLobby:(NSString *)lobbyType
              rating:(int)rating
            maxSteps:(int)maxSteps
                algo:(NSString *)algo
          filterJson:(NSString *)filterJson
      otherUserCxIds:(NSArray *)otherUserCxIds
             isReady:(bool)isReady
           extraJson:(NSString *) extraJson
            teamCode:(NSString *)teamCode
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getLobbyService()->findLobby([lobbyType UTF8String], rating, maxSteps, [algo UTF8String], [filterJson UTF8String], TypeHelpers::NSStringArrayToVector(otherUserCxIds),isReady, [extraJson UTF8String], [teamCode UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

-(void)findOrCreateLobby:(NSString *)lobbyType
                  rating:(int)rating
                maxSteps:(int)maxSteps
                    algo:(NSString *)algo
              filterJson:(NSString *)filterJson
          otherUserCxIds:(NSArray *)otherUserCxIds
                 isReady:(bool)isReady
               extraJson:(NSString *) extraJson
                teamCode:(NSString *)teamCode
                settings:(NSString *)settings
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
        _client->getLobbyService()->findOrCreateLobby([lobbyType UTF8String], rating, maxSteps, [algo UTF8String], [filterJson UTF8String], TypeHelpers::NSStringArrayToVector(otherUserCxIds), [settings UTF8String], isReady, [extraJson UTF8String], [teamCode UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)getLobbyData:(NSString *)lobbyId
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getLobbyService()->getLobbyData([lobbyId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)leaveLobby:(NSString *)lobbyId
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getLobbyService()->leaveLobby([lobbyId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)removeMember:(NSString *)lobbyId
                cxId:(NSString *)cxId
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getLobbyService()->removeMember([lobbyId UTF8String], [cxId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)sendSignal:(NSString *)lobbyId
          signalData:(NSString *)signalData
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getLobbyService()->removeMember([lobbyId UTF8String], [signalData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)switchTeam:(NSString *)lobbyId
            teamCode:(NSString *)toTeamCode
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getLobbyService()->switchTeam([lobbyId UTF8String], [toTeamCode UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateReady:(NSString *)lobbyId
             isReady:(bool)isReady
           extraJson:(NSString *)extraJson
     completionBlock:(BCCompletionBlock)cb
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getLobbyService()->updateReady([lobbyId UTF8String], isReady, [extraJson UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)updateSettings:(NSString *)lobbyId
                     settings:(NSString *)settings
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getLobbyService()->updateSettings([lobbyId UTF8String], [settings UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

@end


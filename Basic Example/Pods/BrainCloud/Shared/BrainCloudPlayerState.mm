//
//  BrainCloudPlayerState.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-06.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"
#import "TypeHelpers.hh"
#import "BrainCloudClient.hh"
#import "BrainCloudPlayerState.hh"

@interface BrainCloudPlayerState ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudPlayerState

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)readPlayerState:(BCCompletionBlock)completionBlock
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->readUserState(
            new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)readUserState:(BCCompletionBlock)completionBlock
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->readUserState(
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)  deletePlayer:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->deleteUser(
            new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)  deleteUser:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)ecb
            cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->deleteUser(
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)resetPlayerState:(BCCompletionBlock)completionBlock
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->resetUserState(
            new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)resetUserState:(BCCompletionBlock)completionBlock
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->resetUserState(
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)logout:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->logout(
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)updatePlayerName:(NSString *)name
       completionBlock:(BCCompletionBlock)completionBlock
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->updateName(
            [name UTF8String], new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)updateUserName:(NSString *)name
       completionBlock:(BCCompletionBlock)completionBlock
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->updateName(
            [name UTF8String], new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)updateName:(NSString *)name
       completionBlock:(BCCompletionBlock)completionBlock
  errorCompletionBlock:(BCErrorCompletionBlock)ecb
              cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->updateName(
            [name UTF8String], new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)getAttributes:(BCCompletionBlock)completionBlock
 errorCompletionBlock:(BCErrorCompletionBlock)ecb
             cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->getAttributes(
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)updateAttributes:(NSString *)jsonAttributes
            wipeExisting:(bool)wipeExisting
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->updateAttributes(
        [jsonAttributes UTF8String], wipeExisting,
        new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)removeAttributes:(NSArray *)attributeNames
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->removeAttributes(
        TypeHelpers::NSStringArrayToVector(attributeNames), new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)updatePlayerPictureUrl:(NSString *)pictureUrl
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->updateUserPictureUrl(
            [pictureUrl UTF8String], new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)updateUserPictureUrl:(NSString *)pictureUrl
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->updateUserPictureUrl(
        [pictureUrl UTF8String], new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)updateContactEmail:(NSString *)contactEmail
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
        _client->getPlayerStateService()->updateContactEmail(
        [contactEmail UTF8String], new BrainCloudCallback(completionBlock, ecb, cbObject));
}

- (void)updateSummaryFriendData:(NSString *)jsonSummaryData
                completionBlock:(BCCompletionBlock)cb
           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                       cbObject:(BCCallbackObject)cbObject
{
    _client->getPlayerStateService()->updateSummaryFriendData(
        [jsonSummaryData UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

@end

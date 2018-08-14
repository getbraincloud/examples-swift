//
//  BrainCloudAuthentication.mm
//  brainCloudClientObjc
//
//  Created by Ryan Homer on 8/4/2015.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#import "BrainCloudAuthentication.hh"
#import "BrainCloudClient.hh"
#include "braincloud/ServiceName.h"
#include "braincloud/ServiceOperation.h"
#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"

@interface BrainCloudAuthentication ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudAuthentication

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (NSString *)profileID
{
    const char* str = _client
    ->getAuthenticationService()
    ->getProfileId()
    .c_str();
    
    return [NSString stringWithUTF8String:str];
}

- (NSString *)anonymousID
{
    const char* str = _client
    ->getAuthenticationService()
    ->getAnonymousId()
    .c_str();
    
    return [NSString stringWithUTF8String:str];
}

- (void)initialize:(NSString *)profileID anonymousID:(NSString *)anonymousID
{
    _client->getAuthenticationService()->initialize(
        [profileID UTF8String], [anonymousID UTF8String]);
}

- (NSString *)generateAnonymousId { return [[NSUUID UUID].UUIDString lowercaseString]; }

- (void)clearSavedProfile
{
    _client->getAuthenticationService()->clearSavedProfileId();
}

- (void)authenticateAnonymous:(BOOL)forceCreate
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getAuthenticationService()->authenticateAnonymous(
        forceCreate, new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject));
}

- (void)authenticateFacebook:(NSString *)externalID
         authenticationToken:(NSString *)authToken
                 forceCreate:(BOOL)forceCreate
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateFacebook(
        [externalID cStringUsingEncoding:NSUTF8StringEncoding],
        [authToken cStringUsingEncoding:NSUTF8StringEncoding], forceCreate, brainCloudCallback);
}

- (void)authenticateGameCenter:(NSString *)gameCenterID
                   forceCreate:(BOOL)forceCreate
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                      cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateGameCenter(
        [gameCenterID cStringUsingEncoding:NSUTF8StringEncoding], forceCreate, brainCloudCallback);
}

- (void)authenticateEmailPassword:(NSString *)email
                         password:(NSString *)password
                      forceCreate:(BOOL)forceCreate
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                         cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client
        ->getAuthenticationService()
        ->authenticateEmailPassword([email cStringUsingEncoding:NSUTF8StringEncoding],
                                    [password cStringUsingEncoding:NSUTF8StringEncoding],
                                    forceCreate, brainCloudCallback);
}

- (void)authenticateUniversal:(NSString *)userid
                     password:(NSString *)password
                  forceCreate:(BOOL)forceCreate
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateUniversal(
        [userid cStringUsingEncoding:NSUTF8StringEncoding],
        [password cStringUsingEncoding:NSUTF8StringEncoding], forceCreate, brainCloudCallback);
}

- (void)authenticateSteam:(NSString *)userID
            sessionTicket:(NSString *)sessionticket
              forceCreate:(BOOL)forceCreate
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                 cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateSteam(
        [userID cStringUsingEncoding:NSUTF8StringEncoding],
        [sessionticket cStringUsingEncoding:NSUTF8StringEncoding], forceCreate, brainCloudCallback);
}

- (void)authenticateGoogle:(NSString *)userID
                     token:(NSString *)token
               forceCreate:(BOOL)forceCreate
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateGoogle(
        [userID cStringUsingEncoding:NSUTF8StringEncoding],
        [token cStringUsingEncoding:NSUTF8StringEncoding], forceCreate, brainCloudCallback);
}

- (void)authenticateTwitter:(NSString *)userID
                      token:(NSString *)token
                     secret:(NSString *)secret
                forceCreate:(BOOL)forceCreate
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject
{
    _client->getAuthenticationService()->authenticateTwitter(
        [userID UTF8String], [token UTF8String], [secret UTF8String], forceCreate,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)authenticateParse:(NSString *)userID
                    token:(NSString *)token
              forceCreate:(BOOL)forceCreate
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject
{
    _client->getAuthenticationService()->authenticateParse(
        [userID UTF8String], [token UTF8String], forceCreate,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)resetEmailPassword:(NSString *)email
       withCompletionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->resetEmailPassword(
        [email cStringUsingEncoding:NSUTF8StringEncoding], brainCloudCallback);
}

- (void)authenticateExternal:(NSString *)userID
         authenticationToken:(NSString *)authToken
  externalAuthenticationName:(NSString *)externalAuthName
                 forceCreate:(BOOL)forceCreate
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *brainCloudCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getAuthenticationService()->authenticateExternal(
        [userID cStringUsingEncoding:NSUTF8StringEncoding],
        [authToken cStringUsingEncoding:NSUTF8StringEncoding],
        [externalAuthName cStringUsingEncoding:NSUTF8StringEncoding], forceCreate,
        brainCloudCallback);
}

@end

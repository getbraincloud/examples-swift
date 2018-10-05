#include "BrainCloudCallback.hh"
#include "braincloud/BrainCloudClient.h"
#import "BrainCloudScript.hh"
#import "BrainCloudClient.hh"


@interface BrainCloudScript ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudScript

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)runScript:(NSString *)scriptName
          jsonScriptData:(NSString *)jsonScriptData
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;
{
    _client->getScriptService()->runScript(
        [scriptName cStringUsingEncoding:NSUTF8StringEncoding],
        [jsonScriptData cStringUsingEncoding:NSUTF8StringEncoding], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)scheduleRunScriptUTC:(NSString *)scriptName
              jsonScriptData:(NSString *)jsonScriptData
              startDateInUTC:(NSDate *)startDateInUTC
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject
{
    time_t time = [startDateInUTC timeIntervalSince1970];
    struct tm *timeStruct = localtime(&time);

    _client->getScriptService()->scheduleRunScriptUTC(
        [scriptName UTF8String], [jsonScriptData UTF8String], timeStruct, new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)scheduleRunScriptMinutes:(NSString *)scriptName
                  jsonScriptData:(NSString *)jsonScriptData
                  minutesFromNow:(int)minutesFromNow
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject
{
    _client->getScriptService()->scheduleRunScriptMinutes(
        [scriptName UTF8String], [jsonScriptData UTF8String], minutesFromNow,
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)runParentScript:(NSString *)scriptName
         jsonScriptData:(NSString *)jsonScriptData
        parentLevelName:(NSString *)parentLevelName
        completionBlock:(BCCompletionBlock)cb
   errorCompletionBlock:(BCErrorCompletionBlock)ecb
               cbObject:(BCCallbackObject)cbObject
{
    _client->getScriptService()->runParentScript(
        [scriptName UTF8String], [jsonScriptData UTF8String], [parentLevelName UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)cancelScheduledScript:(NSString *)jobId
              completionBlock:(BCCompletionBlock)cb
         errorCompletionBlock:(BCErrorCompletionBlock)ecb
                     cbObject:(BCCallbackObject)cbObject
{
    _client->getScriptService()->cancelScheduledScript(
        [jobId UTF8String], new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)runPeerScript:(NSString *)scriptName
          jsonScriptData:(NSString *)jsonScriptData
                    peer:(NSString *)peer
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject
{
    _client->getScriptService()->runPeerScript(
        [scriptName cStringUsingEncoding:NSUTF8StringEncoding],
        [jsonScriptData cStringUsingEncoding:NSUTF8StringEncoding], [peer UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

- (void)runPeerScriptAsync:(NSString *)scriptName
            jsonScriptData:(NSString *)jsonScriptData
                      peer:(NSString *)peer
           completionBlock:(BCCompletionBlock)cb
      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                  cbObject:(BCCallbackObject)cbObject
{
    _client->getScriptService()->runPeerScriptAsync(
        [scriptName cStringUsingEncoding:NSUTF8StringEncoding],
        [jsonScriptData cStringUsingEncoding:NSUTF8StringEncoding], [peer UTF8String],
        new BrainCloudCallback(cb, ecb, cbObject));
}

@end

//
//  BrainCloudProduct.m
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-04.
//  Copyright (c) 2015 bitHeads. All rights
//  reserved.
//

#import "BrainCloudProduct.hh"
#import "BrainCloudClient.hh"
#include "braincloud/BrainCloudClient.h"
#include "BrainCloudCallback.hh"

@interface BrainCloudProduct ()
{
    BrainCloud::BrainCloudClient *_client;
}
@end

@implementation BrainCloudProduct

- (instancetype) init: (BrainCloudClient*) client
{
    self = [super init];

    if(self) {
        _client = (BrainCloud::BrainCloudClient *)[client getInternalClient];
    }

    return self;
}

- (void)getCurrency:(NSString *)currencyType
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *bcCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getProductService()->getCurrency(
        [currencyType UTF8String], bcCallback);
}

- (void)awardCurrency:(NSString *)currencyType
               amount:(int)amount
      completionBlock:(BCCompletionBlock)completionBlock
 errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
             cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *bcCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getProductService()->awardCurrency(
        [currencyType UTF8String], amount, bcCallback);
}

- (void)consumeCurrency:(NSString *)currencyType
                 amount:(int)amount
        completionBlock:(BCCompletionBlock)completionBlock
   errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
               cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *bcCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getProductService()->consumeCurrency(
        [currencyType UTF8String], amount, bcCallback);
}

- (void)resetCurrency:(BCCompletionBlock)completionBlock
 errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
             cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *bcCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getProductService()->resetCurrency(bcCallback);
}

- (void)getEligiblePromotions:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *bcCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getProductService()->getEligiblePromotions(
        bcCallback);
}

- (void)getSalesInventory:(NSString *)platform
             userCurrency:(NSString *)userCurrency
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                 cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *bcCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getProductService()->getSalesInventory(
        [platform UTF8String], [userCurrency UTF8String], bcCallback);
}

- (void)getSalesInventoryByCategory:(NSString *)platform
                       userCurrency:(NSString *)userCurrency
                           category:(NSString *)category
                    completionBlock:(BCCompletionBlock)completionBlock
               errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                           cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *bcCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getProductService()->getSalesInventoryByCategory(
        [platform UTF8String], [userCurrency UTF8String], [category UTF8String], bcCallback);
}

- (void)startSteamTransaction:(NSString *)language
                       itemId:(NSString *)itemId
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *bcCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getProductService()->startSteamTransaction(
        [language UTF8String], [itemId UTF8String], bcCallback);
}

- (void)finalizeSteamTransaction:(NSString *)transId
                 completionBlock:(BCCompletionBlock)completionBlock
            errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                        cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *bcCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getProductService()->finalizeSteamTransaction(
        [transId UTF8String], bcCallback);
}

- (void)verifyMicrosoftReceipt:(NSString *)receipt
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                      cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *bcCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getProductService()->verifyMicrosoftReceipt(
        [receipt UTF8String], bcCallback);
}

- (void)verifyItunesReceipt:(NSString *)base64EncReceiptData
            completionBlock:(BCCompletionBlock)completionBlock
       errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                   cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *bcCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getProductService()->verifyItunesReceipt(
        [base64EncReceiptData UTF8String], bcCallback);
}

- (void)confirmGooglePlayPurchase:(NSString *)orderId
                        productId:(NSString *)productId
                            token:(NSString *)token
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                         cbObject:(BCCallbackObject)cbObject
{
    BrainCloudCallback *bcCallback =
        new BrainCloudCallback(completionBlock, errorCompletionBlock, cbObject);
    _client->getProductService()->confirmGooglePlayPurchase(
        [orderId UTF8String], [productId UTF8String], [token UTF8String], bcCallback);
}

@end

//
//  BrainCloudProduct.h
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-04.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once

#import <Foundation/Foundation.h>
#import "BrainCloudCompletionBlocks.hh"

@class BrainCloudClient;

@interface BrainCloudProduct : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Gets the user's currency for the given currency type
* or all currency types if null passed in.
*
* Service Name - Product
* Service Operation - GetPlayerVC
*
* @param currencyType The currency type to retrieve or null
* if all currency types are being requested.
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getCurrency:(NSString *)currencyType
         completionBlock:(BCCompletionBlock)completionBlock
    errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                cbObject:(BCCallbackObject)cbObject;

/**
 * @deprecated Method is recommended to be used in Cloud Code only for security
 * If you need to use it client side, enable 'Allow Currency Calls from Client' on the brainCloud dashboard
 */
- (void)awardCurrency:(NSString *)currencyType
               amount:(int)amount
      completionBlock:(BCCompletionBlock)completionBlock
 errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
             cbObject:(BCCallbackObject)cbObject
    __deprecated_msg("Method is recommended to be used in Cloud Code only for security \
                      If you need to use it client side, enable 'Allow Currency Calls from Client' on the dashboard");

/**
 * @deprecated Method is recommended to be used in Cloud Code only for security
 * If you need to use it client side, enable 'Allow Currency Calls from Client' on the brainCloud dashboard
 */
- (void)consumeCurrency:(NSString *)currencyType
                 amount:(int)amount
        completionBlock:(BCCompletionBlock)completionBlock
   errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
               cbObject:(BCCallbackObject)cbObject
    __deprecated_msg("Method is recommended to be used in Cloud Code only for security \
                      If you need to use it client side, enable 'Allow Currency Calls from Client' on the dashboard");
	
/**
 * @deprecated Method is recommended to be used in Cloud Code only for security
 * If you need to use it client side, enable 'Allow Currency Calls from Client' on the brainCloud dashboard
 */
 - (void)resetCurrency:(BCCompletionBlock)completionBlock
  errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
              cbObject:(BCCallbackObject)cbObject
     __deprecated_msg("Method is recommended to be used in Cloud Code only for security \
                       If you need to use it client side, enable 'Allow Currency Calls from Client' on the dashboard");

/**
* Get Eligible Promotions
*
* Service Name - Product
* Service Operation - GetEligiblePromotions
*
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getEligiblePromotions:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject;

/**
* Method gets the active sales inventory for the passed-in platform and
* currency type.
*
* Service Name - Product
* Service Operation - GetInventory
*
* @param platform The store platform. Valid stores are:
* - itunes
* - facebook
* - appworld
* - steam
* - windows
* - windowsPhone
* - googlePlay
* @param userCurrency The currency to retrieve the sales
* inventory for. This is only used for Steam and Facebook stores.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getSalesInventory:(NSString *)platform
             userCurrency:(NSString *)userCurrency
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                 cbObject:(BCCallbackObject)cbObject;

/**
* Method gets the active sales inventory for the passed-in platform,
* currency type and category.
*
* Service Name - Product
* Service Operation - GetInventory
*
* @param platform The store platform. Valid stores are:
* - itunes
* - facebook
* - appworld
* - steam
* - windows
* - windowsPhone
* - googlePlay
* @param userCurrency The currency to retrieve the sales
* inventory for. This is only used for Steam and Facebook stores.
* @param category Inventory category to retrieve
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getSalesInventoryByCategory:(NSString *)platform
                       userCurrency:(NSString *)userCurrency
                           category:(NSString *)category
                    completionBlock:(BCCompletionBlock)completionBlock
               errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                           cbObject:(BCCallbackObject)cbObject;

/**
* Initialize Steam Transaction
*
* Service Name - Product
* Service Operation - StartSteamTransaction
*
* @param language ISO 639-1 language code
* @param items Items to purchase
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)startSteamTransaction:(NSString *)language
                       itemId:(NSString *)itemId
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject;

/**
* Finalize Steam Transaction. On success, the user will be awarded the
* associated currencies.
*
* Service Name - Product
* Service Operation - FinalizeSteamTransaction
*
* @param transId Steam transaction id
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)finalizeSteamTransaction:(NSString *)transId
                 completionBlock:(BCCompletionBlock)completionBlock
            errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                        cbObject:(BCCallbackObject)cbObject;

/**
* Verify Microsoft Receipt. On success, the user will be awarded the
* associated currencies.
*
* Service Name - Product
* Service Operation - VerifyMicrosoftReceipt
*
* @param receipt Receipt XML
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)verifyMicrosoftReceipt:(NSString *)receipt
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                      cbObject:(BCCallbackObject)cbObject;

/**
* Method verifies an iTunes receipt and awards the items related to this receipt.
*
* Service Name - Product
* Server Operation - OP_CASH_RECEIPT
*
* @param base64EncReceiptData The iTunes receipt
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)verifyItunesReceipt:(NSString *)base64EncReceiptData
            completionBlock:(BCCompletionBlock)completionBlock
       errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                   cbObject:(BCCallbackObject)cbObject;

/**
* Confirms a google play purchase. On success, the user will be awarded the
* associated currencies.
*
* Service Name - Product
* Server Operation - CONFIRM_GOOGLEPLAY_PURCHASE
*
* @param orderId The order id
* @param productId The product id
* @param token Google Play token string
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)confirmGooglePlayPurchase:(NSString *)orderId
                        productId:(NSString *)productId
                            token:(NSString *)token
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                         cbObject:(BCCallbackObject)cbObject;

@end

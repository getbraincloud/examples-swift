//
//  BrainCloudSaveDataHelper.h
//  BrainCloud
//
//  Created by Benoit Sarrazin on 2016-02-29.
//  Copyright © 2016 BitHeads Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrainCloudSaveDataHelper : NSObject

/**
* @deprecated Use new initWithCompanyName method instead - removal after September 1 2017
*/
- (instancetype)initWithCompanyName:(NSString *)companyName gameName:(NSString *)appName;
- (instancetype)initWithCompanyName:(NSString *)companyName appName:(NSString *)appName;

- (void)saveString:(NSString *)string forKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;

@end

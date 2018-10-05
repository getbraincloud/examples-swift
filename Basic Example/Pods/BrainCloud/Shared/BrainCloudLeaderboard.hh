//
//  BrainCloudLeaderboard.h
//  brainCloudClientObjc
//
//  Created by Hill, Bradley on 2015-08-07.
//  Copyright (c) 2016 bitHeads. All rights reserved.
//

#pragma once

#import "BrainCloudCompletionBlocks.hh"
#import <Foundation/Foundation.h>

@class BrainCloudClient;

typedef NS_ENUM(NSUInteger, LeaderboardType) { HIGH_VALUE, CUMULATIVE, LAST_VALUE, LOW_VALUE };

typedef NS_ENUM(NSUInteger, RotationType) { NEVER, DAILY, WEEKLY, MONTHLY, YEARLY };

typedef NS_ENUM(NSUInteger, SortOrder) { HIGH_TO_LOW, LOW_TO_HIGH };

@interface BrainCloudLeaderboard : NSObject

/**
 * Initializes the brainCloudService
 */
- (instancetype) init: (BrainCloudClient*) client;

/**
* Method returns the social leaderboard. A player's social leaderboard is
* comprised of players who are recognized as being your friend.
* For now, this applies solely to Facebook connected players who are
* friends with the logged in player (who also must be Facebook connected).
* In the future this will expand to other identification means (such as
* Game Centre, Google circles etc).
*
* Leaderboards entries contain the player's score and optionally, some user-defined
* data associated with the score. The currently logged in player will also
* be returned in the social leaderboard.
*
* Note: If no friends have played the game, the bestScore, createdAt, updatedAt
* will contain NULL.
*
* @param leaderboardId The id of the leaderboard to retrieve
* @param replaceName If true, the currently logged in player's name will be replaced
* by the string "You".
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*
*/
- (void)getSocialLeaderboard:(NSString *)leaderboardId
                 replaceName:(bool)replaceName
             completionBlock:(BCCompletionBlock)cb
        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                    cbObject:(BCCallbackObject)cbObject;

/**
 * Method returns the social leaderboard by its version. A player's social leaderboard is
 * comprised of players who are recognized as being your friend.
 * For now, this applies solely to Facebook connected players who are
 * friends with the logged in player (who also must be Facebook connected).
 * In the future this will expand to other identification means (such as
 * Game Centre, Google circles etc).
 *
 * Leaderboards entries contain the player's score and optionally, some user-defined
 * data associated with the score. The currently logged in player will also
 * be returned in the social leaderboard.
 *
 * Note: If no friends have played the game, the bestScore, createdAt, updatedAt
 * will contain NULL.
 *
 * @param leaderboardId The id of the leaderboard to retrieve
 * @param replaceName If true, the currently logged in player's name will be replaced
 * by the string "You".
 * @param versionId the version
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 */
- (void)getSocialLeaderboardByVersion:(NSString *)leaderboardId
                          replaceName:(bool)replaceName
                            versionId:(int)versionId
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject;

/**
 * Reads multiple social leaderboards.
 *
 * @param leaderboardIds NSArray of NSString leaderboard IDs.
 * @param leaderboardResultCount Maximum count of entries to return for each leaderboard.
 * @param replaceName If true, the currently logged in player's name will be replaced
 * by the string "You".
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 * @returns JSON string representing the entries in each leaderboard.
 * Note that the friend summary data is returned for each record
 * in the leaderboard.
 *
 * {
 *   "server_time": 1445952203123,
 *   "leaderboards": [
 *    {
 *     "leaderboardId": "default",
 *     "leaderboard": [
 *      {
 *       "externalId": "pacer5",
 *       "name": "Rollo",
 *       "pictureUrl": "http://localhost:8080/gameserver/s3/portal/g/eggies/metadata/pacers/pacer5.png",
 *       "playerId": "pacer5",
 *       "authenticationType": null,
 *       "score": 100000,
 *       "data": {
 *        "pacerTag": null,
 *        "pacerLeaderboardTag": {}
 *       },
 *       "createdAt": null,
 *       "updatedAt": null
 *      },
 *      {
 *       "externalId": "pacer4",
 *       "name": "Chirp",
 *       "pictureUrl": "http://localhost:8080/gameserver/s3/portal/g/eggies/metadata/pacers/pacer4.png",
 *       "playerId": "pacer4",
 *       "authenticationType": null,
 *       "score": 80000,
 *       "data": {
 *        "pacerTag": null,
 *        "pacerLeaderboardTag": {}
 *       },
 *       "createdAt": null,
 *       "updatedAt": null
 *      }
 *     ],
 *     "self": {
 *      "externalId": null,
 *      "name": null,
 *      "pictureUrl": null,
 *      "playerId": "49390659-33bd-4812-b0c4-ab04e614ec98",
 *      "authenticationType": null,
 *      "score": 10,
 *      "data": {
 *       "nickname": "batman"
 *      },
 *      "createdAt": 1445952060607,
 *      "updatedAt": 1445952060607,
 *      "summaryFriendData": null
 *     },
 *     "selfIndex": 5
 *    }
 *   ]
 *  }
 */
- (void)getMultiSocialLeaderboard:(NSArray *)leaderboardIds
           leaderboardResultCount:(NSInteger)leaderboardResultCount
                      replaceName:(bool)replaceName
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject;

/**
* Method returns a page of global leaderboard results.
*
* Leaderboards entries contain the player's score and optionally, some user-defined
* data associated with the score.
*
* Note: This method allows the client to retrieve pages from within the global leaderboard list
*
* Service Name - SocialLeaderboard
* Service Operation - GetGlobalLeaderboardPage
*
* @param leaderboardId The id of the leaderboard to retrieve.
* @param sort Sort key Sort order of page.
* @param startIndex The index at which to start the page.
* @param endIndex The index at which to end the page.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getGlobalLeaderboardPage:(NSString *)leaderboardId
                       sortOrder:(SortOrder)sortOrder
                      startIndex:(int)startIndex
                        endIndex:(int)endIndex
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject;

/**
 * Method returns a page of global leaderboard results.
 * By using a non-current version id, the user can retrieve a historical leaderboard.
 * See GetGlobalLeaderboardVersions method to retrieve the version id.
 *
 * Service Name - SocialLeaderboard
 * Service Operation - GetGlobalLeaderboardPage
 *
 * @param leaderboardId The id of the leaderboard to retrieve.
 * @param sort Sort key Sort order of page.
 * @param startIndex The index at which to start the page.
 * @param endIndex The index at which to end the page.
 * @param versionId The historical version to retrieve.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getGlobalLeaderboardPageByVersion:(NSString *)leaderboardId
                                sortOrder:(SortOrder)sortOrder
                               startIndex:(int)startIndex
                                 endIndex:(int)endIndex
                                versionId:(int)versionId
                          completionBlock:(BCCompletionBlock)cb
                     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                 cbObject:(BCCallbackObject)cbObject;

/**
* Method returns a view of global leaderboard results that centers on the current player.
*
* Leaderboards entries contain the player's score and optionally, some user-defined
* data associated with the score.
*
* Service Name - SocialLeaderboard
* Service Operation - GetGlobalLeaderboardView
*
* @param leaderboardId The id of the leaderboard to retrieve.
* @param sort Sort key Sort order of page.
* @param beforeCount The count of number of players before the current player to include.
* @param afterCount The count of number of players after the current player to include.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getGlobalLeaderboardView:(NSString *)leaderboardId
                       sortOrder:(SortOrder)sortOrder
                     beforeCount:(int)beforeCount
                      afterCount:(int)afterCount
                 completionBlock:(BCCompletionBlock)cb
            errorCompletionBlock:(BCErrorCompletionBlock)ecb
                        cbObject:(BCCallbackObject)cbObject;

/**
* Method returns a view of global leaderboard results that centers on the current player.
* By using a non-current version id, the user can retrieve a historial leaderboard.
* See GetGlobalLeaderboardVersions method to retrieve the version id.
*
* Service Name - SocialLeaderboard
* Service Operation - GetGlobalLeaderboardView
*
* @param leaderboardId The id of the leaderboard to retrieve.
* @param sort Sort key Sort order of page.
* @param beforeCount The count of number of players before the current player to include.
* @param afterCount The count of number of players after the current player to include.
* @param versionId The historical version to retrieve.
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getGlobalLeaderboardViewByVersion:(NSString *)leaderboardId
                                sortOrder:(SortOrder)sortOrder
                              beforeCount:(int)beforeCount
                               afterCount:(int)afterCount
                                versionId:(int)versionId
                          completionBlock:(BCCompletionBlock)cb
                     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                 cbObject:(BCCallbackObject)cbObject;
/**
 * Gets the number of entries in a global leaderboard
 *
 * Service Name - leaderboard
 * Service Operation - GET_GLOBAL_LEADERBOARD_ENTRY_COUNT
 *
 * @param leaderboardId The leaderboard ID
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getGlobalLeaderboardEntryCount:(NSString *)leaderboardId
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject;

/**
 * Gets the number of entries in a global leaderboard
 *
 * Service Name - leaderboard
 * Service Operation - GET_GLOBAL_LEADERBOARD_ENTRY_COUNT
 *
 * @param leaderboardId The leaderboard ID
 * @param versionId The version of the leaderboard
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getGlobalLeaderboardEntryCountByVersion:(NSString *)leaderboardId
                                      versionId:(int)versionId
                                completionBlock:(BCCompletionBlock)cb
                           errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                       cbObject:(BCCallbackObject)cbObject;

/** Gets the global leaderboard versions.
*
* Service Name - SocialLeaderboard
* Service Operation - GetGlobalLeaderboardVersions
*
* @param leaderboardId The leaderboard
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)getGlobalLeaderboardVersions:(NSString *)leaderboardId
                     completionBlock:(BCCompletionBlock)cb
                errorCompletionBlock:(BCErrorCompletionBlock)ecb
                            cbObject:(BCCallbackObject)cbObject;

/**
* Post the players score to the given social leaderboard.
* You can optionally send a user-defined json string of data
* with the posted score. This string could include information
* relevant to the posted score.
*
* Note that the behaviour of posting a score can be modified in
* the brainCloud portal. By default, the server will only keep
* the player's best score.
*
* @param leaderboardId The leaderboard to post to
* @param score The score to post
* @param data Optional user-defined data to post with the score
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)postScoreToLeaderboard:(NSString *)leaderboardId
                         score:(int)score
                 jsonOtherData:(NSString *)jsonOtherData
               completionBlock:(BCCompletionBlock)cb
          errorCompletionBlock:(BCErrorCompletionBlock)ecb
                      cbObject:(BCCallbackObject)cbObject;

/**
* Post the players score to the given social leaderboard.
* Pass leaderboard config data to dynamically create if necessary.
* You can optionally send a user-defined json string of data
* with the posted score. This string could include information
* relevant to the posted score.
*
* Service Name - SocialLeaderboard
* Service Operation - PostScoreDynamic
*
* @param leaderboardId The leaderboard to post to
* @param score The score to post
* @param data Optional user-defined data to post with the score
* @param leaderboardType leaderboard type
* @param rotationType Type of rotation
* @param rotationReset Date to start rotation calculations
* @param retainedCount How many rotations to keep
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)postScoreToDynamicLeaderboard:(NSString *)leaderboardId
                                score:(int)score
                             jsonData:(NSString *)jsonData
                      leaderboardType:(LeaderboardType)leaderboardType
                         rotationType:(RotationType)rotationType
                       roatationReset:(NSDate *)rotationReset
                        retainedCount:(int)retainedCount
                      completionBlock:(BCCompletionBlock)cb
                 errorCompletionBlock:(BCErrorCompletionBlock)ecb
                             cbObject:(BCCallbackObject)cbObject;

/**
* Post the players score to the given social leaderboard.
* Pass leaderboard config data to dynamically create if necessary.
* You can optionally send a user-defined json string of data
* with the posted score. This string could include information
* relevant to the posted score.
*
* Service Name - SocialLeaderboard
* Service Operation - PostScoreDynamic
*
* @param leaderboardId The leaderboard to post to
* @param score The score to post
* @param data Optional user-defined data to post with the score
* @param leaderboardType leaderboard type
* @param rotationReset Date to start rotation calculations
* @param retainedCount How many rotations to keep
* @param numDaysToRotate How many days between each rotation
* @param completionBlock Block to call on return of successful server response
* @param errorCompletionBlock Block to call on return of unsuccessful server response
* @param cbObject User object sent to the completion blocks
*/
- (void)postScoreToDynamicLeaderboardDays:(NSString *)leaderboardId
                                    score:(int)score
                                 jsonData:(NSString *)jsonData
                          leaderboardType:(LeaderboardType)leaderboardType
                           roatationReset:(NSDate *)rotationReset
                            retainedCount:(int)retainedCount
                          numDaysToRotate:(int)numDaysToRotate
                          completionBlock:(BCCompletionBlock)cb
                     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                 cbObject:(BCCallbackObject)cbObject;

/**
 * Removes a player's score from the leaderboard
 *
 * Service Name - leaderboard
 * Service Operation - REMOVE_PLAYER_SCORE
 *
 * @param leaderboardId The leaderboard ID
 * @param versionId The version of the leaderboard. Use -1 to specifiy the currently active leaderboard version
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)removePlayerScore:(NSString *)leaderboardId
                versionId:(int)versionId
          completionBlock:(BCCompletionBlock)cb
     errorCompletionBlock:(BCErrorCompletionBlock)ecb
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieve the social leaderboard for a group.
 *
 * @param leaderboardId The leaderboard to retreive
 * @param groupId The ID of the group
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getGroupSocialLeaderboard:(NSString *)leaderboardId
                          groupId:(NSString *)groupId
                  completionBlock:(BCCompletionBlock)cb
             errorCompletionBlock:(BCErrorCompletionBlock)ecb
                         cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieve the social leaderboard for a group by its version.
 *
 * @param leaderboardId The leaderboard to retreive
 * @param groupId The ID of the group
 * @param versionId the version
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getGroupSocialLeaderboardByVersion:(NSString *)leaderboardId
                                   groupId:(NSString *)groupId
                                 versionId:(int)versionId
                           completionBlock:(BCCompletionBlock)cb
                      errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                  cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieve the social leaderboard for a list of players.
 *
 * Service Name - leaderboard
 * Service Operation - GET_PLAYERS_SOCIAL_LEADERBOARD
 *
 * @param leaderboardId The leaderboard to retrieve
 * @param profileIds The IDs of the players
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getPlayersSocialLeaderboard:(NSString *)leaderboardId
                         profileIds:(NSArray *)profileIds
                    completionBlock:(BCCompletionBlock)cb
               errorCompletionBlock:(BCErrorCompletionBlock)ecb
                           cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieve the social leaderboard for a list of players by their version.
 *
 * Service Name - leaderboard
 * Service Operation - GET_PLAYERS_SOCIAL_LEADERBOARD_BY_VERSION
 *
 * @param leaderboardId The leaderboard to retrieve
 * @param profileIds The IDs of the players
 * @param versionId the version
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getPlayersSocialLeaderboardByVersion:(NSString *)leaderboardId
                                  profileIds:(NSArray *)profileIds
                                   versionId:(int)versionId
                             completionBlock:(BCCompletionBlock)cb
                        errorCompletionBlock:(BCErrorCompletionBlock)ecb
                                    cbObject:(BCCallbackObject)cbObject;

/**
 * Retrieve a list of all leaderboards
 *
 * Service Name - leaderboard
 * Service Operation - LIST_ALL_LEADERBOARDS
 *
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)listAllLeaderboards:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
 * Gets a player's score from a leaderboard
 *
 * Service Name - leaderboard
 * Service Operation - GET_PLAYER_SCORE
 *
 * @param leaderboardId The leaderboard ID
 * @param versionId The version of the leaderboard. Use -1 for current.
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 */
- (void)getPlayerScore:(NSString *)leaderboardId
               versionId:(int)versionId
         completionBlock:(BCCompletionBlock)cb
    errorCompletionBlock:(BCErrorCompletionBlock)ecb
                cbObject:(BCCallbackObject)cbObject;

/**
 * Gets a player's score from multiple leaderboards
 *
 * Service Name - leaderboard
 * Service Operation - GET_PLAYER_SCORES_FROM_LEADERBOARDS
 *
 * @param leaderboardIds A collection of leaderboardIds to retrieve scores from
 * @param callback The method to be invoked when the server response is received
 */
- (void)getPlayerScoresFromLeaderboards:(NSArray *)leaderboardIds
                        completionBlock:(BCCompletionBlock)cb
                   errorCompletionBlock:(BCErrorCompletionBlock)ecb
                               cbObject:(BCCallbackObject)cbObject;

@end

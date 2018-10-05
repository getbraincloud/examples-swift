#import <Foundation/Foundation.h>
#import "BrainCloudClient.hh"

@interface BrainCloudWrapper : NSObject

#pragma mark - Properties

/**
 * The stored anonymous id
 */
@property (copy, nonatomic) NSString *storedAnonymousId;

/**
 * The stored profile id
 */
@property (copy, nonatomic) NSString *storedProfileId;

/**
 * The stored authentication type (unused)
 */
@property (copy, nonatomic) NSString *storedAuthenticationType;

/**
 * For non-anonymous authentication methods, a profile id will be passed in
 * when this value is set to false. This will generate an error on the server
 * if the profile id passed in does not match the profile associated with the
 * authentication credentials. By default, this value is true.
 */
@property (nonatomic) BOOL alwaysAllowProfileSwitch;

/**
 * Method returns a singleton instance of the BrainCloudWrapper.
 *
 * Note: if using a local instance of the brainCloud client, refer to it instead of getInstance.
 *
 * @return A singleton instance of the BrainCloudWrapper.
 *
 * @deprecated Use of the *singleton* has been deprecated. We recommend that you create your own *variable* to hold an instance of the brainCloudWrapper. Explanation here: http://getbraincloud.com/apidocs/wrappers-clients-and-inconvenient-singletons/
 */
+ (BrainCloudWrapper *) getInstance;

/**
 * Initializes the brainCloud Wrapper
 */
- (instancetype) init;

/**
 * Initializes the brainCloud Wrapper
 *
 * @param wrapperName value used to differentiate saved wrapper data
 */
- (instancetype) init: (NSString*) wrapperName;


/**
 * Method returns a singleton instance of the BrainCloudClient.
 * @return A singleton instance of the BrainCloudClient.
 *
 * @deprecated Use of the *singleton* has been deprecated. We recommend that you create your own *variable* to hold an instance of the brainCloudWrapper. Explanation here: http://getbraincloud.com/apidocs/wrappers-clients-and-inconvenient-singletons/
 */
+ (BrainCloudClient *) getBC;

/**
 * Method returns an instance of the BrainCloudClient.
 * @return An instance of the BrainCloudClient.
 */
- (BrainCloudClient *) getBCClient;


/**
* @deprecated Use new initialize method instead - removal after September 1 2017
*/

- (void)initialize:(NSString *)serverUrl
         secretKey:(NSString *)secretKey
            gameId:(NSString *)appId
       gameVersion:(NSString *)appVersion
       companyName:(NSString *)companyName
          gameName:(NSString *)appName;


/**
* @deprecated Use new initialize method instead - removal after September 1 2017
*/
- (void)initialize:(NSString *)serverUrl
         secretKey:(NSString *)secretKey
             appId:(NSString *)appId
           version:(NSString *)appVersion
       companyName:(NSString *)companyName
           appName:(NSString *)appName;

/**
 * Method initializes the BrainCloudClient.
 *
 * @param serverUrl The url to the brainCloud server
 * @param secretKey The secret key for your app
 * @param appId The app id
 * @param appVersion The version
 * @param companyName The company name used in the keychain for storing anonymous and profile ids.
 * You are free to pick anything you want.
 * @param appName The app name used in teh keychain for storing anonymous and profile ids.
 * You are free to pick anything you want.
 */
- (void)initialize:(NSString *)serverUrl
         secretKey:(NSString *)secretKey
             appId:(NSString *)appId
        appVersion:(NSString *)appVersion
       companyName:(NSString *)companyName
           appName:(NSString *)appName;




/**
 * Authenticate a user anonymously with brainCloud - used for apps that don't want to bother
 * the user to login, or for users who are sensitive to their privacy
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param forceCreate  Should a new profile be created if it does not exist?
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 */
- (void)authenticateAnonymous:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject;

/**
 * Authenticate the user with a custom Email and Password.  Note that the client app
 * is responsible for collecting (and storing) the e-mail and potentially password
 * (for convenience) in the client data.  For the greatest security,
 * force the user to re-enter their * password at each login.
 * (Or at least give them that option).
 *
 * Note that the password sent from the client to the server is protected via SSL.
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param email  The e-mail address of the user
 * @param password  The password of the user
 * @param forceCreate Should a new profile be created for this user if the account does not exist?
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 */
- (void)authenticateEmailPassword:(NSString *)email
                         password:(NSString *)password
                      forceCreate:(BOOL)forceCreate
                  completionBlock:(BCCompletionBlock)completionBlock
             errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                         cbObject:(BCCallbackObject)cbObject;

/**
 * Authenticate the user via cloud code (which in turn validates the supplied credentials against an
 *external system).
 * This allows the developer to extend brainCloud authentication to support other backend
 *authentication systems.
 *
 * Service Name - Authenticate
 * Server Operation - Authenticate
 *
 * @param userid The user id
 * @param token The user token (password etc)
 * @param externalAuthName The name of the cloud script to call for external authentication
 * @param force Should a new profile be created for this user if the account does not exist?
 *
 * @returns   runs the completion block on success, errorCompletion block on failure
 */
- (void)authenticateExternal:(NSString *)userId
         authenticationToken:(NSString *)authToken
  externalAuthenticationName:(NSString *)externalAuthName
                 forceCreate:(BOOL)forceCreate
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject;

/**
 * Authenticate the user with brainCloud using their Facebook Credentials
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param externalId The facebook id of the user
 * @param authenticationToken The validated token from the Facebook SDK
 *   (that will be further validated when sent to the bC service)
 * @param forceCreate Should a new profile be created for this user if the account does not exist?
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 */
- (void)authenticateFacebook:(NSString *)externalId
         authenticationToken:(NSString *)authToken
                 forceCreate:(BOOL)forceCreate
             completionBlock:(BCCompletionBlock)completionBlock
        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                    cbObject:(BCCallbackObject)cbObject;

/**
 * Authenticate the user using their Game Center id
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param gameCenterId The player's game center id  (use the playerID property from the local
 *GKPlayer object)
 * @param forceCreate Should a new profile be created for this user if the account does not exist?
 * @param success The method to call in event of successful login
 * @param failure The method to call in the event of an error during authentication
 *
 * @returns   performs the success callback on success, failure callback on failure
 *
 */
- (void)authenticateGameCenter:(NSString *)gameCenterId
                   forceCreate:(BOOL)forceCreate
               completionBlock:(BCCompletionBlock)completionBlock
          errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                      cbObject:(BCCallbackObject)cbObject;

/**
 * Authenticate the user using a google userid(email address) and google authentication token.
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param userid  String representation of google+ userid (email)
 * @param token  The authentication token derived via the google apis.
 * @param forceCreate Should a new profile be created for this user if the account does not exist?
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 * @returns   performs the success callback on success, failure callback on failure
 *
 */
- (void)authenticateGoogle:(NSString *)userId
                     token:(NSString *)token
               forceCreate:(BOOL)forceCreate
           completionBlock:(BCCompletionBlock)completionBlock
      errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                  cbObject:(BCCallbackObject)cbObject;

/**
 * Authenticate the user using a steam userid and session ticket (without any validation on the
 *userid).
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param userid  String representation of 64 bit steam id
 * @param sessionticket  The session ticket of the user (hex encoded)
 * @param forceCreate Should a new profile be created for this user if the account does not exist?
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 * @returns   performs the success callback on success, failure callback on failure
 *
 */
- (void)authenticateSteam:(NSString *)userId
            sessionTicket:(NSString *)sessionticket
              forceCreate:(BOOL)forceCreate
          completionBlock:(BCCompletionBlock)completionBlock
     errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                 cbObject:(BCCallbackObject)cbObject;

/**
 * Authenticate the user using a Twitter userid, authentication token, and secret from Twitter.
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param userid  String representation of Twitter userid
 * @param token  The authentication token derived via the Twitter apis.
 * @param secret  The secret given when attempting to link with Twitter
 * @param forceCreate Should a new profile be created for this user if the account does not exist?
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 * @returns   runs the completion block on success, errorCompletion block on failure
 *
 */
- (void)authenticateTwitter:(NSString *)userId
                      token:(NSString *)token
                     secret:(NSString *)secret
                forceCreate:(BOOL)forceCreate
            completionBlock:(BCCompletionBlock)cb
       errorCompletionBlock:(BCErrorCompletionBlock)ecb
                   cbObject:(BCCallbackObject)cbObject;

/**
 * Authenticate the user using a userid and password (without any validation on the userid).
 * Similar to AuthenticateEmailPassword - except that that method has additional features to
 * allow for e-mail validation, password resets, etc.
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param email  The e-mail address of the user
 * @param password  The password of the user
 * @param forceCreate Should a new profile be created for this user if the account does not exist?
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 */
- (void)authenticateUniversal:(NSString *)userid
                     password:(NSString *)password
                  forceCreate:(BOOL)forceCreate
              completionBlock:(BCCompletionBlock)completionBlock
         errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                     cbObject:(BCCallbackObject)cbObject;


/*
 * Smart Switch Authenticate will logout of the current profile, and switch to the new authentication type.
 * In event the current session was previously an anonymous account, the smart switch will delete that profile.
 * Use this function to keep a clean designflow from anonymous to signed profiles
 *
 * Authenticate the user with a custom Email and Password.  Note that the client app
 * is responsible for collecting (and storing) the e-mail and potentially password
 * (for convenience) in the client data.  For the greatest security,
 * force the user to re-enter their * password at each login.
 * (Or at least give them that option).
 *
 * Note that the password sent from the client to the server is protected via SSL.
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param in_email  The e-mail address of the user
 * @param in_password  The password of the user
 * @param forceCreate Should a new profile be created for this user if the account does not exist?
 * @param in_callback The method to be invoked when the server response is received
 *
 */
- (void)smartSwitchAuthenticateEmailPassword:(NSString *)email
                                    password:(NSString *)password
                                 forceCreate:(BOOL)forceCreate
                             completionBlock:(BCCompletionBlock)completionBlock
                        errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                                    cbObject:(BCCallbackObject)cbObject;

/**
 * Smart Switch Authenticate will logout of the current profile, and switch to the new authentication type.
 * In event the current session was previously an anonymous account, the smart switch will delete that profile.
 * Use this function to keep a clean designflow from anonymous to signed profiles
 *
 * Authenticate the user via cloud code (which in turn validates the supplied credentials against an external system).
 * This allows the developer to extend brainCloud authentication to support other backend authentication systems.
 *
 * Service Name - Authenticate
 * Server Operation - Authenticate
 *
 * @param in_userid The user id
 * @param in_token The user token (password etc)
 * @param in_externalAuthName The name of the cloud script to call for external authentication
 * @param in_force Should a new profile be created for this user if the account does not exist?
 *
 * @returns   performs the in_success callback on success, in_failure callback on failure
 */
- (void)smartSwitchAuthenticateExternal:(NSString *)userId
                    authenticationToken:(NSString *)authToken
             externalAuthenticationName:(NSString *)externalAuthName
                            forceCreate:(BOOL)forceCreate
                        completionBlock:(BCCompletionBlock)completionBlock
                   errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                               cbObject:(BCCallbackObject)cbObject;

/*
 * Smart Switch Authenticate will logout of the current profile, and switch to the new authentication type.
 * In event the current session was previously an anonymous account, the smart switch will delete that profile.
 * Use this function to keep a clean designflow from anonymous to signed profiles
 *
 * Authenticate the user with brainCloud using their Facebook Credentials
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param in_fbUserId The facebook id of the user
 * @param in_fbAuthToken The validated token from the Facebook SDK
 *   (that will be further validated when sent to the bC service)
 * @param in_forceCreate Should a new profile be created for this user if the account does not exist?
 * @param in_callback The method to be invoked when the server response is received
 *
 */
- (void)smartSwitchAuthenticateFacebook:(NSString *)externalId
                    authenticationToken:(NSString *)authToken
                            forceCreate:(BOOL)forceCreate
                        completionBlock:(BCCompletionBlock)completionBlock
                   errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                               cbObject:(BCCallbackObject)cbObject;

/*
 * Smart Switch Authenticate will logout of the current profile, and switch to the new authentication type.
 * In event the current session was previously an anonymous account, the smart switch will delete that profile.
 * Use this function to keep a clean designflow from anonymous to signed profiles
 *
 * Authenticate the user using their Game Center id
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param in_gameCenterId The player's game center id  (use the playerID property from the local GKPlayer object)
 * @param in_forceCreate Should a new profile be created for this user if the account does not exist?
 * @param in_success The method to call in event of successful login
 * @param in_failure The method to call in the event of an error during authentication
 *
 * @returns   performs the in_success callback on success, in_failure callback on failure
 *
 */
- (void)smartSwitchAuthenticateGameCenter:(NSString *)gameCenterId
                              forceCreate:(BOOL)forceCreate
                          completionBlock:(BCCompletionBlock)completionBlock
                     errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                                 cbObject:(BCCallbackObject)cbObject;

/*
 * Smart Switch Authenticate will logout of the current profile, and switch to the new authentication type.
 * In event the current session was previously an anonymous account, the smart switch will delete that profile.
 * Use this function to keep a clean designflow from anonymous to signed profiles
 *
 * Authenticate the user using a google userid(email address) and google authentication token.
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param in_userid  String representation of google+ userid (email)
 * @param in_token  The authentication token derived via the google apis.
 * @param in_forceCreate Should a new profile be created for this user if the account does not exist?
 * @param in_callback The method to be invoked when the server response is received
 *
 * @returns   performs the in_success callback on success, in_failure callback on failure
 *
 */
- (void)smartSwitchAuthenticateGoogle:(NSString *)userId
                                token:(NSString *)token
                          forceCreate:(BOOL)forceCreate
                      completionBlock:(BCCompletionBlock)completionBlock
                 errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                             cbObject:(BCCallbackObject)cbObject;

/*
 * Smart Switch Authenticate will logout of the current profile, and switch to the new authentication type.
 * In event the current session was previously an anonymous account, the smart switch will delete that profile.
 * Use this function to keep a clean designflow from anonymous to signed profiles
 *
 * Authenticate the user using a steam userid and session ticket (without any validation on the userid).
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param in_userid  String representation of 64 bit steam id
 * @param in_sessionticket  The session ticket of the user (hex encoded)
 * @param in_forceCreate Should a new profile be created for this user if the account does not exist?
 * @param in_callback The method to be invoked when the server response is received
 *
 * @returns   performs the in_success callback on success, in_failure callback on failure
 *
 */
- (void)smartSwitchAuthenticateSteam:(NSString *)userId
                       sessionTicket:(NSString *)sessionticket
                         forceCreate:(BOOL)forceCreate
                     completionBlock:(BCCompletionBlock)completionBlock
                errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                            cbObject:(BCCallbackObject)cbObject;

/*
 * Smart Switch Authenticate will logout of the current profile, and switch to the new authentication type.
 * In event the current session was previously an anonymous account, the smart switch will delete that profile.
 * Use this function to keep a clean designflow from anonymous to signed profiles
 *
 * Authenticate the user using a Twitter userid, authentication token, and secret from Twitter.
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param in_userid  String representation of Twitter userid
 * @param in_token  The authentication token derived via the Twitter apis.
 * @param in_secret  The secret given when attempting to link with Twitter
 * @param in_forceCreate Should a new profile be created for this user if the account does not exist?
 * @param in_callback The method to be invoked when the server response is received
 *
 * @returns   performs the in_success callback on success, in_failure callback on failure
 *
 */
- (void)smartSwitchAuthenticateTwitter:(NSString *)userId
                                 token:(NSString *)token
                                secret:(NSString *)secret
                           forceCreate:(BOOL)forceCreate
                       completionBlock:(BCCompletionBlock)cb
                  errorCompletionBlock:(BCErrorCompletionBlock)ecb
                              cbObject:(BCCallbackObject)cbObject;

/*
 * Smart Switch Authenticate will logout of the current profile, and switch to the new authentication type.
 * In event the current session was previously an anonymous account, the smart switch will delete that profile.
 * Use this function to keep a clean designflow from anonymous to signed profiles
 *
 * Authenticate the user using a userid and password (without any validation on the userid).
 * Similar to AuthenticateEmailPassword - except that that method has additional features to
 * allow for e-mail validation, password resets, etc.
 *
 * Service Name - Authenticate
 * Service Operation - Authenticate
 *
 * @param in_email  The e-mail address of the user
 * @param in_password  The password of the user
 * @param in_forceCreate Should a new profile be created for this user if the account does not exist?
 * @param in_callback The method to be invoked when the server response is received
 *
 */
- (void)smartSwitchAuthenticateUniversal:(NSString *)userid
                                password:(NSString *)password
                             forceCreate:(BOOL)forceCreate
                         completionBlock:(BCCompletionBlock)completionBlock
                    errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
                                cbObject:(BCCallbackObject)cbObject;

/**
 * Re-authenticates the user with brainCloud
 *
 * @param completionBlock Block to call on return of successful server response
 * @param errorCompletionBlock Block to call on return of unsuccessful server response
 * @param cbObject User object sent to the completion blocks
 *
 */
- (void)reconnect:(BCCompletionBlock)completionBlock
errorCompletionBlock:(BCErrorCompletionBlock)errorCompletionBlock
         cbObject:(BCCallbackObject)cbObject;

/**
 * Run callbacks, to be called once per frame from your main thread
 */
- (void)runCallbacks;

@property(readonly) BrainCloudScript *scriptService;
@property(readonly) BrainCloudPushNotification *pushNotificationService;
@property(readonly) BrainCloudProduct *productService;
@property(readonly) BrainCloudPlayerState *playerStateService;
@property(readonly) BrainCloudPlayerStatistics *playerStatisticsService;
@property(readonly) BrainCloudGlobalStatistics *globalStatisticsService;
@property(readonly) BrainCloudEntity *entityService;
@property(readonly) BrainCloudGlobalEntity *globalEntityService;
@property(readonly) BrainCloudLeaderboard *leaderboardService;
@property(readonly) BrainCloudGlobalApp *globalAppService;
@property(readonly) BrainCloudFriend *friendService;
@property(readonly) BrainCloudMail *mailService;
@property(readonly) BrainCloudMatchMaking *matchMakingService;
@property(readonly) BrainCloudAsyncMatch *asyncMatchService;
@property(readonly) BrainCloudOneWayMatch *oneWayMatchService;
@property(readonly) BrainCloudPlaybackStream *playbackStreamService;
@property(readonly) BrainCloudGamification *gamificationService;
@property(readonly) BrainCloudEvent *eventService;
@property(readonly) BrainCloudPlayerStatisticsEvent *playerStatisticsEventService;
@property(readonly) BrainCloudTime *timeService;
@property(readonly) BrainCloudTournament *tournamentService;
@property(readonly) BrainCloudPresence *presenceService;
@property(readonly) BrainCloudVirtualCurrency *virtualCurrencyService;
@property(readonly) BrainCloudAppStore *appStoreService;
@property(readonly) BrainCloudS3Handling *s3HandlingService;
@property(readonly) BrainCloudIdentity *identityService;
@property(readonly) BrainCloudRedemptionCode *redemptionCodeService;
@property(readonly) BrainCloudDataStream *dataStreamService;
@property(readonly) BrainCloudProfanity *profanityService;
@property(readonly) BrainCloudFile *fileService;
@property(readonly) BrainCloudGroup *groupService;

typedef void (^BCSmartSwitchCompletionBlock)();


@end

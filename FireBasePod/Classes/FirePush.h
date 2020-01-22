//
//  FirePush.h
//  FirePush
//
//  Created by Thanh Hai Tran on 3/5/18.
//

#import <Foundation/Foundation.h>

@class FirePush;

typedef enum __fireState
{
    reiciveToken,//
    reiciveRemoteMessage,//
    tokenRefresh,//
    willConnect,//
    failedConnect,//
    successConnect,//
    willDisconnect,//
    failedGetToken,//
}firebaseState;

typedef void (^PushEvent)(firebaseState state, NSDictionary* info);

@interface FirePush : NSObject

@property (nonatomic,copy) PushEvent completion;

@property (nonatomic) firebaseState onEvent;

+ (FirePush*)shareInstance;

- (void)didRegister;

- (void)reRegisterNotification;

- (void)didReiciveToken:(NSData*)deviceToken withType:(int)type;

- (void)didFailedRegisterNotification:(NSError*)error;

- (void)completion:(PushEvent)_completion;

- (void)connectToFcm;

- (void)disconnectToFcm;

- (void)didUnregisterNotification;

- (BOOL)isNotificationRegistered;

- (NSString*)deviceToken;

@end

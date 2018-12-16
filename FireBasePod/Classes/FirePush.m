//
//  FirePush.m
//  FirePush
//
//  Created by Thanh Hai Tran on 3/5/18.
//

#import "FirePush.h"

#import "FirebaseCore/FIRApp.h"

#import "FirebaseInstanceID/FIRInstanceID.h"

#import "FirebaseMessaging/FirebaseMessaging.h"


#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@import UserNotifications;
#endif

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@interface FirePush () <UNUserNotificationCenterDelegate, FIRMessagingDelegate>

@end
#endif

@interface FirePush () <FIRMessagingDelegate>
@end

static FirePush * __shareInstance = nil;

@implementation FirePush

@synthesize completion;

+ (FirePush*)shareInstance
{
    if(!__shareInstance)
    {
        __shareInstance = [FirePush new];
    }
    
    return __shareInstance;
}

- (void)completion:(PushEvent)_completion
{
    self.completion = _completion;
}

- (void)didRegister
{
    NSString *gPlist = [[NSBundle mainBundle] pathForResource:@"GoogleService-Info" ofType:@"plist"];
    
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:gPlist];
    
    if (!dictionary)
    {
        NSLog(@"Check your GoogleService-Info.plist is not right path or name");
        
        return;
    }
    
#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions =
        UNAuthorizationOptionAlert
        | UNAuthorizationOptionSound
        | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        
    }
    
#endif
    
    [FIRApp configure];

    [FIRMessaging messaging].delegate = self;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kFIRInstanceIDTokenRefreshNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenRefreshNotification:)
                                                 name:kFIRInstanceIDTokenRefreshNotification object:nil];
}

- (void)didReiciveToken:(NSData*)deviceToken withType:(int)type
{
    [[FIRMessaging messaging] setAPNSToken:deviceToken type:type];
    
    self.completion(0, @{@"deviceToken":deviceToken});
}

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

- (void)applicationReceivedRemoteMessage:(FIRMessagingRemoteMessage *)remoteMessage
{
    NSLog(@"%@", remoteMessage.appData);
    
    self.completion(1, @{@"remoteMessage":remoteMessage});
}

#endif

- (void)tokenRefreshNotification:(NSNotification *)notification
{
    NSString *refreshedToken = [[FIRInstanceID instanceID] token];
        
    self.completion(2, @{@"refreshToken":refreshedToken});
    
    [self connectToFcm];
}

- (void)connectToFcm
{
    if (![[FIRInstanceID instanceID] token])
    {
        return;
    }
    
    self.completion(3, @{@"willConnect":@""});

    [[FIRMessaging messaging] disconnect];
    
    [[FIRMessaging messaging] connectWithCompletion:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Unable to connect to FCM. %@", error);
            
            self.completion(4, @{@"connectFailed":error});
        } else {
            NSLog(@"Connected to FCM.");
            
            self.completion(5, @{@"connectSuccess":@""});
        }
    }];
}

- (void)disconnectToFcm
{
    self.completion(6, @{@"willDisconnect":@""});

    [[FIRMessaging messaging] disconnect];
}

- (void)didUnregisterNotification
{
    if([self isNotificationRegistered])
    {
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
    }
}

- (BOOL)isNotificationRegistered
{
    return [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
}

@end

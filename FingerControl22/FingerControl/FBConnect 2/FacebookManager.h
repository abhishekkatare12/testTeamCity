//
//  FacebookManager.h
//  aspire
//
//  Created by Satyadev Sain on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"
#import "FBLoginButton.h"

@protocol FacebookManagerDelegate;

extern NSString* const kFacebookUpdateSuccessNotificationName;
extern NSString* const kFacebookUpdateFailureNotificationName;

typedef enum {
  FacebookRequestTypeLogin = 0,
  FacebookRequestTypeLogout,
  FacebookRequestTypePlacesList,
  FacebookRequestTypePostCheckIn,
  FacebookRequestTypePostMessage,
  FacebookRequestTypeGetUserInfo,
  FacebookRequestTypeGetFriendList,
  FacebookRequestTypeSendInvitation,
  FacebookRequestTypePostOnWall
}FacebookRequestType;

@interface FacebookManager : NSObject<FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate> {
  id<FacebookManagerDelegate> delegate_;
  Facebook* facebook_;
  NSArray* permissions_;
  FacebookRequestType currentRequestType_;
}

@property(readonly) Facebook *facebook;
@property (nonatomic, assign) id<FacebookManagerDelegate> delegate;
@property (nonatomic, assign) FacebookRequestType currentRequestType;

+ (FacebookManager *)sharedInstance;
- (void) authenticate;
- (void) postMessage:(NSString *)message;
- (void) getUserInfo;
- (void) logout;
- (void) getCheckInPlaces;
- (void) postCheckinMessage:(NSString *)placeIs message:(NSString *)message; 
- (void) postImageMessage:(NSString *)message andUrl:(NSString *)url andCaption:(NSString *)caption;
- (void) postMessage:(NSString *)message andCaption:(NSString *)caption andImage:(UIImage *)image;
- (void) getUserFriendsList;
- (void) sendInvitationToFriends:(NSArray *) selectedFriends;
- (void) postOnFriendsWall: (NSArray *) friends ;

@end

@protocol FacebookManagerDelegate <NSObject>
- (void) facebookLoginSucceeded;
- (void) facebookLoginFailed;
- (void) facebookUserInfo:(id)response;
- (void) facebookUserInfoFailedWithError:(NSError *)error;
- (void) facebookCheckinResult:(id)response;
- (void) facebookCheckinResultWithError:(NSError *)error;
- (void) facebookCheckInPosted;
- (void) facebookCheckInPostFailedWithError:(NSError *)error;
- (void) messagePostedSuccessfully;
- (void) messagePostingFailedWithError:(NSError *)error;
- (void) facebookFriendList: (id)response;
- (void) facebookFriendListFailedWithError:(NSError *)error;
- (void) facebookLogoutSucceeded;
- (void) facebookInvitationsSentSuccessfully: (id) response;
- (void) postedOnFriendsWallSuccessfully;
- (void) postCanelled;
@end




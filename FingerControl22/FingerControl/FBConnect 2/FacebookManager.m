//
//  FacebookManager.m
//  aspire
//
//  Created by Satyadev Sain on 9/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacebookManager.h"
//#import "LocationUpdateManager.h"

static NSString* kAppId = @"470916039636051";
static NSString* kAppSecretKey = @"ffc89845d216023d9e7f244d6bb95bf4";

NSString* const kFacebookUpdateSuccessNotificationName = @"FacebookUpdateSuccessful";
NSString* const kFacebookUpdateFailureNotificationName = @"FacebookUpdateFailed";

static FacebookManager *sharedInstance = nil;

@interface FacebookManager ()
- (id) initPrivately;
@end


@implementation FacebookManager

@synthesize delegate=delegate_;
@synthesize facebook=facebook_;
@synthesize currentRequestType=currentRequestType_;

+ (FacebookManager *)sharedInstance {
  if (!sharedInstance) {
    sharedInstance = [[self alloc] initPrivately];
  }
  return sharedInstance;
}

- (id) initPrivately {
  
  if (!kAppId) {
    NSLog(@"missing app id!");
    exit(1);
    return nil;
  }
  
  if ((self = [super init])) {
    permissions_ =  [[NSArray arrayWithObjects:
                      @"read_stream", @"publish_stream", @"offline_access", @"user_checkins", @"friends_checkins",@"publish_checkins", nil] retain];
    facebook_ = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
  }
  return self;
}

- (void) authenticate {
  
  currentRequestType_ = FacebookRequestTypeLogin;
  if ([facebook_ isSessionValid]) {
    
    [delegate_ facebookLoginSucceeded];
  }
  else {
    
    [facebook_ authorize:permissions_];
  }
}

- (void) getUserInfo{
  currentRequestType_ = FacebookRequestTypeGetUserInfo;
  [facebook_ requestWithGraphPath:@"me" andDelegate:self];  
}


//-------------------------------------------------------------------------
- (void) getUserFriendsList {
  currentRequestType_ = FacebookRequestTypeGetFriendList;
//  [facebook_ requestWithGraphPath:@"me/friends" andParams:[NSDictionary dictionaryWithObjectsAndKeys:@"picture,id,name,link,gender,last_name,first_name",@"fields",nil] andDelegate:self];
  [facebook_ requestWithGraphPath:@"me/friends" 
                       andParams:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"picture,id,name,link,gender,last_name,first_name",@"fields",nil]
                     andDelegate:self];
}


//-------------------------------------------------------------------------
- (void) sendInvitationToFriends:(NSArray *) selectedFriends {
  currentRequestType_ = FacebookRequestTypeSendInvitation;
  
//  NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
//                                 @"friends.getAppUsers", @"method",
//                                 nil];
//  [facebook_ requestWithParams:params andDelegate:self];
//  
  NSString *selectedFriendIds = [selectedFriends componentsJoinedByString:@","];
  
  NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys: @"Hello, i'd like to invite you to this app.",  @"message", @"Check this out", @"notification_text",selectedFriendIds, @"suggestions", nil];
  
  [facebook_ dialog:@"apprequests" andParams:params andDelegate:self];
}

- (void) logout {
  currentRequestType_ = FacebookRequestTypeLogout;
  [facebook_ logout:self];
}

- (void) getCheckInPlaces {
  currentRequestType_ = FacebookRequestTypePlacesList;
//  CLLocation *latestLocation = [[LocationUpdateManager sharedInstance] lastUpdatedLocation];
//  
//  NSString *centerString = [NSString stringWithFormat: @"%lf,%lf", latestLocation.coordinate.latitude, latestLocation.coordinate.longitude];
	
//	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"place",@"type",centerString,@"center",@"1000",@"distance", nil];
  
//	[facebook_ requestWithGraphPath:@"search" andParams:params andDelegate:self];
}

- (void) postCheckinMessage:(NSString *)placeIs message:(NSString *)message {
  
  currentRequestType_ = FacebookRequestTypePostCheckIn;
  
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
//	SBJSON *jsonWriter = [[SBJSON new] autorelease];
//  CLLocation *latestLocation = [[LocationUpdateManager sharedInstance] lastUpdatedLocation];
//  
//	NSMutableDictionary *coordinatesDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat: @"%f", latestLocation.coordinate.latitude], @"latitude",[NSString stringWithFormat: @"%f", latestLocation.coordinate.longitude], @"longitude",nil];
  
//	NSString *coordinates = [jsonWriter stringWithObject:coordinatesDictionary];
  
//	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:placeIs, @"place", coordinates, @"coordinates", message, @"message", nil];
  
//  [facebook_ requestWithGraphPath:@"me/checkins" andParams:params andHttpMethod:@"POST" andDelegate:self];
  [pool drain];
  
}


- (void)postMessage:(NSString *)message {
  currentRequestType_ = FacebookRequestTypePostMessage; 
  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:message,@"message",@"Test it!",@"name",nil];
  
  [facebook_ requestWithGraphPath:@"me/feed"  andParams:params andHttpMethod:@"POST" andDelegate:self];
}

- (void)postImageMessage:(NSString *)message andUrl:(NSString *)url andCaption:(NSString *)caption{
  NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:									
                                  nil];
  currentRequestType_ = FacebookRequestTypePostMessage;
	[params setObject:caption forKey:@"name"];
	[params setObject:url forKey:@"picture"];
	[params setObject:message forKey:@"description"];
	[facebook_ requestWithGraphPath:@"me/feed"  andParams:params andHttpMethod:@"POST" andDelegate:self]; 
}

- (void)postMessage:(NSString *)message andCaption:(NSString *)caption andImage:(UIImage *)image {
   currentRequestType_ = FacebookRequestTypePostMessage;
  NSMutableDictionary *args = [[[NSMutableDictionary alloc] init] autorelease];
  [args setObject:caption forKey:@"caption"];
  [args setObject:message forKey:@"message"];
  [args setObject:UIImageJPEGRepresentation(image, 0.7) forKey:@"picture"];
  [facebook_ requestWithGraphPath:@"me/photos"  andParams:args andHttpMethod:@"POST" andDelegate:self]; 
  //[facebook_ requestWithMethodName:@"photos.upload" andParams:args andHttpMethod:@"POST" andDelegate:self];
}



- (void) postOnFriendsWall: (NSArray *) friends {
  currentRequestType_ = FacebookRequestTypePostOnWall;
  
  //  NSArray* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
  //                                                    @"Get Started",@"name",@"http://m.facebook.com/apps/hackbookios/",@"link", nil], nil];
  //  NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
  // The "to" parameter targets the post to a friend
  
//  NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:  nil];
  
  for (NSString *friendID in friends) {
    
    
    SBJSON *jsonWriter = [[SBJSON new] autorelease];
    
    NSDictionary *propertyvalue = [NSDictionary dictionaryWithObjectsAndKeys:@"On iTunes AppStore", @"text", @"http://itunes.apple.com/in/app/light-or-no-light-dating/id548575552?mt=8", @"href", nil];
    
    NSDictionary *properties = [NSDictionary dictionaryWithObjectsAndKeys:propertyvalue, @"Download it free:", nil];
    
    NSDictionary *actions = [NSDictionary dictionaryWithObjectsAndKeys:@"Light or No Light Dating app", @"name",@"http://itunes.apple.com/in/app/light-or-no-light-dating/id548575552?mt=8", @"link", nil];
    
    NSString *finalproperties = [jsonWriter stringWithObject:properties];
    
    NSString *finalactions = [jsonWriter stringWithObject:actions];
    
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   friendID, @"to",@"hi.....", @"message",
                                   @"Light or No Light iOS app", @"name",
                        
                                   @"I’m inviting you to come and play Light or No Light Dating. It’s the online version of the TV show Take Me Out. Will I leave my light on for you? Download the app and find out.", @"description",
                                   @"http://itunes.apple.com/in/app/light-or-no-light-dating/id548575552?mt=8", @"link",
                                   @"", @"picture",
                                   @"", @"actions",
                                   finalproperties, @"properties",
                                   finalactions, @"actions",
                                   nil];
    [self.facebook dialog:@"feed" andParams:params andDelegate:self];
  }
}



#pragma mark Facebook login delegates

- (void)fbDidLogin {
  if ([delegate_ respondsToSelector:@selector(facebookLoginSucceeded)]) {
    [delegate_ facebookLoginSucceeded];
  }
}

-(void)fbDidNotLogin:(BOOL)cancelled {
  sharedInstance = nil;
  if ([delegate_ respondsToSelector:@selector(facebookLoginFailed)]) {
    [delegate_ facebookLoginFailed];
  }
}

- (void) fbDidLogout {
  
  sharedInstance = nil;
  [facebook_ release], facebook_ = nil;
  
  NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage]; for (NSHTTPCookie* cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) { [cookies deleteCookie:cookie]; }
  if ([delegate_ respondsToSelector:@selector(facebookLogoutSucceeded)]) {
    [delegate_ facebookLogoutSucceeded];
  }
}

#pragma mark facebook delegate methods

/**
 * FBRequestDelegate
 */
- (void)request:(FBRequest *)request didLoad:(id)result {
  NSLog(@"result = %@", [result objectForKey:@"data"]);
  if (currentRequestType_ == FacebookRequestTypePlacesList) {
    if ([delegate_ respondsToSelector:@selector(facebookCheckinResult:)]) {
      [delegate_ facebookCheckinResult:result];
    }
  }
  else if (currentRequestType_ == FacebookRequestTypePostCheckIn) {
    if ([delegate_ respondsToSelector:@selector(facebookCheckInPosted)]) {
      [delegate_ facebookCheckInPosted];
    }
  }
  else if (currentRequestType_ == FacebookRequestTypeGetUserInfo) {
    if([delegate_ respondsToSelector:@selector(facebookUserInfo:)]){
      [delegate_ facebookUserInfo:result];
    }
  }
  else if (currentRequestType_ == FacebookRequestTypePostMessage) {
    if ([delegate_ respondsToSelector:@selector(messagePostedSuccessfully)]) {
      [delegate_ messagePostedSuccessfully];
    }
  }
  else if (currentRequestType_ == FacebookRequestTypeGetFriendList) {
    if([delegate_ respondsToSelector:@selector(facebookFriendList:)]){
      [delegate_ facebookFriendList:result];
    }
  }
  else if (currentRequestType_ == FacebookRequestTypeSendInvitation) {
    if ([delegate_ respondsToSelector: @selector(facebookInvitationsSentSuccessfully:)]) {
      [delegate_ facebookInvitationsSentSuccessfully:result];
    }
  }
  else if ( currentRequestType_ == FacebookRequestTypePostOnWall) {
    if ([delegate_ respondsToSelector: @selector( postedOnFriendsWallSuccessfully)]) {
      [delegate_ postedOnFriendsWallSuccessfully];
    }
  }
}

- (void)request:(FBRequest*)request didFailWithError:(NSError*)error {
  
  NSLog(@"Error l= %@", [error localizedDescription]);
  NSLog(@"Error d= %@", [error description]);
  
  if (currentRequestType_ == FacebookRequestTypePlacesList) {
    if ([delegate_ respondsToSelector:@selector(facebookCheckinResultWithError:)]) {
      [delegate_ facebookCheckinResultWithError:error];
    }
  }
  else if (currentRequestType_ == FacebookRequestTypePostCheckIn) {
    if ([delegate_ respondsToSelector:@selector(facebookCheckInPostFailedWithError:)]) {
      [delegate_ facebookCheckInPostFailedWithError:error];
    }
  }
  else if (currentRequestType_ == FacebookRequestTypeGetUserInfo) {
    if([delegate_ respondsToSelector:@selector(facebookUserInfoFailedWithError:)]){
      [delegate_ facebookUserInfoFailedWithError:error];
    }
  }
  else if (currentRequestType_ == FacebookRequestTypePostMessage) {
    if ([delegate_ respondsToSelector:@selector(messagePostingFailedWithError:)]) {
      [delegate_ messagePostingFailedWithError:error];
    }
  }
  else if (currentRequestType_ == FacebookRequestTypeGetFriendList) {
    if ([delegate_ respondsToSelector:@selector(facebookFriendListFailedWithError:)]) {
      [delegate_ facebookFriendListFailedWithError:error];
    }
  }
  else if (currentRequestType_ == FacebookRequestTypeSendInvitation) {
    if ([delegate_ respondsToSelector: @selector(facebookInvitationsSentSuccessfully:)]) {
      [delegate_ facebookInvitationsSentSuccessfully:error];
    }
  }
//  else if ( currentRequestType_ == FacebookRequestTypePostOnWall) {
//    if ([delegate_ respondsToSelector: @selector( postedOnFriendsWallSuccessfully)]) {
//      [delegate_ postedOnFriendsWallSuccessfully];
//    }
//  }
}

- (void)dialogDidComplete:(FBDialog *)dialog{
  if ( currentRequestType_ == FacebookRequestTypePostOnWall) {
    if ([delegate_ respondsToSelector: @selector(postedOnFriendsWallSuccessfully)]) {
      [delegate_ postedOnFriendsWallSuccessfully];
    }
  }
}
- (void)dialogDidNotCompleteWithUrl:(NSURL *)url {
 
}
- (void)dialogDidNotComplete:(FBDialog *)dialog {
  if ( currentRequestType_ == FacebookRequestTypePostOnWall) {
    if ([delegate_ respondsToSelector: @selector(postedOnFriendsWallSuccessfully)]) {
      [delegate_ postCanelled];
    }
  }
}

@end

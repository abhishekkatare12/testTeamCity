//
//  FCAppDelegate.h
//  FingerControl
//
//  Created by Dinesh on 20/11/12.
//
//

#import <UIKit/UIKit.h>
#import "Flurry.h"
#import "FlurryAds.h"

#import "FlurryAdDelegate.h"

#import <RevMobAds/RevMobAds.h>
#import "Chartboost.h"


#define APPID @"50caf64cdf1d49a20f00001f"
#define CHARTBOOSTAPPID @"5084e09116ba47a75c000017"
#define CHARTBOOSTAPPSIGNATURE @"5098d022c4e662fbd6859282df0b144198f7da0c"

 #define AppDelegateInstance (FCAppDelegate*)[[UIApplication sharedApplication] delegate]

@class FCViewController;

@interface FCAppDelegate : UIResponder <UIApplicationDelegate,ChartboostDelegate,RevMobAdsDelegate> {
  UIImageView *splashView;

}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) FCViewController *viewController;
@property (strong,nonatomic)UINavigationController *navController;

- (void) rateApp ;
@end

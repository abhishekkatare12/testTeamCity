//
//  FCAppDelegate.m
//  FingerControl
//
//  Created by Dinesh on 20/11/12.
//
//

#import "FCAppDelegate.h"

#import "FCViewController.h"
#import "Chartboost.h"
#import "FCCommenMethods.h"
#import "RateThisAppDialog.h"


@implementation FCAppDelegate
@synthesize navController;

- (void) rateApp  {

  [RateThisAppDialog threeButtonLayoutWithTitle:@"FingerControl"
                                        message:@"Enjoying Finger Control? Rate us and give a review!"
                              rateNowButtonText:@"Rate"
                            rateLaterButtonText:@"Remind me later"
                            rateNeverButtonText:@"Don't ask again"];


}


- (void) showSplash {
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
    if ([[UIScreen mainScreen] bounds].size.height>480) {
      splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 568, 320)];
    }
    else
      splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
    
    splashView.image = [UIImage imageNamed:@"Default-Landscape.png"];
    
    
  } else {
    splashView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    //funky cookie_logo screen_ipad3
    splashView.image = [UIImage imageNamed:@"Default-Landscape.png"];
  }
  
  //[splashView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
  [self.viewController.view addSubview:splashView];
  [self performSelector:@selector(removeSplash) withObject:nil afterDelay:3.0];
}


- (void) removeSplash {
  
  [UIView beginAnimations: nil context: nil];
  [UIView setAnimationDuration: 5.0f];
  [UIView setAnimationDelegate: self];
  [UIView setAnimationDidStopSelector:@selector(animationEnded:)];
  splashView.alpha = 0.0;
  [splashView setFrame:CGRectMake(-160.0, -240.0, self.viewController.view.frame.size.width+320, self.viewController.view.frame.size.height+480)];
  [UIView commitAnimations];
  
 
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  
  [[FCCommenMethods sharedInstance] playSound];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
  self.viewController = [[FCViewController alloc] initWithNibName:@"FCViewController" bundle:nil];
  navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];

  self.window.rootViewController =navController;
  navController.navigationBar.hidden=YES;
  //[Flurry setAppCircleEnabled:YES];

  
   RevMobAds *revmob = [[RevMobAds alloc] initWithAppId:APPID delagate:self testingMode:RevMobAdsTestingModeWithAds];
  
  [Flurry startSession:@"GDT47S99WGPS4ZWGWQ2R"];
  // Pointer to your rootViewController
	[FlurryAds initialize:self.window.rootViewController];
  
  Chartboost *cb = [Chartboost sharedChartboost];
//  cb.appId = CHARTBOOSTAPPID;
//  cb.appSignature = CHARTBOOSTAPPSIGNATURE;
  cb.appId = @"5048a84716ba470e3d00002d";
  cb.appSignature = @"d3f34aee468b113fe0e1edde8e14f52db598e1d1";
  
  // Notify the beginning of a user session
  [cb startSession];
  [cb setDelegate:self];
  // Show an interstitial
  [cb cacheMoreApps];

  
    [self.window makeKeyAndVisible];
  [self showSplash];
  
    return YES;
}

- (void)didCacheMoreApps {

//  [[[UIAlertView alloc] initWithTitle:@"Saved!" message:@"MoreAppSaved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];

  //[[[UIAlertView alloc] initWithTitle:@"Saved!" message:@"MoreAppSaved" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

- (void)didFailToLoadMoreApps {

}

- (void)installDidReceive {
  NSLog(@"RevMob Successful");
}

/**
 Called if install couldn't be registered
 */
- (void)installDidFail {
  NSLog(@"RevMob installDidFail");
 }

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

//
//  FCViewController.m
//  FingerControl
//
//  Created by Dinesh on 20/11/12.
//
//

#import "FCViewController.h"
#import "FCSelectGameMode.h"
#import "Flurry.h"
#import "FlurryAds.h"
#import "CustomAlertView.h"
#import "Chartboost.h"

#import "FCCreditInfoViewController.h"
#import "FCSettingOptionViewController.h"
#define kSampleAppkey @"dc27a54c8d8843239c89d24a6e2639db"


@interface FCViewController ()

@end

@implementation FCViewController
@synthesize btnMore,btnPlay,btnStore;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
  
  if ([FCCOMMEN shouldShowAd]) {
    [self showAdd];
    [FCCOMMEN setShouldShowAd:NO];
  }
  [FlurryAds setAdDelegate:self];
  
  // Fetch and display banner ad
//  [FlurryAds fetchAndDisplayAdForSpace:@"BANNER_MAIN_VIEW"
//                                  view:self.view size:BANNER_BOTTOM];
  [self showAdds];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return (toInterfaceOrientation ==UIInterfaceOrientationLandscapeLeft | toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

-(IBAction)btnPlayClicked:(id)sender{
  
  FCSelectGameMode *selectGameMode=[[FCSelectGameMode alloc]init];
  [self.navigationController pushViewController:selectGameMode animated:YES];
  
}
-(void)dismissAlertView{
  
  [alert dismissWithClickedButtonIndex:0 animated:YES];
  
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
 
  
}
-(void) willPresentAlertView:(UIAlertView *)alertView {
  
 // alertView.transform = CGAffineTransformMakeRotation(M_PI/2);
}


-(IBAction)btnMoreClicked:(id)sender{

  Chartboost *cb = [Chartboost sharedChartboost];
  [cb showMoreApps];
 
  
}

-(IBAction)btnStoreClicked:(id)sender{
  FCCreditInfoViewController *CreditInfoViewController=[[FCCreditInfoViewController alloc]init];
    
  [self.navigationController pushViewController:CreditInfoViewController animated:YES];
}


-(IBAction) showFullScreenAdClickedButton:(id)sender {

  
  // Check if ad is ready. If so, display the ad
  if ([FlurryAds adReadyForSpace:@"INTERSTITIAL_MAIN_VIEW"]) {
    [FlurryAds displayAdForSpace:@"INTERSTITIAL_MAIN_VIEW"
                          onView:self.view];
  } else {
    // Fetch an ad
    [FlurryAds fetchAdForSpace:@"INTERSTITIAL_MAIN_VIEW"
                         frame:self.view.frame size:FULLSCREEN];
  }
}

- (IBAction)removeInfoView:(id)sender {
  [infoView removeFromSuperview];

  
}


- (IBAction)infoViewShow:(id)sender {
  [infoView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
  [self.view addSubview:infoView];
}

- (IBAction)settingsOptionButtonClicked:(id)sender {
  FCSettingOptionViewController *optionController = [[FCSettingOptionViewController alloc] initWithNibName:@"FCSettingOptionViewController" bundle:nil];
  [self.navigationController pushViewController:optionController animated:YES];
}


- (void) spaceDidReceiveAd:(NSString *)adSpace 	{

  if([adSpace isEqualToString:@"INTERSTITIAL_MAIN_VIEW"]){
  if ([FlurryAds adReadyForSpace:@"INTERSTITIAL_MAIN_VIEW"]) {
    [FlurryAds displayAdForSpace:@"INTERSTITIAL_MAIN_VIEW"
                          onView:self.view];
  }

  }
}

- (IBAction)ShareFacebook{

  
  FacebookManager *manager = [FacebookManager sharedInstance];
  [manager setDelegate:self];
  [manager authenticate];
  
 
 // [self performSelectorOnMainThread:@selector(startAnimator) withObject:nil waitUntilDone:NO];
 
  
}


- (void) VA_showHood  {
  progressHud_ = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  progressHud_.labelText = @"Loading Page....";
  
}

//-------------------------------------------------------------- //-----------------------------------
- (void) VA_hideHood  {
  [MBProgressHUD hideHUDForView:self.view  animated:YES];
  progressHud_ = nil;
}

- (void) showAdd {
  //[self goToHomeView];
  [self VA_showHood];
  [RevMobAds showFullscreenAdWithDelegate:self withSpecificOrientations:UIInterfaceOrientationLandscapeRight, UIInterfaceOrientationLandscapeLeft, nil];
  
}
# pragma mark Ad Callbacks (Fullscreen, Banner and Popup)


- (void)revmobAdDidReceive {
  NSLog(@"RevMob Successful");
  [self VA_hideHood];
  [self performSelectorOnMainThread:@selector(VA_hideHood) withObject:nil waitUntilDone:NO];
}



- (void)revmobAdDidFailWithError:(NSError *)error {
  NSLog(@"RevMob Faill");
 [self performSelectorOnMainThread:@selector(VA_hideHood) withObject:nil waitUntilDone:NO];
  
}

- (void)revmobAdDisplayed {
 [self performSelectorOnMainThread:@selector(VA_hideHood) withObject:nil waitUntilDone:NO];
}

- (void)revmobUserClickedInTheAd {
  [self performSelectorOnMainThread:@selector(VA_hideHood) withObject:nil waitUntilDone:NO];
  
  
}

- (void)revmobUserClosedTheAd {
  [self performSelectorOnMainThread:@selector(VA_hideHood) withObject:nil waitUntilDone:NO];
}


//-----------------------------------------------------------------------------------
#pragma mark FacebookManagerDelegate Methods
//-----------------------------------------------------------------------------------
- (void) facebookLoginSucceeded {
  
  [[FacebookManager sharedInstance] postMessage:@"I have Started Playing Finger Control"];
}

- (void) facebookLoginFailed {
  [self performSelectorOnMainThread:@selector(stopAnimator) withObject:nil waitUntilDone:NO];
  
}

- (void) facebookUserInfoFailedWithError:(NSError *)error{
  
  [self performSelectorOnMainThread:@selector(stopAnimator) withObject:nil waitUntilDone:NO];
 
  UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to login with Facebook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  [alertView show];
    
}
-(void)messagePostedSuccessfully
{
   [self performSelectorOnMainThread:@selector(stopAnimator) withObject:nil waitUntilDone:NO];
  UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Success" message:@"Posted successfully on facebook" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  [alertView show];

}

-(void)messagePostingFailedWithError:(NSError *)error
{
   [self performSelectorOnMainThread:@selector(stopAnimator) withObject:nil waitUntilDone:NO];
  UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Facebook sharing Failed !"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
  [alertView show];

}

-(void) viewWillDisappear:(BOOL)animated {
  
  [super viewWillDisappear:animated];
  
	// Reset delegate
	[FlurryAds removeAdFromSpace:@"BANNER_MAIN_VIEW"];
  [FlurryAds setAdDelegate:nil];
}

- (void) startAnimator {
  progressHud_ = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  progressHud_.labelText = @"Please wait...";
  
}

- (void) stopAnimator {
  [MBProgressHUD hideHUDForView:self.view animated:YES];
  progressHud_ = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) showAdds {
  AdWhirlView *adWhirlView;
  adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
  
  adView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
  [adView updateAdWhirlConfig];
  CGSize adSize = [adWhirlView actualAdSize];
  
  CGSize winSize = CGSizeMake(480, 50);
  adView.frame = CGRectMake((winSize.width/2)-(adSize.width/2),winSize.height-adSize.height,winSize.width,adSize.height);
  //8
	adView.clipsToBounds = YES;
  
	[self.view addSubview:adWhirlView];
}


#pragma mark - adwhirl delegate methods

- (NSString *)adWhirlApplicationKey {
	// return your SDK key
	return kSampleAppkey;
	
}

- (UIViewController *)viewControllerForPresentingModalView {
	
	//return UIWindow.viewController;
  //	return [(FCAppDelegate *)[[UIApplication sharedApplication] delegate] viewController];
	return self.navigationController.topViewController;
}

- (void)adWhirlDidReceiveAd:(AdWhirlView *)adWhirlView {
  [adWhirlView rotateToOrientation:UIInterfaceOrientationLandscapeRight];
  
	[UIView beginAnimations:@"AdResize" context:nil];
	[UIView setAnimationDuration:0.2];
	
	CGSize adSize = [adWhirlView actualAdSize];
	
	CGRect newFrame = adWhirlView.frame;
	
	newFrame.size.height = adSize.height;
	
  
  CGSize winSize = CGSizeMake( 480,  300);
  
	newFrame.size.width = winSize.width;
	
	newFrame.origin.x = 0.00;
  
	newFrame.origin.y = (winSize.height - adSize.height);
  adWhirlView.frame = newFrame;
	
	[UIView commitAnimations];
}



@end

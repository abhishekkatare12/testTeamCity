//
//  FCSelectGameMode.m
//  FingerControl
//
//  Created by Dinesh on 20/11/12.
//
//

#import "FCSelectGameMode.h"
#import "Flurry.h"
#import "FlurryAds.h"
#import "FCMainPlayViewController.h"
#import "FCSettingOptionViewController.h"
#import "FCCreditInfoViewController.h"


#define kSampleAppkey @"dc27a54c8d8843239c89d24a6e2639db"

@interface FCSelectGameMode ()

@end

@implementation FCSelectGameMode
@synthesize btnFreeplay,btnTimeattack;
@synthesize goToStore,showAd;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
   [FlurryAds setAdDelegate:self];
  if (goToStore) {
    goToStore = NO;
    [self btnStoreClicked:nil];
  }
  
  
  // Fetch and display banner ad
//  [FlurryAds fetchAndDisplayAdForSpace:@"BANNER_MAIN_VIEW"
//                                  view:self.view size:BANNER_BOTTOM];
  [self showAdds];
  [self.view bringSubviewToFront: backButton_];

}

-(IBAction)goBack:(id)sender{
  
  [self.navigationController popViewControllerAnimated:YES];
  
}
-(IBAction)test{
  
  if ([FlurryAds adReadyForSpace:@"FingerGame"]) {
    [FlurryAds displayAdForSpace:@"FingerGame" onView:self.view];
  } else {
    [FlurryAds fetchAdForSpace:@"FingerGame" frame:self.view.frame size:FULLSCREEN];
  }
}

- (IBAction)settingsOptionButtonClicked:(id)sender {
  FCSettingOptionViewController *optionController = [[FCSettingOptionViewController alloc] initWithNibName:@"FCSettingOptionViewController" bundle:nil];
  [self.navigationController pushViewController:optionController animated:YES];
}
-(IBAction)btnStoreClicked:(id)sender{
  FCCreditInfoViewController *CreditInfoViewController=[[FCCreditInfoViewController alloc]init];
  
  [self.navigationController pushViewController:CreditInfoViewController animated:YES];
}

- (IBAction)startPlay:(id)sender {
  FCMainPlayViewController *mainPlatController = [[FCMainPlayViewController alloc] initWithNibName:@"FCMainPlayViewController" bundle:nil];
  if ([sender tag] == 1) {
    [Flurry logEvent: @"Easy Level Play"];
    [mainPlatController setType:gameTypeEazy];
    [[FCCommenMethods sharedInstance] setIsEasyMode:YES];
  }
  else if ([sender tag] == 2) {
    [Flurry logEvent: @"Free Mode Play"];
    [mainPlatController setType:gameTypeFreePlay];
    [[FCCommenMethods sharedInstance] setIsEasyMode:NO];
  }
  else {
    [Flurry logEvent: @"Time Attack Play"];
    
    [mainPlatController setType:gameTypeHard];
    [[FCCommenMethods sharedInstance] setIsEasyMode:NO];
  }
  [self.navigationController pushViewController:mainPlatController animated:YES];
  
}

-(void) viewWillDisappear:(BOOL)animated {
  
  [super viewWillDisappear:animated];
  
	// Reset delegate
	[FlurryAds removeAdFromSpace:@"BANNER_MAIN_VIEW"];
  [FlurryAds setAdDelegate:nil];
 
  adWhirlView.delegate = nil;
  adWhirlView = nil;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return (toInterfaceOrientation ==UIInterfaceOrientationLandscapeLeft | toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) showAdds {
  adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
  
//  adView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
//  [adView updateAdWhirlConfig];
//  CGSize adSize = [adWhirlView actualAdSize];
//  
//  CGSize winSize = CGSizeMake(480, 50);
//  adView.frame = CGRectMake((winSize.width/2)-(adSize.width/2),winSize.height-adSize.height,winSize.width,adSize.height);
  //8
//	adView.clipsToBounds = YES;
  
  
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
  [self.view addSubview:adWhirlView];
  [self.view bringSubviewToFront: backButton_];
}



@end

//
//  FCCreditInfoViewController.m
//  FingerControl
//
//  Created by Abhishek sharma on 22/11/12.
//
//

#import "FCCreditInfoViewController.h"
#import "FCCommenMethods.h"
#import "FCInAppItemsViewController.h"

#define kSampleAppkey @"dc27a54c8d8843239c89d24a6e2639db"

@interface FCCreditInfoViewController ()

- (void)FC_freezTimePurchase;
- (void)FC_firstColorPackPurchase;
- (void)FC_secondColorPackPurchase;
- (void)FC_firstCharacterSetPurchase;
- (void)FC_secondCharacterSetPurchase;
- (void)FC_numberSetPurchase;
@end

@implementation FCCreditInfoViewController

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
  if ([[UIScreen mainScreen] bounds].size.height == 568) {
    [scrollView setContentSize:CGSizeMake(568, 646)];
  }
  else {
    [scrollView setContentSize:CGSizeMake(480, 646)];
  }
  
  [balanceLabel setText:[NSString stringWithFormat:@"%d",[[FCCommenMethods sharedInstance] numberOfCoins]]];
  
  
  
  
  
  
  if (FCCOMMEN.freezeActivated) {
    [freezTimeButton setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateNormal];
    [freezTimeButton setEnabled:NO];
  }

  if (FCCOMMEN.firstColorSetPurchased) {
    [firstColorSetTimeButton setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateNormal];
    [firstColorSetTimeButton setEnabled:NO];
  }
  if (FCCOMMEN.secondColorSetPurchased) {
    [secondColorSetTimeButton setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateNormal];
    [secondColorSetTimeButton setEnabled:NO];
  }
  
  if ([FCCOMMEN freezeActivated]) {
    
  }
  if ([FCCOMMEN firstCharacterSetPurchased]) {
    
    [firstCharacterSetPurchaseButton setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateNormal];
    [firstCharacterSetPurchaseButton setEnabled:NO];
  }
  if ([FCCOMMEN secondCharacterSetPurchased]) {
    [secondCharacterSetPurchaseButton setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateNormal];
    [secondCharacterSetPurchaseButton setEnabled:NO];
  }
  if ([FCCOMMEN thirdCharacterSetPurchased]) {
    [thirdCharacterSetPurchaseButton setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateNormal];
    [thirdCharacterSetPurchaseButton setEnabled:NO];
  }
  
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
  if ([FCCOMMEN shouldShowAd]) {
    [self showAdd];
    [FCCOMMEN setShouldShowAd:NO];
  }
  [FlurryAds setAdDelegate:self];
  [balanceLabel setText:[NSString stringWithFormat:@"%d",[FCCOMMEN numberOfCoins]]];
  //[balanceLabel setText:@"300000000000000"];
  int length = balanceLabel.text.length;
  if (length > 8) {
    int addingFactor = (length-8)*10;
    CGRect frame = balanceLabel.frame;
    frame.size.width = frame.size.width+addingFactor;
    frame.origin.x = frame.origin.x-addingFactor;
    balanceLabel.frame = frame;
    
    CGRect frame2 = balanceBack.frame;
    frame2.size.width = frame.size.width+addingFactor;
    frame2.origin.x = frame.origin.x-addingFactor;
    balanceBack.frame = frame2;
  }

  // Fetch and display banner ad
//  [FlurryAds fetchAndDisplayAdForSpace:@"BANNER_MAIN_VIEW"
//                                  view:self.view size:BANNER_BOTTOM];
    [self showAdds];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return (toInterfaceOrientation ==UIInterfaceOrientationLandscapeLeft | toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}




-(IBAction)goBack:(id)sender{
  
  [self.navigationController popViewControllerAnimated:YES];
  
}

-(IBAction)openStore:(id)sender{
  
  FCInAppItemsViewController *masterViewController = [[FCInAppItemsViewController alloc] initWithNibName:@"FCInAppItemsViewController" bundle:nil];
  [self.navigationController pushViewController:masterViewController animated:YES];
  
//  if ([FlurryAds adReadyForSpace:@"FingerGame"]) {
//    [FlurryAds displayAdForSpace:@"FingerGame" onView:self.view];
//  } else {
//    [FlurryAds fetchAdForSpace:@"FingerGame" frame:self.view.frame size:FULLSCREEN];
//  }
  
  
  
}


- (void) spaceDidReceiveAd:(NSString *)adSpace 	{
  
  if([adSpace isEqualToString:@"FingerGame"]){
    if ([FlurryAds adReadyForSpace:@"FingerGame"]) {
      [FlurryAds displayAdForSpace:@"FingerGame"
                            onView:self.view];
    }
    
  }
}

-(void) viewWillDisappear:(BOOL)animated {
  
  [super viewWillDisappear:animated];
  
	// Reset delegate
	[FlurryAds removeAdFromSpace:@"BANNER_MAIN_VIEW"];
  [FlurryAds setAdDelegate:nil];
  
  [adWhirlView setDelegate:nil];
  adWhirlView  = nil;
}

- (IBAction)colorSetPurchase:(id)sender {
  if (FCCOMMEN.numberOfCoins < 1000 ) {
    [self FC_showMessage];
    return;
  }
  FCCOMMEN.numberOfCoins-=1000;
  [balanceLabel setText:[NSString stringWithFormat:@"%d",[FCCOMMEN numberOfCoins]]];

  if ([sender tag] == 1) {
    [self FC_firstColorPackPurchase];
  }
  else {
    [self FC_secondColorPackPurchase];
  }

}



- (IBAction)freezeTimePurchase:(id)sender {
  if (FCCOMMEN.numberOfCoins < 10000 ) {
    [self FC_showMessage];
    return;
  }
  FCCOMMEN.numberOfCoins-=10000;
  [balanceLabel setText:[NSString stringWithFormat:@"%d",[FCCOMMEN numberOfCoins]]];
  [self FC_freezTimePurchase];
}



- (IBAction)firstCharacterSetPurchase:(id)sender {
  if (FCCOMMEN.numberOfCoins < 30000 ) {
    [self FC_showMessage];
    return;
  }
  FCCOMMEN.numberOfCoins-=30000;
  [balanceLabel setText:[NSString stringWithFormat:@"%d",[FCCOMMEN numberOfCoins]]];
  [self FC_firstCharacterSetPurchase];
}
- (IBAction)secondCharacterSetPurchase:(id)sender {
  if (FCCOMMEN.numberOfCoins < 30000 ) {
    [self FC_showMessage];
    return;
  }
  FCCOMMEN.numberOfCoins-=30000;
  [balanceLabel setText:[NSString stringWithFormat:@"%d",[FCCOMMEN numberOfCoins]]];
  [self FC_secondCharacterSetPurchase];
}
- (IBAction)thirdCharacterSetPurchase:(id)sender {
  if (FCCOMMEN.numberOfCoins < 50000 ) {
    [self FC_showMessage];
    return;
  }
  FCCOMMEN.numberOfCoins-=50000;
  [balanceLabel setText:[NSString stringWithFormat:@"%d",[FCCOMMEN numberOfCoins]]];
  [self FC_numberSetPurchase];
}





- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 0) {
    [self openStore:nil];
  }
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
  [self VA_hideHood];
}


#pragma mark Private Methods

- (void) FC_showMessage {
 UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"You do not have sufficient coins" delegate:self cancelButtonTitle:@"Get coins" otherButtonTitles:@"Ok", nil];
  [alert setTag:101];
  [alert show];
}

- (void)FC_freezTimePurchase {
  [FCCOMMEN setFreezeActivated:YES];
  [freezTimeButton setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateNormal];
  [freezTimeButton setEnabled:NO];

}
- (void)FC_firstColorPackPurchase {
  [FCCOMMEN setFirstColorSetPurchased:YES];
  [FCCOMMEN setLeftDrawColor:REDCOLOR];
  [FCCOMMEN setLeftDrawColor:VOILETCOLOR];
  [firstColorSetTimeButton setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateNormal];
  [firstColorSetTimeButton setEnabled:NO];
  
}


- (void)FC_secondColorPackPurchase {
  [FCCOMMEN setSecondColorSetPurchased:YES];
  [FCCOMMEN setLeftDrawColor:PINKCOLOR];
  [FCCOMMEN setLeftDrawColor:YELLOWCOLOR];
  [secondColorSetTimeButton setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateNormal];
  [secondColorSetTimeButton setEnabled:NO];
  

}


- (void)FC_firstCharacterSetPurchase {
  [FCCOMMEN setFirstCharacterSetPurchased:YES];
  [firstCharacterSetPurchaseButton setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateNormal];
  [firstCharacterSetPurchaseButton setEnabled:NO];

}


- (void)FC_secondCharacterSetPurchase {
  [FCCOMMEN setSecondCharacterSetPurchased:YES];
  [secondCharacterSetPurchaseButton setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateNormal];
  [secondCharacterSetPurchaseButton setEnabled:NO];
}


- (void)FC_numberSetPurchase {
  [FCCOMMEN setThirdCharacterSetPurchased:YES];
  [thirdCharacterSetPurchaseButton setImage:[UIImage imageNamed:@"Check.png"] forState:UIControlStateNormal];
  [thirdCharacterSetPurchaseButton setEnabled:NO];
}



- (void) showAdds {
  adWhirlView = [AdWhirlView requestAdWhirlViewWithDelegate:self];
  
//  adView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
//  [adView updateAdWhirlConfig];
//  CGSize adSize = [adWhirlView actualAdSize];
//  
//  CGSize winSize = CGSizeMake(480, 50);
//  adView.frame = CGRectMake((winSize.width/2)-(adSize.width/2),winSize.height-adSize.height,winSize.width,adSize.height);
//  //8
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
}

@end

/*
 
 
 #pragma mark UITableView Delegate
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 return 2;
 }
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;    {
 return 3;
 
 }
 
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 NSString *cellIdentifire = @"cell";
 UITableViewCell *cell;
 if (!cell) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifire];
 }
 [[cell viewWithTag:101] removeFromSuperview];
 UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellbg1.png"]];
 imageView.frame = [cell bounds];
 [cell addSubview:imageView];
 imageView.tag = 101;
 
 return cell;
 }
 
*/

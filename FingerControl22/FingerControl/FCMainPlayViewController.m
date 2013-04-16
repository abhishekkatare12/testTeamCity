//
//  FCMainPlayViewController.m
//  FingerControl
//
//  Created by Abhishek sharma on 22/11/12.
//
//

#import "FCMainPlayViewController.h"
#import "FCShapeModel.h"
#import "FCBezierPath.h"
#import "Constants.h"
#import "FCCommenMethods.h"
#import "FCCreditInfoViewController.h"
#import "FCSelectGameMode.h"
#import <RevMobAds/RevMobAds.h>
#import "RateThisAppDialog.h"


#define Clamp255(a) (a > 255 ? 255 : a)

@interface FCMainPlayViewController ()

@end

@implementation FCMainPlayViewController
@synthesize type;
@synthesize firstAlphabetView,secondAlphabetView;

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
  
  
//  [alertView_ setCenter:self.view.center];
//  [self.view addSubview:alertView_];
  [AppDelegateInstance rateApp];
  numberOfStageComplete = 0;
  //*********First View Values Setting******************
  int index = arc4random_uniform(numberOfAlphabet())+1;
  NSLog(@"Index:%d",index);
  FCShapeModel *shapeModelForA = [[FCShapeModel alloc] init];
  [shapeModelForA setCharacter:@"B"];
  [shapeModelForA setOriginalBezierPathArray:[alphabetDataForIndex(index) objectForKey:BEZIERPATHS]];
  [firstAlphabetView setCurrentShape:shapeModelForA];
  [testView1 setPathTest:[alphabetDataForIndex(index) objectForKey:TESTPATH]];
  [firstAlphabetView setTestView:testView1];
  [firstAlphabetView setController:self];
  [firstAlphabetView setNeedsDisplay];
  
  //*********Second View Values Setting******************
  index = arc4random_uniform(numberOfAlphabet())+1;
  FCShapeModel *shapeModelForB = [[FCShapeModel alloc] init];
  [shapeModelForB setCharacter:@"B"];
  [shapeModelForB setOriginalBezierPathArray:[alphabetDataForIndex(index) objectForKey:BEZIERPATHS]];
  [secondAlphabetView setCurrentShape:shapeModelForB];
  [testView2 setPathTest:[alphabetDataForIndex(index) objectForKey:TESTPATH]];
  [secondAlphabetView setTestView:testView2];
  [secondAlphabetView setController:self];
  [secondAlphabetView setNeedsDisplay];
  //
  if (type != gameTypeHard) {
    [freezButton setHidden:YES];
    [pauseButton setHidden:YES];
  }
  
  remainingTime = 30;
    if (!isNotFirstTime()) {
      [self FC_showInfoFirstTime];
      [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FIRSTTIME"];
    }
    else {
       if (type == gameTypeHard) {
//         if (FCCOMMEN.freezeActivated) {
//           [freezButton setEnabled:YES];
//         }
         [self FC_startTimers];
       }
       else {
         [remainingTimeLabel setHidden:YES];
         [self FC_startCompletionTimer];
       }
    }
  
 
}

- (void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear: animated];
}

- (void) viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  [[FacebookManager sharedInstance] setDelegate:nil];
  
  [timer invalidate];
  timer = nil;
  [completionCheckTimer invalidate];
  completionCheckTimer = nil;
   NSLog(@"FC_startCompletionTimer Released");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
  [[TwitterManager sharedTwitterManager] setDelegate:nil];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return (toInterfaceOrientation ==UIInterfaceOrientationLandscapeLeft | toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (IBAction)startGameFromInitial:(id)sender {
  [alertView_ removeFromSuperview];
  numberOfStageComplete = 0;
  remainingTime = 30;
  [self FC_changeCharactors];
  [alertView_ removeFromSuperview];
}

- (IBAction)goToStore:(id)sender {
 FCSelectGameMode *controller = (FCSelectGameMode* )[[self.navigationController viewControllers] objectAtIndex:[self.navigationController viewControllers].count-2 ] ;
  [controller setGoToStore:YES];
  
//  FCCreditInfoViewController *storeController = [[FCCreditInfoViewController alloc] initWithNibName:@"FCCreditInfoViewController" bundle:nil];
  [[self navigationController] popViewControllerAnimated:NO];
//  //[self.navigationController pushViewController:storeController animated:YES];

}

- (IBAction)goToHome:(id)sender {
  [alertView_ removeFromSuperview];
 [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)goBack:(id)sender {
  [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)rateApp:(id)sender {
  [AppDelegateInstance rateApp];
 }

- (IBAction)pauseGame:(id)sender {
  
  [timer invalidate];
  timer = nil;
  [completionCheckTimer invalidate];
  completionCheckTimer = nil;
   NSLog(@"FC_startCompletionTimer Released");
  [freezTimer invalidate],freezTimer = nil;
  [[FCCommenMethods sharedInstance] stopSound];
 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Paused!" message:nil delegate:self cancelButtonTitle:@"Start" otherButtonTitles:nil, nil];
  [alert setTag:501];
  [alert show];
  
}
- (IBAction)freezGame:(id)sender {
  if (!FCCOMMEN.freezeActivated) {
    
    [timer invalidate];
    timer = nil;
    [completionCheckTimer invalidate];
    completionCheckTimer = nil;
    NSLog(@"FC_startCompletionTimer Released");
    [freezTimer invalidate],freezTimer = nil;
    [[FCCommenMethods sharedInstance] stopSound];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"You Need to purchase it from Store" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert setTag:501];
    [alert show];
    return;
  }
  FCCOMMEN.freezeActivated = NO;
  remainingFreezTime = 10.0;
  [freezTimer invalidate],freezTimer = nil;
  freezTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(FC_changeFreezTime) userInfo:nil repeats:YES];
  [timer invalidate];
  timer = nil;
  //[sender setEnabled:NO];
}



#pragma mark AlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (alertView.tag == FAIL_WITH_REMAININGTIME_ALERTTAG) {
    if (buttonIndex == 1) {
      [self FC_startWithRemainingTimeAfterFail];
    }
    else {
      [self goToHome:nil];
    }
  }
  else if (alertView.tag == FAIL_ALERTTAG) {
    [[self navigationController] popViewControllerAnimated:YES];
  
  }
  else if (alertView.tag == DRAWING_SUCCESS_ALERTTAG) {
    
    
  }
  else if (alertView.tag == DRAWING_SUCCESS_WITH_REMAININGTIME_ALERTTAG) {
    
    [self FC_changeCharactors];
    
  }
  else if (alertView.tag == 501) {
    [[FCCommenMethods sharedInstance] playSound];
    if (remainingFreezTime > 0) {
      if (type == gameTypeHard) {
        [self FC_startCompletionTimer];
        [freezTimer invalidate],freezTimer = nil;
        freezTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(FC_changeFreezTime) userInfo:nil repeats:YES];
      }
      else {
        [self FC_startCompletionTimer];
      }
    }
    else {
      [self FC_startTimers];
    }
    
  }

}

- (void) lineGoingOutSideShowAlert {
  [crossImageView1 setCenter:self.view.center];
  [timer invalidate];
  timer = nil;
  [completionCheckTimer invalidate];
  completionCheckTimer = nil;
   NSLog(@"FC_startCompletionTimer Released");
  [[self view] addSubview:crossImageView1];
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:nil delegate:self cancelButtonTitle:@"Home" otherButtonTitles:@"Retry", nil];
  alert.tag = FAIL_WITH_REMAININGTIME_ALERTTAG;
  [alert show];
}

- (IBAction)removeInfoView:(id)sender {
  [infoView removeFromSuperview];
 //freezButton
  if (type == gameTypeHard) {
    if (FCCOMMEN.freezeActivated) {
      [freezButton setEnabled:YES];
    }
    [self FC_startTimers];
  }
  else {
    [remainingTimeLabel setHidden:YES];
    [self FC_startCompletionTimer];
  }

}

-(IBAction)shareToTwitter:(id)sender {
  [[TwitterManager sharedTwitterManager] setDelegate:self];
  [[TwitterManager sharedTwitterManager] authorizeUserFromController:self];
}

- (IBAction)shareToFacebook:(id)sender {
  if ([[[FacebookManager sharedInstance] facebook] isSessionValid]) {
    [[FacebookManager sharedInstance] postMessage:[self message]];
  }
  else {
    [[FacebookManager sharedInstance] setDelegate:self];
    [[FacebookManager sharedInstance] authenticate];
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


//-----------------------------------------------------------------------------------
#pragma mark FacebookManagerDelegate Methods
//-----------------------------------------------------------------------------------
- (void) facebookLoginSucceeded {
  
  [[FacebookManager sharedInstance] postMessage:[self message]];
}

- (NSString* ) message {
  return  [NSString stringWithFormat:@"I reached Stage %d on Finger Control! Try beat me!",numberOfStageComplete];
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

#pragma mark TwitterManager Delegate

- (void)twitterManager:(TwitterManager *)manager didAuthenticateUser:(NSString *)username {
  if (username) {
    NSLog(@"%@",[self message]);
    [[TwitterManager sharedTwitterManager] postImage:[UIImage imageNamed:@"icon.png"] message:[self message]];//[self message]
    //[[TwitterManager sharedTwitterManager] postMessage:[self message]];
  }

}

- (void)twitterManager:(TwitterManager *)manager failedToAuthenticateWithError:(NSError *)error {
  [[[UIAlertView alloc]initWithTitle:@"Problem!" message:@"Unable to login" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]  show];
  [[TwitterManager sharedTwitterManager] setDelegate:nil];
}

- (void)twitterManager:(TwitterManager *)manager didPostMessage:(NSError *)error {
  
  if (!error) {
    [[[UIAlertView alloc]initWithTitle:@"Success!" message:@"Message shared successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
  }
  
  [[TwitterManager sharedTwitterManager] setDelegate:nil];
  
}

- (void)twitterManager:(TwitterManager *)manager didPostImage:(NSError *)error {
  [manager setDelegate:nil];
  if (!error) {
    [[[UIAlertView alloc]initWithTitle:@"Success!" message:@"Message shared successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]  show];
    [[TwitterManager sharedTwitterManager] setDelegate:nil];
  }
  else {
    [[[UIAlertView alloc]initWithTitle:@"Problem!" message:@"Message shared Failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]  show];
  }
  
}



- (void) startAnimator {
  progressHud_ = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  progressHud_.labelText = @"Please wait...";
  
}

- (void) stopAnimator {
  [MBProgressHUD hideHUDForView:self.view animated:YES];
  progressHud_ = nil;
}


//*********************************************************************
  #pragma mark Private Methods
//*********************************************************************

- (void) FC_changeFreezTime {
  remainingFreezTime--;
  if (remainingFreezTime == -1) {
    [freezTimer invalidate];
    freezTimer = nil;
    [completionCheckTimer invalidate];
    completionCheckTimer = nil;
     NSLog(@"FC_startCompletionTimer Released");
    [self FC_startTimers];
    
  }
}

- ( void) FC_showInfoFirstTime {
  [self.view addSubview:infoView];
  
  
}

- (void) FC_changeCharactors {
  //Remove previous data first
  [self FC_removePreviousDrawingFromViews];
  
  //Assign new data to drawing views
  int index = arc4random_uniform(numberOfAlphabet())+1;
  NSLog(@"Index:%d",index);
  FCShapeModel *shapeModelForA = [[FCShapeModel alloc] init];
  [shapeModelForA setCharacter:@"B"];
  [shapeModelForA setOriginalBezierPathArray:[alphabetDataForIndex(index) objectForKey:BEZIERPATHS]];
  [firstAlphabetView setCurrentShape:shapeModelForA];
  [testView1 setPathTest:[alphabetDataForIndex(index) objectForKey:TESTPATH]];
  [firstAlphabetView setTestView:testView1];
  [firstAlphabetView setController:self];
  [firstAlphabetView setNeedsDisplay];
  
  //*********Second View Values Setting******************
  index = arc4random_uniform(numberOfAlphabet())+1;
  FCShapeModel *shapeModelForB = [[FCShapeModel alloc] init];
  [shapeModelForB setCharacter:@"B"];
  [shapeModelForB setOriginalBezierPathArray:[alphabetDataForIndex(index) objectForKey:BEZIERPATHS]];
  [secondAlphabetView setCurrentShape:shapeModelForB];
  [testView2 setPathTest:[alphabetDataForIndex(index) objectForKey:TESTPATH]];
  [secondAlphabetView setTestView:testView2];
  [secondAlphabetView setController:self];
  [secondAlphabetView setNeedsDisplay];
  
  [self FC_startWithRemainingTimeAfterSuccess];

}

- (void) FC_checkForCompletion {
  if (![self fromImage:testView1.testImage compareImage:nil withFrame:CGRectMake(0, 0, testView1.frame.size.width, testView1.frame.size.height)] && ![self fromImage:testView2.testImage compareImage:nil withFrame:CGRectMake(0, 0, testView2.frame.size.width, testView2.frame.size.height)] && firstAlphabetView.isPerfetInside && secondAlphabetView.isPerfetInside) {
    if (type == gameTypeHard) {
      [timer invalidate];
      timer = nil;
      remainingTime+=5;
    }
    [checkImageView2 setCenter:self.view.center];
    [completionCheckTimer invalidate];
    completionCheckTimer = nil;
     NSLog(@"FC_startCompletionTimer Released");
    if (remainingFreezTime > 0) {
      [freezTimer invalidate];
      freezTimer = nil;
    }
    [[self view] addSubview:checkImageView2];
    numberOfStageComplete++;
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert setTag:DRAWING_SUCCESS_WITH_REMAININGTIME_ALERTTAG];
    [alert show];
  }
  
}



- (void) FC_startWithRemainingTimeAfterFail {
 
  [self FC_removePreviousDrawingFromViews];
  [crossImageView1 removeFromSuperview];
  if (remainingFreezTime > 0) {
    if (type == gameTypeHard) {
      [self FC_startCompletionTimer];
      [freezTimer invalidate],freezTimer = nil;
      freezTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(FC_changeFreezTime) userInfo:nil repeats:YES];
    }
    else {
      [self FC_startCompletionTimer];
    }
  }
  else {
    if (type == gameTypeHard) {
      
      [self FC_startTimers];
    }
    else {
      [self FC_startCompletionTimer];
    }
  }
  
  
}
- (void) FC_startWithRemainingTimeAfterSuccess {
  
  [checkImageView2 removeFromSuperview];
  currentStageLabel.text = [NSString stringWithFormat:@"Stage  %d",numberOfStageComplete+1];
  if (remainingFreezTime > 0) {
    if (type == gameTypeHard) {
      [self FC_startCompletionTimer];
      [freezTimer invalidate],freezTimer = nil;
      
       freezTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(FC_changeFreezTime) userInfo:nil repeats:YES];
    }
  
  }
  else {
    if (type == gameTypeHard) {
      [self FC_startTimers];
    }
    else {
      [self FC_startCompletionTimer];
    }
  }
  
    
}

- (void) FC_startTimers {
  NSLog(@"FC_startTimers");
  [completionCheckTimer invalidate],completionCheckTimer = nil;
  completionCheckTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(FC_checkForCompletion) userInfo:nil repeats:YES];
  [timer invalidate],timer = nil;
  timer =  [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(changeRemainingTime:) userInfo:nil repeats:YES];
}
- (void) FC_startCompletionTimer {
   NSLog(@"FC_startCompletionTimer");
  [completionCheckTimer invalidate],completionCheckTimer = nil;
  completionCheckTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(FC_checkForCompletion) userInfo:nil repeats:YES];
  
}

- (void) FC_removePreviousDrawingFromViews {
  [firstAlphabetView setCurrentIamge:nil];
  [[firstAlphabetView testView] setTestImage:nil];
  [[firstAlphabetView testView] setLastpont:CGPointMake(-100, -100)];
  [[firstAlphabetView testView] setEndPoint:CGPointMake(-100, -100)];
  [firstAlphabetView setIsPerfetInside:YES];
  [firstAlphabetView setIsTouched:NO];
  [firstAlphabetView setStartDrawing:NO];
  
  [secondAlphabetView setCurrentIamge:nil];
  [[secondAlphabetView testView] setTestImage:nil];
  [[secondAlphabetView testView] setLastpont:CGPointMake(-100, -100)];
  [[secondAlphabetView testView] setEndPoint:CGPointMake(-100, -100)];
  [secondAlphabetView setIsPerfetInside:YES];
  [secondAlphabetView setIsTouched:NO];
  [secondAlphabetView setStartDrawing:NO];
  
  [firstAlphabetView.testView setNeedsDisplay];
  [secondAlphabetView.testView setNeedsDisplay];
  [firstAlphabetView setNeedsDisplay];
  [secondAlphabetView setNeedsDisplay];
}

- (void) changeRemainingTime:(NSTimer* )timer1 {
  if (!(remainingTime >= 0)) { // return if remaining time is less than 0
    [timer invalidate],timer = nil;
    [timer1 invalidate],timer1 = nil;

    return;
  }
  
   //********************** Making Sound and changing TextColor ***************
  if (remainingTime <= 10) { // make alertSound if time is less than 10 sec
   
    [[FCCommenMethods sharedInstance] stopSound];
    
    [remainingTimeLabel setTextColor:[UIColor redColor]];
    [self FC_playSound:@"beep" withType:@"wav"];
    //[[FCCommenMethods sharedInstance] playSound];
    
  }
  else {
    if (![[[FCCommenMethods sharedInstance] player] isPlaying]) {
      [[FCCommenMethods sharedInstance] playSound];
    }
    [remainingTimeLabel setTextColor:[UIColor colorWithRed:37.0f/255 green:44.0f/255 blue:142.0f/255 alpha:1.0]];
  }
  
  

  //**********************  changing Time Value ***************
  [remainingTimeLabel setText:[NSString stringWithFormat:@"%d:00 Sec",remainingTime]];
  remainingTime--;
  
  
  
   //********************** Making Check as time is finished now ***************
  if (remainingTime == -1) {
    [timer invalidate],timer = nil;
//    [timer1 invalidate];
//    timer1 = nil;
    [completionCheckTimer invalidate];
    completionCheckTimer = nil;
    NSLog(@"FC_startCompletionTimer Released");
    [self FC_timeFinishedCheckDrawing];
    [[FCCommenMethods sharedInstance] playSound];
  }
}


//**************************************************************************************
//************************************************************************************** 
- (void) FC_timeFinishedCheckDrawing {

  if ([self fromImage:testView1.testImage compareImage:nil withFrame:CGRectMake(0, 0, testView1.frame.size.width, testView1.frame.size.height)] || [self fromImage:testView2.testImage compareImage:nil withFrame:CGRectMake(0, 0, testView2.frame.size.width, testView2.frame.size.height)] || !firstAlphabetView.isPerfetInside || !secondAlphabetView.isPerfetInside) {
    
    if (numberOfStageComplete > 0) {
      numberOfCoinsWinLabel.text = [NSString stringWithFormat:@"%d Coins",numberOfStageComplete*50];
      [[FCCommenMethods sharedInstance] setNumberOfCoins:[[FCCommenMethods sharedInstance] numberOfCoins] + numberOfStageComplete*50] ;
      [checkImageView2 setCenter:self.view.center];
      [[self view] addSubview:checkImageView2];
      [alertView_ setCenter:self.view.center];
      [self.view addSubview:alertView_];
      [FCCOMMEN setShouldShowAd:YES];

      return;
    }
    [crossImageView1 setCenter:self.view.center];
    [[self view] addSubview:crossImageView1];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail!" message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert setTag:FAIL_ALERTTAG];
    [alert show];
    
    
  }
  else {
   numberOfStageComplete++;
    [checkImageView2 setCenter:self.view.center];
    [[self view] addSubview:checkImageView2];
    [self FC_addCompletionAlert];
  }
}


//**************************************************************************************
//************************************************************************************** 
- (void ) FC_addCompletionAlert {

  
  numberOfCoinsWinLabel.text = [NSString stringWithFormat:@"%d Coins",numberOfStageComplete*50];
  [alertView_ setCenter:self.view.center];
  [self.view addSubview:alertView_];
  
}

//**************************************************************************************
//************************************************************************************** 
- (void) FC_changeImage {
  
  //  testImageView.image = firstAlphabetView.currentIamge;
  //  UIImageWriteToSavedPhotosAlbum(firstAlphabetView.currentIamge, nil, nil, nil);
}

//**************************************************************************************
//************************************************************************************** 
-(void) FC_playSound:(NSString *)fileName withType:(NSString *)type {
 
  AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
  
  
  
  NSString *pewPewPath = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
	NSURL *pewPewURL = [NSURL fileURLWithPath:pewPewPath];
  SystemSoundID tapSound;

	AudioServicesCreateSystemSoundID((__bridge CFURLRef)pewPewURL, &tapSound);
  AudioServicesPlaySystemSound(tapSound);
}

//**************************************************************************************
//************************************************************************************** 
- (BOOL) fromImage:(UIImage*)source compareImage:(UIImage* )compareImage withFrame:(CGRect)frame {
  
  
  //---------------------Source Image---------------------------------
  CGContextRef ctx;
  if (!source) {
    return YES;
  }
  CGImageRef imageRef = [source CGImage];
  NSUInteger width = CGImageGetWidth(imageRef);
  NSUInteger height = CGImageGetHeight(imageRef);
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  char *rawData = malloc(height * width * 4);
  NSUInteger bytesPerPixel = 4;
  NSUInteger bytesPerRow = bytesPerPixel * width;
  NSUInteger bitsPerComponent = 8;
  CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                               bitsPerComponent, bytesPerRow, colorSpace,
                                               kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
  CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
  CGContextRelease(context);
  
  
  //-----------------------------------------------
  int byteIndex = 0;
  int x = frame.origin.x;
  int y = frame.origin.y;
  BOOL hasBluePart = NO;
  if (rawData ) {
    @try {
      for (int ii = x ; ii < x + width ; ii++)
      {
        for (int jj = y; jj < y + height; jj++) {
          
          byteIndex = (jj - 1 ) * width * 4 +  (ii - 1) * 4;
          
          int r = Clamp255((unsigned char)rawData[byteIndex]);
          int g = Clamp255((unsigned char)rawData[byteIndex + 1]);
          int b = Clamp255((unsigned char)rawData[byteIndex + 2]);
          // NSLog(@"RValue:%d ,GValue:%d, BValue:%d",r,g,b);
          //111.0f/255 green:181.0f/255 blue:253.0f/255
          if (r == 111 && g == 181 && b == 253) {
            hasBluePart = YES;
          }
          
        }
      }

    }
    @catch (NSException *exception) {
      if (exception) {
        hasBluePart = NO;
      }
    }
    @finally {
       
    }
    
  }
  ctx = CGBitmapContextCreate(rawData,
                              CGImageGetWidth( imageRef ),
                              CGImageGetHeight( imageRef ),
                              8,
                              bytesPerRow,
                              colorSpace,
                              kCGImageAlphaPremultipliedLast );
  CGColorSpaceRelease(colorSpace);
  
  imageRef = CGBitmapContextCreateImage (ctx);
 // UIImage* rawImage = [UIImage imageWithCGImage:imageRef];
  CGImageRelease(imageRef);
  // CGImageRelease(imageRef0);
  CGContextRelease(ctx);
  free(rawData);
  
  
  return hasBluePart;
}




/*
- (NSArray* )bezierPathArrayForAlphabetA {

    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    
    [aPath moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 16.0, DRAWALPHABET_OFFSET_Y + 128.0)];
    [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 77.0, DRAWALPHABET_OFFSET_Y +20.0)];
    // Set the starting point of the shape.
    // Draw the lines.
    //[aPath addLineToPoint:CGPointMake(100.0, 3.0)];
    [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 102, DRAWALPHABET_OFFSET_Y +20)];
    [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 157, DRAWALPHABET_OFFSET_Y +128)];
    [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 132.0, DRAWALPHABET_OFFSET_Y +128.0)];
    [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 118.0, DRAWALPHABET_OFFSET_Y +98.0)];
    [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 60.0, DRAWALPHABET_OFFSET_Y +98)];
    [aPath addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 41.0, DRAWALPHABET_OFFSET_Y +128.0)];
    
    
    [aPath closePath];
    aPath.lineWidth = 2.0;
  FCBezierPath *bezierPath1 = [[FCBezierPath alloc] init];
  [bezierPath1 setBezierPath:aPath];
  [bezierPath1 setCheckOuter:NO];
  
  UIBezierPath *aPath2 = [UIBezierPath bezierPath];
  
  
  [aPath2 moveToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 71.0,DRAWALPHABET_OFFSET_Y +77.0)];
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 89.0,DRAWALPHABET_OFFSET_Y +47.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  [aPath2 addLineToPoint:CGPointMake(DRAWALPHABET_OFFSET_X+ 108.0,DRAWALPHABET_OFFSET_Y +77.0)];
  
  [aPath2 closePath];
  aPath2.lineWidth = 2.0;
  FCBezierPath *bezierPath2 = [[FCBezierPath alloc] init];
  [bezierPath2 setBezierPath:aPath2];
  [bezierPath2 setCheckOuter:YES];

  return [NSArray arrayWithObjects:bezierPath1,bezierPath2, nil];
}
*/
@end







































/*
 currentTouch = [touch locationInView:imageView];
 
 UIGraphicsBeginImageContext(imageView.frame.size);
 CGContextRef context = UIGraphicsGetCurrentContext();
 [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
 CGContextSetLineCap(context, kCGLineCapRound);
 CGContextSetLineWidth(context,38);
 
 CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor brownColor].CGColor);
 CGContextSetBlendMode(context,kCGBlendModeDarken );
 
 
 
 CGContextBeginPath(context);
 CGContextMoveToPoint(context, lastTouch.x, lastTouch.y);
 CGContextAddLineToPoint(context, currentTouch.x, currentTouch.y);
 CGContextStrokePath(context);
 imageView.image = UIGraphicsGetImageFromCurrentImageContext();
 UIGraphicsEndImageContext();
 
 lastTouch = [touch locationInView:imageView];
*/
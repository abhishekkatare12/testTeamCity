//
//  FCMainPlayViewController.h
//  FingerControl
//
//  Created by Abhishek sharma on 22/11/12.
//
//

#import <UIKit/UIKit.h>
#import "FCFirstAlphabetView.h"
#import "FCSecondAlphabetView.h"

#import "FCTestView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "FacebookManager.h"
#import "MBProgressHUD.h"
#import "TwitterManager.h"
#import "FCAppDelegate.h"

@class FCFirstAlphabetView;
@class FCSecondAlphabetView;

typedef enum {
  gameTypeHard=0,
  gameTypeEazy,
  gameTypeFreePlay
} gameType;

@interface FCMainPlayViewController : UIViewController <FacebookManagerDelegate,TwitterManagerDelegate> {

  __unsafe_unretained IBOutlet FCFirstAlphabetView *firstAlphabetView;
  __unsafe_unretained IBOutlet FCSecondAlphabetView *secondAlphabetView;
  
  MBProgressHUD *progressHud_;
  gameType type;
  
  IBOutlet UIImageView *imageView;
  CGPoint currentTouch;
  CGPoint lastTouch;
  IBOutlet FCTestView *testView1;
  IBOutlet FCTestView *testView2;
  IBOutlet UILabel *remainingTimeLabel;
  IBOutlet UIImageView *crossImageView1;
  IBOutlet UIImageView *checkImageView2;
  int remainingTime;
  int remainingFreezTime;
  NSTimer *freezTimer;
  NSTimer *timer;
  NSTimer *completionCheckTimer;
  
  IBOutlet UIView *alertView_;
  IBOutlet UILabel *numberOfCoinsWinLabel;
  IBOutlet UILabel *currentStageLabel;
  
  NSInteger numberOfStageComplete;
  
  IBOutlet UIView *infoView;
  IBOutlet UIButton *pauseButton;
  IBOutlet UIButton *freezButton;
}


@property (nonatomic,assign) gameType type;

@property (nonatomic,assign) FCFirstAlphabetView *firstAlphabetView;
@property (nonatomic,assign) FCSecondAlphabetView *secondAlphabetView;


- (IBAction)pauseGame:(id)sender;
- (IBAction)rateApp:(id)sender;
- (void) lineGoingOutSideShowAlert ;
- (IBAction)startGameFromInitial:(id)sender;
- (IBAction)goToHome:(id)sender;
- (IBAction)removeInfoView:(id)sender;
- (IBAction)goToStore:(id)sender;

@end

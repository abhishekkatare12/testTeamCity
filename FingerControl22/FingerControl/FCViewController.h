//
//  FCViewController.h
//  FingerControl
//
//  Created by Dinesh on 20/11/12.
//
//

#import <UIKit/UIKit.h>
#import "FlurryAdDelegate.h"
#import "FacebookManager.h"
#import "MBProgressHUD.h"
#import "AdWhirlView.h"
#import "FCCommenMethods.h"
#import <RevMobAds/RevMobAds.h>

@interface FCViewController : UIViewController <UIAlertViewDelegate,FacebookManagerDelegate,AdWhirlDelegate,RevMobAdsDelegate>
{

IBOutlet UIImageView *bgImageView;
  IBOutlet UIButton *btnPlay;
  IBOutlet UIButton *btnStore;
  IBOutlet UIButton *btnMore;
  UIAlertView *alert;
  MBProgressHUD *progressHud_;
  AdWhirlView *adView;
  
  IBOutlet UIView *infoView;

}

@property(nonatomic,readonly)IBOutlet UIButton *btnPlay;
@property(nonatomic,readonly)  IBOutlet UIButton *btnStore;
@property(nonatomic,readonly)IBOutlet UIButton *btnMore;
-(IBAction)btnPlayClicked:(id)sender;
-(IBAction)btnMoreClicked:(id)sender;
-(IBAction)btnStoreClicked:(id)sender;
-(IBAction)showFullScreenAdClickedButton:(id)sender;
-(void)dismissAlertView;
- (IBAction)ShareFacebook;
@end

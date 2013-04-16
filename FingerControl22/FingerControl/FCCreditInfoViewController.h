//
//  FCCreditInfoViewController.h
//  FingerControl
//
//  Created by Abhishek sharma on 22/11/12.
//
//

#import <UIKit/UIKit.h>
#import "Flurry.h"
#import "FlurryAds.h"
#import "AdWhirlView.h"
#import <RevMobAds/RevMobAds.h>
#import "MBProgressHUD.h"

@interface FCCreditInfoViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,AdWhirlDelegate,RevMobAdsDelegate> {
  IBOutlet UIScrollView *scrollView;
  IBOutlet UILabel *balanceLabel;
  IBOutlet UIImageView* balanceBack;
  IBOutlet UIButton *freezTimeButton;
  IBOutlet UIButton *firstColorSetTimeButton;
  IBOutlet UIButton *secondColorSetTimeButton;
  
  IBOutlet UIButton *firstCharacterSetPurchaseButton;
  IBOutlet UIButton *secondCharacterSetPurchaseButton;
  IBOutlet UIButton *thirdCharacterSetPurchaseButton;
  
  MBProgressHUD *progressHud_;
  
  AdWhirlView *adView;
  AdWhirlView *adWhirlView;
}

-(IBAction)goBack:(id)sender;
-(IBAction)openStore:(id)sender;
- (IBAction)colorSetPurchase:(id)sender;
- (IBAction)freezeTimePurchase:(id)sender;

- (IBAction)firstCharacterSetPurchase:(id)sender;
- (IBAction)secondCharacterSetPurchase:(id)sender;
- (IBAction)thirdCharacterSetPurchase:(id)sender;


@end

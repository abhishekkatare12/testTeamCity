//
//  FCSelectGameMode.h
//  FingerControl
//
//  Created by Dinesh on 20/11/12.
//
//

#import <UIKit/UIKit.h>
#import "FlurryAdDelegate.h"
#import "AdWhirlView.h"

@interface FCSelectGameMode : UIViewController <AdWhirlDelegate>{
  

  IBOutlet UIImageView *bgImageView;
  IBOutlet UIButton *btnFreeplay;
  IBOutlet UIButton *btnTimeattack;
  AdWhirlView *adView;
  BOOL goToStore;
  BOOL showAd;
  AdWhirlView *adWhirlView;
  IBOutlet UIButton *backButton_;

}

@property (nonatomic,assign) BOOL goToStore;
@property (nonatomic,assign) BOOL showAd;

@property(nonatomic,retain)IBOutlet UIButton *btnFreeplay;
@property(nonatomic,retain)IBOutlet UIButton *btnTimeattack;
-(IBAction)goBack:(id)sender;
-(IBAction)test;


@end

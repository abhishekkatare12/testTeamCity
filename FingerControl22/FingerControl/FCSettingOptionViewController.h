//
//  FCSettingOptionViewController.h
//  FingerControl
//
//  Created by Abhishek sharma on 06/12/12.
//
//

#import <UIKit/UIKit.h>

@interface FCSettingOptionViewController : UIViewController {
  
  IBOutlet UIButton *currentLeftColorImage;
  IBOutlet UIButton *currentRightColorImage;
  
  IBOutlet UISlider *volumeSlider;
  IBOutlet UISwitch *soundSwitch;

}

- (IBAction)changePlaySound:(UISwitch* )sender;

@end

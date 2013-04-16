//
//  FCSettingOptionViewController.m
//  FingerControl
//
//  Created by Abhishek sharma on 06/12/12.
//
//

#import "FCSettingOptionViewController.h"
#import "FCCommenMethods.h"
#import "FCColorChooseViewController.h"

@interface FCSettingOptionViewController ()

@end

@implementation FCSettingOptionViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

  if (FCCOMMEN.playBackgroundSound) {
    [soundSwitch setOn:YES];
  }
  else {
    [soundSwitch setOn:NO];
  }
}

- (void) viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  NSLog(@"%@,%@",FCCOMMEN.leftDrawColorImage,FCCOMMEN.rightDrawColorImage);
  [currentLeftColorImage setImage:FCCOMMEN.leftDrawColorImage forState:UIControlStateNormal];
  [currentRightColorImage setImage:FCCOMMEN.rightDrawColorImage forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
  return (toInterfaceOrientation ==UIInterfaceOrientationLandscapeLeft | toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (IBAction)changePlaySound:(UISwitch* )sender {
  if ([sender isOn]) {
    [FCCOMMEN setPlayBackgroundSound:YES];
    [FCCOMMEN playSound];
  }
  else {
    [FCCOMMEN setPlayBackgroundSound:NO];
    [FCCOMMEN stopSound];
  }


}

- (IBAction)changePlaySoundVolume:(UISlider* )sender {
  
    [[FCCOMMEN player] setVolume:sender.value];
    [FCCOMMEN playSound];
 
}

- (IBAction)changeColorClicked:(UIButton* )sender {
  if (getColorsArray().count > 0) {
    FCColorChooseViewController *chooseColorController = [[FCColorChooseViewController alloc] initWithNibName:@"FCColorChooseViewController" bundle:nil];
    if ([sender tag] == 1) {
      [chooseColorController setForLeft:YES];
    }
    else {
     [chooseColorController setForLeft:NO];
    }
    [[self navigationController] pushViewController:chooseColorController animated:YES];
  }
}


- (IBAction)goBack:(id)sender {

  [self.navigationController popViewControllerAnimated:YES];
}

@end

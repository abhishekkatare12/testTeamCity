//
//  FCColorChooseViewController.h
//  FingerControl
//
//  Created by Abhishek sharma on 06/12/12.
//
//

#import <UIKit/UIKit.h>

@interface FCColorChooseViewController : UIViewController {
  NSArray *colorsArray;
  NSArray *colorImagesArray;
  BOOL forLeft;
  
  
}
@property (nonatomic,assign) BOOL forLeft;
@end

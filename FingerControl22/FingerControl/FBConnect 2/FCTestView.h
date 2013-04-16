//
//  FCTestView.h
//  FingerControl
//
//  Created by Abhishek sharma on 26/11/12.
//
//

#import <UIKit/UIKit.h>
#import "FCCommenMethods.h"

@interface FCTestView : UIView {
  CGPoint testPoint;
  BOOL firstTime;
  UIBezierPath *pathTest;
  CGPoint lastpont;
  CGPoint endPoint;
  UIImage *testImage;
    
}


@property (nonatomic,retain) UIBezierPath *pathTest;
@property (nonatomic,retain) UIImage *testImage;
@property (nonatomic,assign) CGPoint lastpont;
@property (nonatomic,assign) CGPoint endPoint;


@end

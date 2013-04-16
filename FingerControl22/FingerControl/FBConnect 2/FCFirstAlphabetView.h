//
//  FCFirstAlphabetView.h
//  FingerControl
//
//  Created by Abhishek sharma on 23/11/12.
//
//

#import <UIKit/UIKit.h>
#import "FCShapeModel.h"
#import "FCTestView.h"
#import "FCMainPlayViewController.h"

@class FCMainPlayViewController;
@interface FCFirstAlphabetView : UIView {

 
  CGPoint lastpont;
  CGPoint endPoint;
  FCShapeModel *currentShape;
  BOOL startDrawing; //for the very first time it shoul be yes when we have point to draw
  BOOL isTouched; // to check if other view is touched or not
  
  UIImage *currentIamge;
  BOOL isPerfetInside;
  BOOL notFirstTime; // to set isPerfetInside = YES;
  
  FCTestView *testView;
  __unsafe_unretained FCMainPlayViewController *controller;
}

@property (nonatomic,assign) FCMainPlayViewController *controller;
@property (nonatomic,retain) FCTestView *testView;
@property (nonatomic,retain) UIImage *currentIamge;

@property (nonatomic,assign) CGPoint lastpont;
@property (nonatomic,assign) BOOL isPerfetInside;
@property (nonatomic,assign) BOOL isTouched;
@property (nonatomic,assign) BOOL startDrawing;
@property (nonatomic,retain) UIImageView *testImageView;

@property (nonatomic,retain)  FCShapeModel *currentShape;

- (void) drawRectWithNewPoint:(CGPoint)point;
- (BOOL) checkForPerfectInside;
@end

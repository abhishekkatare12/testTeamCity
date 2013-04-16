//
//  FCFirstAlphabetView.m
//  FingerControl
//
//  Created by Abhishek sharma on 23/11/12.
//
//

#import "FCFirstAlphabetView.h"
#import "FCBezierPath.h"

@implementation FCFirstAlphabetView
@synthesize testView;
@synthesize lastpont;
@synthesize currentShape;
@synthesize testImageView;
@synthesize isPerfetInside;
@synthesize isTouched;
@synthesize controller;
@synthesize currentIamge;
@synthesize startDrawing;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

- (void) drawRectWithNewPoint:(CGPoint)point {
  
  endPoint = point;
  startDrawing = YES;
  [self setNeedsDisplay];
  
  
  
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
  // Drawing code
  
  //********************Drawing outer path of shape***********************************
  if (self.currentShape) {
   
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor blueColor].CGColor);
    for (FCBezierPath *path in [self.currentShape originalBezierPathArray]) {
      [path.bezierPath stroke];
      
    }
    [testView.pathTest stroke];
  }
  //***********************************************************************************
  if (!notFirstTime) {
    isPerfetInside = YES;
    notFirstTime = YES;
  }
  
  if (startDrawing) {
    
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (currentIamge) {
      [currentIamge drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context,LINEWIDTH);
    
   
    if (FCCOMMEN.userSelectedCustomDrawingColor) {
      CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), ([FCCOMMEN.leftDrawColor CGColor]));
    }
    else {
      CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor redColor].CGColor);
    }
    CGContextSetBlendMode(context,kCGBlendModeDarken );
    
    
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, lastpont.x, lastpont.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    
    //******************Cheking image on the path**********************
    if (isPerfetInside) {
      
      for (int i = 0; i < [self.currentShape originalBezierPathArray].count; i++) {
        FCBezierPath *path = (FCBezierPath* )[[self.currentShape originalBezierPathArray] objectAtIndex:i];
        if ([path checkOuter]) {// point should be out side of this path
          if ([self isOutSidePoint:path]) {
            isPerfetInside = YES;
            
          }
          else {
            isPerfetInside = NO;
            [controller lineGoingOutSideShowAlert];
            
            break;
          }
        }
        else { // point should be In side of this path
          if ([self isInSidePoint:path]) {
            isPerfetInside = YES;
          }
          else {
            isPerfetInside = NO;
            [controller lineGoingOutSideShowAlert];
            break;
          }
        }
      }
      
    }
    
    //*****************************************************************
    
    
    CGContextStrokePath(context);
    currentIamge = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [currentIamge drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    [testView setEndPoint:endPoint];
    [testView setLastpont:lastpont];
    [testView setNeedsDisplay];
    
    lastpont = endPoint;
    
    
  }
  
}

#pragma mark Touch Delegate Methods

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  isTouched = YES;
  [self setLastpont:[touch locationInView:self]];
  
  
}

//*****************************************************************************
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  
  UITouch *touch = [touches anyObject];
 // if (controller.secondAlphabetView.isTouched) {
    [self drawRectWithNewPoint:[touch locationInView:self]];
 // }
  
  
  
}

//*****************************************************************************
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  
}

//*****************************************************************************
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  isTouched = NO;
  [self setLastpont:[touch locationInView:self]];
  
}

- (BOOL) checkForPerfectInside {
  //******************Cheking image on the path**********************
  if (isPerfetInside) {
    
    for (int i = 0; i < [self.currentShape originalBezierPathArray].count; i++) {
      FCBezierPath *path = (FCBezierPath* )[[self.currentShape originalBezierPathArray] objectAtIndex:i];
      if ([path checkOuter]) {// point should be out side of this path
        if ([self isOutSidePoint:path]) {
          isPerfetInside = YES;
          
        }
        else {
          isPerfetInside = NO;
          break;
        }
      }
      else { // point should be In side of this path
        if ([self isInSidePoint:path]) {
          isPerfetInside = YES;
        }
        else {
          isPerfetInside = NO;
          break;
        }
      }
    }
  }
  if (isPerfetInside) {
    NSLog(@"Going Right in the range");
  }
  else {
    NSLog(@"Going OutSide the range");
    [[[UIAlertView alloc] initWithTitle:@"OOPS!" message:@"Going OutSide the range" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
  }
  return isPerfetInside;  //*****************************************************************
}


//*****************************************************************************
#pragma mark Private Methods
//*****************************************************************************

- (BOOL)isOutSidePoint:(FCBezierPath* )path {
  NSInteger deltaValue;
  if ([[FCCommenMethods sharedInstance] isEasyMode]) {
    deltaValue = EASYCOMPAREDELTA;
  }
  else deltaValue = COMPAREDELTA;
  
  CGPathRef pathRef = path.bezierPath.CGPath;
  BOOL checking1 = CGPathContainsPoint(pathRef, nil,CGPointMake(endPoint.x - deltaValue, endPoint.y), false);
  BOOL checking2 = CGPathContainsPoint(pathRef, nil,CGPointMake(endPoint.x + deltaValue, endPoint.y), false);
  BOOL checking3 = CGPathContainsPoint(pathRef, nil,CGPointMake(endPoint.x,endPoint.y - deltaValue), false);
  BOOL checking4 = CGPathContainsPoint(pathRef, nil,CGPointMake(endPoint.x, endPoint.y + deltaValue), false);
  
  
  if (checking1 || checking2 || checking3 || checking4 ) { //|| checking5 || checking6 || checking7 || checking8
    NSString *innerPoint ;
    if (checking1)
      innerPoint = @"checking1";
    else if (checking2)
      innerPoint = @"checking2";
    else if (checking3)
      innerPoint = @"checking3";
    else if (checking4)
      innerPoint = @"checking4";
  
    
    
    NSLog(@"inner Point is :%@",innerPoint);
    return NO;
  }
  else
    return YES;
  
  
}

- (BOOL)isInSidePoint:(FCBezierPath* )path {
  NSInteger deltaValue;
  if ([[FCCommenMethods sharedInstance] isEasyMode]) {
    deltaValue = EASYCOMPAREDELTA;
  }
  else deltaValue = COMPAREDELTA;
  
  CGPathRef pathRef = path.bezierPath.CGPath;
  BOOL checking1 = CGPathContainsPoint(pathRef, nil,CGPointMake(endPoint.x - deltaValue, endPoint.y), false);
  BOOL checking2 = CGPathContainsPoint(pathRef, nil,CGPointMake(endPoint.x + deltaValue, endPoint.y), false);
  BOOL checking3 = CGPathContainsPoint(pathRef, nil,CGPointMake(endPoint.x,endPoint.y - deltaValue), false);
  BOOL checking4 = CGPathContainsPoint(pathRef, nil,CGPointMake(endPoint.x, endPoint.y + deltaValue), false);
  
  BOOL checking5 = CGPathContainsPoint(pathRef, nil,CGPointMake(endPoint.x - deltaValue, endPoint.y-deltaValue), false);
  BOOL checking6 = CGPathContainsPoint(pathRef, nil,CGPointMake(endPoint.x + deltaValue, endPoint.y-deltaValue), false);
  BOOL checking7 = CGPathContainsPoint(pathRef, nil,CGPointMake(endPoint.x - deltaValue,endPoint.y + deltaValue), false);
  BOOL checking8 = CGPathContainsPoint(pathRef, nil,CGPointMake(endPoint.x + deltaValue, endPoint.y + deltaValue), false);
  
  if (checking1 && checking2 && checking3 && checking4) {//&& checking5 && checking6 && checking7 && checking8
    return YES;
  }
  else {
    NSString *innerPoint ;
    if (!checking1)
      innerPoint = @"checking1";
    else if (!checking2)
      innerPoint = @"checking2";
    else if (!checking3)
      innerPoint = @"checking3";
    else if (!checking4)
      innerPoint = @"checking4";
    else if (!checking5)
      innerPoint = @"checking5";
    else if (!checking6)
      innerPoint = @"checking6";
    else if (!checking7)
      innerPoint = @"checking7";
    else if (!checking8)
      innerPoint = @"checking8";
    
    
    
    NSLog(@"Outer Point is :%@",innerPoint);
    
    return NO;
  }
  
  
  
}




@end

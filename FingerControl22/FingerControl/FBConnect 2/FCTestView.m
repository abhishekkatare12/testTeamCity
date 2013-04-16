//
//  FCTestView.m
//  FingerControl
//
//  Created by Abhishek sharma on 26/11/12.
//
//

#import "FCTestView.h"


@implementation FCTestView

@synthesize pathTest;
@synthesize lastpont,endPoint;
@synthesize testImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  
  
  UIGraphicsBeginImageContext(self.frame.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor colorWithRed:111.0f/255 green:181.0f/255 blue:253.0f/255 alpha:1].CGColor);
  [pathTest stroke];
  if (testImage) {
    [testImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
  }
  
  CGContextSetLineCap(context, kCGLineCapRound);
  CGContextSetLineWidth(context,LINEWIDTH+12);
  
  CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor blackColor].CGColor);
  CGContextSetBlendMode(context,kCGBlendModeDarken );
  
  
  
  CGContextBeginPath(context);
  CGContextMoveToPoint(context, lastpont.x, lastpont.y);
  CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
  CGContextStrokePath(context);
  testImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  [testImage drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
  
}



- (UIBezierPath* )getBezierPathFirstTime {
  UIBezierPath *aPath = [UIBezierPath bezierPath];
  
  
  [aPath moveToPoint:CGPointMake(16.0, 128.0)];
  [aPath addLineToPoint:CGPointMake(77.0, 20.0)];
  // Set the starting point of the shape.
  // Draw the lines.
  //[aPath addLineToPoint:CGPointMake(100.0, 3.0)];
  [aPath addLineToPoint:CGPointMake(102, 20)];
  [aPath addLineToPoint:CGPointMake(157, 128)];
  [aPath addLineToPoint:CGPointMake(132.0, 128.0)];
  [aPath addLineToPoint:CGPointMake(118.0, 98.0)];
  [aPath addLineToPoint:CGPointMake(60.0, 98)];
  [aPath addLineToPoint:CGPointMake(41.0, 128.0)];
  
  
  [aPath closePath];
  aPath.lineWidth = 2.0;
  return aPath;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
 
   testPoint = [touch locationInView:self];
  firstTime = YES;
  [self setNeedsDisplay];
  
  
}

//*****************************************************************************
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  UITouch *touch = [touches anyObject];
  testPoint = [touch locationInView:self];
  [self setNeedsDisplay];
}


@end

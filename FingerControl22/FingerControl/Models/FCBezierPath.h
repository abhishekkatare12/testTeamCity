//
//  FCBezierPath.h
//  FingerControl
//
//  Created by Abhishek sharma on 26/11/12.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface FCBezierPath : NSObject {
  UIBezierPath *bezierPath;
  BOOL checkOuter;// set YES if the current point should not be "in side" current bezierPath
}
@property (nonatomic,retain)  UIBezierPath *bezierPath;
@property (nonatomic,assign)  BOOL checkOuter;

@end

//
//  FCShapeModel.h
//  FingerControl
//
//  Created by Abhishek sharma on 26/11/12.
//
//

#import <Foundation/Foundation.h>

@interface FCShapeModel : NSObject {
  NSArray *compareBezierPathArray;
  NSString *character;
  NSArray *originalBezierPathArray;

}
@property (nonatomic,retain ) NSArray *compareBezierPathArray;
@property (nonatomic,retain ) NSString *character;
@property (nonatomic,retain )  NSArray *originalBezierPathArray;

@end

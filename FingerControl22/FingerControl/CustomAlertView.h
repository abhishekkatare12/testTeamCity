//
//  CustomAlertView.h
//  CustomAlert
//
//  Created by Aaron Crabtree on 10/14/11.
//  Copyright (c) 2011 Tap Dezign, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CustomAlertView : UIAlertView {
    UIImage *backImage;
    UIColor *textColor;
}
@property (nonatomic,retain) UIColor *textColor;
@property (nonatomic,retain) UIImage* backImage;

@end

//
//  UIView+ScreensShot.m
//  MyFramework
//
//  Created by 张发政 on 2017/1/12.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "UIView+ScreensShot.h"

@implementation UIView (ScreensShot)

- (UIImage *)screenShot {
    
    if (self && self.frame.size.height && self.frame.size.width) {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
        
    } else {
        
        return nil;
    }
}



@end

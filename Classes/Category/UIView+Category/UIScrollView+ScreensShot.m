//
//  UIScrollView+ScreensShot.m
//  TokenViewWallet
//
//  Created by 张发政 on 2018/11/8.
//  Copyright © 2018 北京芯智引擎科技有限公司. All rights reserved.
//

#import "UIScrollView+ScreensShot.h"

@implementation UIScrollView (ScreensShot)

- (UIImage *)captureScrollView
{
    UIImage* image =nil;
    UIGraphicsBeginImageContextWithOptions(self.contentSize,NO,0.0);
    {
        CGPoint savedContentOffset = self.contentOffset;
        CGRect savedFrame = self.frame;
        self.contentOffset= CGPointZero;
        self.frame= CGRectMake(0, 0, self.contentSize.width,self.contentSize.height);
        
        [self.layer renderInContext: UIGraphicsGetCurrentContext()];
        image= UIGraphicsGetImageFromCurrentImageContext();
        
        self.contentOffset= savedContentOffset;
        self.frame= savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if(image != nil) {
        return image;
    }
    return nil;
}

@end

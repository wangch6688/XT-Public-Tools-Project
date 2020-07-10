//
//  UIView+ScreensShot.h
//  MyFramework
//
//  Created by 张发政 on 2017/1/12.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ScreensShot)
/**
 *  无损截图
 *
 *  This function may be called from any thread of your app.
 *
 *  @return 返回生成的图片
 */
- (UIImage *)screenShot;
@end

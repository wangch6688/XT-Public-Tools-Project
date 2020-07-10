//
//  UIImage+Save.m
//  TokenViewWallet
//
//  Created by 张发政 on 2018/11/9.
//  Copyright © 2018 北京芯智引擎科技有限公司. All rights reserved.
//

#import "UIImage+Save.h"

@implementation UIImage (Save)


- (void)saveButtonEventWithImageWithDelgate:(id)delgate
{
    //保存完后调用的方法
    SEL selector = @selector(onCompleteCapture:didFinishSavingWithError:contextInfo:);
    //保存
    UIImageWriteToSavedPhotosAlbum(self, delgate, selector, NULL);
}

//图片保存完后调用的方法
- (void)onCompleteCapture:(UIImage *)screenImage didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error){
        //保存失败
    }else {
        //保存成功
    }
}

@end

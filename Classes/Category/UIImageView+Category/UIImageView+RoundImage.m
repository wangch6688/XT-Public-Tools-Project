//
//  UIImageView+RoundImage.m
//  MyMVVMFramework
//
//  Created by 张发政 on 2017/6/26.
//  Copyright © 2017年 zhangfazheng. All rights reserved.
//

#import "UIImageView+RoundImage.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/SDWebImageManager.h>
#import "SDImageCache.h"
#import <Reachability.h>
#import <ReactiveObjC.h>
#import "XTUtilsMacros.h"

@implementation UIImageView (RoundImage)
- (void)setImageWithCornerRadius:(CGFloat)radius imageURL:(NSURL *)imageURL placeholder:(NSString *)placeholder size:(CGSize)size
{
    [self setImageWithHTRadius:RadiusMake(radius, radius, radius, radius) imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:UIViewContentModeScaleAspectFill size:size];
}
- (void)setImageWithCornerRadius:(CGFloat)radius imageURL:(NSURL *)imageURL placeholder:(NSString *)placeholder contentMode:(UIViewContentMode)contentMode size:(CGSize)size
{
    [self setImageWithHTRadius:RadiusMake(radius, radius, radius, radius) imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:contentMode size:size];
}
- (void)setImageWithHTRadius:(ImageRadius)radius imageURL:(NSURL *)imageURL placeholder:(NSString *)placeholder contentMode:(UIViewContentMode)contentMode size:(CGSize)size
{
    [self setImageWithHTRadius:radius imageURL:imageURL placeholder:placeholder borderColor:nil borderWidth:0 backgroundColor:nil contentMode:contentMode size:size];
}
-(void)setImageWithHTRadius:(ImageRadius)radius imageURL:(NSURL *)imageURL placeholder:(NSString *)placeholder borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size
{
    NSString *cacheurlStr = [NSString stringWithFormat:@"%@%@%.0f",imageURL,@"radiusCache",radius.topLeftRadius];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
    
    if (cacheImage) {
        self.image =  cacheImage;
        return;

    }
    
    UIImage *placeholderImage;
    if (placeholder || borderWidth > 0 || backgroundColor) {
        NSString *placeholderKey = [NSString stringWithFormat:@"%@-%@", placeholder, placeholder];
        placeholderImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:placeholderKey];
        
        if (!placeholderImage) {
            placeholderImage = [UIImage setRadius:radius image:[UIImage imageNamed:placeholder] size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
//            [[SDImageCache sharedImageCache] storeImage:placeholderImage forKey:placeholderKey];
            [[SDImageCache sharedImageCache] storeImage:placeholderImage forKey:placeholderKey completion:nil];
            
        }
        
    }
    self.image = placeholderImage;
    
    if ([imageURL absoluteString].length==0) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    if ([self.superview isKindOfClass:[UITableViewCell class]] || [self.superview isKindOfClass:[UICollectionViewCell class]]) {
        //cell复用时取消图片加载
        RACSignal *untilSiganl = ((UITableViewCell *)(self.superview)).rac_prepareForReuseSignal;
        
        [[[self downloadImageWithURL:[imageURL absoluteString] placeholder:placeholder] takeUntil:untilSiganl]subscribeNext:^(NSDictionary * x) {
            if ([x[@"suc"] boolValue]) {
                UIImage *currentImage = [UIImage setRadius:radius image:x[@"image"] size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
                weakSelf.image = currentImage;
//                [[SDImageCache sharedImageCache] storeImage:currentImage forKey:cacheurlStr];
                [[SDImageCache sharedImageCache] storeImage:currentImage forKey:cacheurlStr toDisk:YES completion:nil];
                //清除原有非圆角图片缓存
                [[SDImageCache sharedImageCache] removeImageForKey:[NSString stringWithFormat:@"%@",imageURL] withCompletion:nil];
            }else{
                weakSelf.image = x[@"image"];
            }
        }];
    }else{
        [[self downloadImageWithURL:[imageURL absoluteString] placeholder:placeholder] subscribeNext:^(NSDictionary * x) {
            if ([x[@"suc"] boolValue]) {
                UIImage *currentImage = [UIImage setRadius:radius image:x[@"image"] size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
                weakSelf.image = currentImage;
                [[SDImageCache sharedImageCache] storeImage:currentImage forKey:cacheurlStr toDisk:YES completion:nil];
                //清除原有非圆角图片缓存
                [[SDImageCache sharedImageCache] removeImageForKey:[NSString stringWithFormat:@"%@",imageURL] withCompletion:nil];
            }else{
                weakSelf.image = x[@"image"];
            }
        }];
    }
    
}

- (UIImage *)rh_bezierPathClip:(UIImage *)img
                  cornerRadius:(CGFloat)cornerRadius {
    int w = img.size.width * img.scale;
    int h = img.size.height * img.scale;
    CGRect rect = (CGRect){CGPointZero, CGSizeMake(w, h)};
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), false, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    [img drawInRect:rect];
    UIImage *cornerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cornerImage;
}

- (UIImage *)rh_getCornerImage:(UIImage *)image
                  cornerRadius:(CGFloat)cornerRadius {
    UIImage *cornerImage = image;
    
    CGFloat width = image.size.width * image.scale;
    CGFloat height = image.size.height * image.scale;
    CGFloat radius = cornerRadius * image.scale;
    CGSize size = CGSizeMake(width, height);
    
    CGRect rect = (CGRect){CGPointZero, size};
    UIGraphicsBeginImageContextWithOptions(size, false, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, radius);
    CGContextAddArcToPoint(context, 0, 0, radius, 0, radius);
    CGContextAddLineToPoint(context, width - radius, 0);
    CGContextAddArcToPoint(context, width, 0, width, radius, radius);
    CGContextAddLineToPoint(context, width, height - radius);
    CGContextAddArcToPoint(context, width, height, width - radius, height, radius);
    CGContextAddLineToPoint(context, radius, height);
    CGContextAddArcToPoint(context, 0, height, 0, height - radius, radius);
    CGContextAddLineToPoint(context, 0, radius);
    CGContextClosePath(context);
    
    CGContextClip(context);
    
    [image drawInRect:rect];       // 画图
    CGContextDrawPath(context, kCGPathFill);
    // CGContextDrawImage(context, rect, cornerImage.CGImage); // 同上
    
    cornerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cornerImage;
}

-(void)setImagesWithRadius:(ImageRadius)radius imagesURLStrArray:(NSArray<NSString *> *)imagesURLStrArray placeholder:(NSString *)placeholder borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth backgroundColor:(UIColor *)backgroundColor contentBackgroundColor:(UIColor *)contentBackgroundColor contentMode:(UIViewContentMode)contentMode size:(CGSize)size{
    //获取图片缓存
    if (imagesURLStrArray.count == 1) {
//        dispatch_group_t group = dispatch_group_create();
//        dispatch_group_enter(group);
//        UIImage * currentImage = [UIImage new];
//        __weak UIImage * newImage = currentImage;
        [self sd_setImageWithURL:[NSURL URLWithString:imagesURLStrArray.firstObject] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            newImage = image;
//            dispatch_group_leave(group);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = [self rh_getCornerImage:image cornerRadius:size.width];
            });
        }];
//        dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            //读取完数据之后，再将部门，用户，标记插入。
//
//        });
        return;
    }
    NSString *cacheurlStr = [NSString stringWithFormat:@"%@%@",[imagesURLStrArray componentsJoinedByString:@""] ,@"groupradiusCache"];
    UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
    if (cacheImage) {
        self.image =  cacheImage;
        return;
        
    }
    
    //占位图
    UIImage *placeholderImage;
    if (placeholder || borderWidth > 0 || backgroundColor) {
        NSString *placeholderKey = [NSString stringWithFormat:@"%@-%@", placeholder, placeholder];
        //从缓存中获取图片
        placeholderImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:placeholderKey];
        
        //如果没有，创建一个圆角图片
        if (!placeholderImage) {
            placeholderImage = [UIImage setRadius:radius image:[UIImage imageNamed:placeholder] size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
            [[SDImageCache sharedImageCache] storeImage:placeholderImage forKey:placeholderKey toDisk:YES completion:nil];
        }
        
    }
    //设置占位图
    self.image = placeholderImage;
    
    NSMutableArray *signerArray = [NSMutableArray arrayWithCapacity:imagesURLStrArray.count];
    
    for (NSString *urlStr in imagesURLStrArray) {
        [signerArray addObject:[self downloadImageWithURL:urlStr placeholder:placeholder]];
    }
    //cell复用时取消图片加载
    RACSignal *untilSiganl = [RACSignal empty];
    
    if ([self.superview isKindOfClass:[UITableViewCell class]] || [self.superview isKindOfClass:[UICollectionViewCell class]]) {
        untilSiganl = ((UITableViewCell *)(self.superview)).rac_prepareForReuseSignal;
    }
    __weak typeof(self) weakSelf = self;
    switch (signerArray.count) {
        case 1:{
            [[[RACSignal combineLatest:signerArray reduce:^id(NSDictionary *image){
                return @[image];
            }]takeUntil:untilSiganl]subscribeNext:^(NSArray * x) {
                //标识是否进行缓存,如果图片下载失败不进行缓存
                BOOL isSave = [x[0][@"suc"] boolValue];
                //图片合并
                UIImage * combineImage = [weakSelf groupIconWith:@[x[0][@"image"]] bgColor:contentBackgroundColor];
                //图片添加圆角
                UIImage *currentImage = [UIImage setRadius:radius image:combineImage size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
                weakSelf.image = currentImage;
                //对图片进行缓存,如果图片下载失败不进行缓存
                if (isSave) {
                    [[SDImageCache sharedImageCache] storeImage:currentImage forKey:cacheurlStr toDisk:YES completion:nil];
                }
                
            }];
            break;
            
        }case 2:{
            [[[RACSignal combineLatest:signerArray reduce:^id(NSDictionary *image1,NSDictionary *image2){
                return @[image1,image2];
            }]takeUntil:untilSiganl]subscribeNext:^(NSArray * x) {
                BOOL isSave = YES;
                NSMutableArray * imageArray = [NSMutableArray arrayWithCapacity:x.count];
                for (NSDictionary *dic in x) {
                    if (![dic[@"suc"] boolValue]) {
                        isSave = NO;
                    }
                    [imageArray addObject:dic[@"image"]];
                }
                //图片合并
                UIImage * combineImage = [weakSelf groupIconWith:imageArray bgColor:contentBackgroundColor];
                //图片添加圆角
                UIImage *currentImage = [UIImage setRadius:radius image:combineImage size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
                weakSelf.image = currentImage;
                //对图片进行缓存,如果图片下载失败不进行缓存
                if (isSave) {
                    [[SDImageCache sharedImageCache] storeImage:currentImage forKey:cacheurlStr toDisk:YES completion:nil];
                }
            }];
            break;
        }
        case 3:{
            [[[RACSignal combineLatest:signerArray reduce:^id(NSDictionary *image1,NSDictionary *image2,NSDictionary *image3){
                return @[image1,image2,image3];
            }]takeUntil:untilSiganl]subscribeNext:^(NSArray * x) {
                BOOL isSave = YES;
                NSMutableArray * imageArray = [NSMutableArray arrayWithCapacity:x.count];
                for (NSDictionary *dic in x) {
                    if (![dic[@"suc"] boolValue]) {
                        isSave = NO;
                    }
                    [imageArray addObject:dic[@"image"]];
                }
                //图片合并
                UIImage * combineImage = [weakSelf groupIconWith:imageArray bgColor:contentBackgroundColor];
                //图片添加圆角
                UIImage *currentImage = [UIImage setRadius:radius image:combineImage size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
                weakSelf.image = currentImage;
                //对图片进行缓存,如果图片下载失败不进行缓存
                if (isSave) {
                    [[SDImageCache sharedImageCache] storeImage:currentImage forKey:cacheurlStr toDisk:YES completion:nil];
                }
            }];
            break;
        }case 4:{
            [[[RACSignal combineLatest:signerArray reduce:^id(NSDictionary *image1,NSDictionary *image2,NSDictionary *image3,NSDictionary *image4){
                return @[image1,image2,image3,image4];
            }]takeUntil:untilSiganl] subscribeNext:^(NSArray * x) {
                BOOL isSave = YES;
                NSMutableArray * imageArray = [NSMutableArray arrayWithCapacity:x.count];
                for (NSDictionary *dic in x) {
                    if (![dic[@"suc"] boolValue]) {
                        isSave = NO;
                    }
                    [imageArray addObject:dic[@"image"]];
                }
                //图片合并
                UIImage * combineImage = [weakSelf groupIconWith:imageArray bgColor:contentBackgroundColor];
                //图片添加圆角
                UIImage *currentImage = [UIImage setRadius:radius image:combineImage size:size borderColor:borderColor borderWidth:borderWidth backgroundColor:backgroundColor withContentMode:contentMode];
                weakSelf.image = currentImage;
                //对图片进行缓存,如果图片下载失败不进行缓存
                if (isSave) {
                    [[SDImageCache sharedImageCache] storeImage:currentImage forKey:cacheurlStr toDisk:YES completion:nil];
                }
            }];
            break;
        }
        default:
            break;
    }
    
}

#pragma mark- 下载图片
- (RACSignal *)downloadImageWithURL:(NSString *)urlStr placeholder:(NSString *)placeholder{
    RACSignal *signal =[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        if (!isEmptyString(urlStr)) {
            NSURL *imageURL = [NSURL URLWithString:urlStr];
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            [manager loadImageWithURL:imageURL options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                // 处理下载进度
            } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                if (image) {
                    [subscriber sendNext:@{@"image":image,@"suc":@1}];
                }else{
                    [subscriber sendNext:@{@"image":[UIImage imageNamed:placeholder],@"suc":@0}];
                }
            }];
        }else{
            [subscriber sendNext:@{@"image":[UIImage imageNamed:placeholder],@"suc":@0}];
        }
        
        
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
    
    return signal;
}

- (UIImage *)groupIconWith:(NSArray *)array bgColor:(UIColor *)bgColor {
    
    CGSize finalSize = CGSizeMake(100, 100);
    CGRect rect = CGRectZero;
    rect.size = finalSize;
    
    UIGraphicsBeginImageContext(finalSize);
    
    if (bgColor) {
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, bgColor.CGColor);
        CGContextSetFillColorWithColor(context, bgColor.CGColor);
        CGContextSetLineWidth(context, 1.0);
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 0, 100);
        CGContextAddLineToPoint(context, 100, 100);
        CGContextAddLineToPoint(context, 100, 0);
        CGContextAddLineToPoint(context, 0, 0);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
    
    if (array.count >= 2) {
        
        NSArray *rects = [self eachRectInGroupWithCount2:array.count];
        int count = 0;
        for (id obj in array) {
            
            if (count > rects.count-1) {
                break;
            }
            
            UIImage *image;
            
            if ([obj isKindOfClass:[NSString class]]) {
                image = [UIImage imageNamed:(NSString *)obj];
            } else if ([obj isKindOfClass:[UIImage class]]){
                image = (UIImage *)obj;
            } else {
                NSLog(@"%s Unrecognizable class type", __FUNCTION__);
                break;
            }
            
            CGRect rect = CGRectFromString([rects objectAtIndex:count]);
            [image drawInRect:rect];
            count++;
        }
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (NSArray *)eachRectInGroupWithCount:(NSInteger)count {
    
    NSArray *rects = nil;
    
    CGFloat sizeValue = 100;
    CGFloat padding = 16;
    
    CGFloat eachWidth = (sizeValue - padding*3) / 2;
    
    CGRect rect1 = CGRectMake(sizeValue/2 - eachWidth/2, padding, eachWidth, eachWidth);
    
    CGRect rect2 = CGRectMake(padding, padding*2 + eachWidth, eachWidth, eachWidth);
    
    CGRect rect3 = CGRectMake(padding*2 + eachWidth, padding*2 + eachWidth, eachWidth, eachWidth);
    if (count == 3) {
        rects = @[NSStringFromCGRect(rect1), NSStringFromCGRect(rect2), NSStringFromCGRect(rect3)];
    } else if (count == 4) {
        CGRect rect0 = CGRectMake(padding, padding, eachWidth, eachWidth);
        rect1 = CGRectMake(padding*2, padding, eachWidth, eachWidth);
        rects = @[NSStringFromCGRect(rect0), NSStringFromCGRect(rect1), NSStringFromCGRect(rect2), NSStringFromCGRect(rect3)];
    }
    
    return rects;
}

- (NSArray *)eachRectInGroupWithCount2:(NSInteger)count {
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:count];
    
    CGFloat sizeValue = 100;
    CGFloat padding = 6;
//    CGFloat inset = 50-sqrt(1250);
    CGFloat inset = 2;
    
    CGFloat eachWidth;
    
    if (count <= 4) {
        eachWidth = (sizeValue - padding - inset*2) / 2;
        [self getRects:array padding:padding inset:inset width:eachWidth count:4];
    } else {
        padding = padding / 2;
        eachWidth = (sizeValue - padding*4) / 3;
        [self getRects:array padding:padding inset:inset width:eachWidth count:9];
    }
    
    if (count < 4) {
        [array removeObjectAtIndex:0];
        CGRect rect = CGRectFromString([array objectAtIndex:0]);
        rect.origin.x = (sizeValue - eachWidth) / 2;
        [array replaceObjectAtIndex:0 withObject:NSStringFromCGRect(rect)];
        if (count == 2) {
            [array removeObjectAtIndex:0];
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:2];
            
            for (NSString *rectStr in array) {
                CGRect rect = CGRectFromString(rectStr);
                rect.origin.y = (sizeValue - eachWidth)/2;
                [tempArray addObject:NSStringFromCGRect(rect)];
            }
            [array removeAllObjects];
            [array addObjectsFromArray:tempArray];
        }
    } else if (count != 4 && count <= 6) {
        [array removeObjectsInRange:NSMakeRange(0, 3)];
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:6];
        
        for (NSString *rectStr in array) {
            CGRect rect = CGRectFromString(rectStr);
            rect.origin.y -= (padding+eachWidth)/2;
            [tempArray addObject:NSStringFromCGRect(rect)];
        }
        [array removeAllObjects];
        [array addObjectsFromArray:tempArray];
        
        if (count == 5) {
            [tempArray removeAllObjects];
            [array removeObjectAtIndex:0];
            
            for (int i=0; i<2; i++) {
                CGRect rect = CGRectFromString([array objectAtIndex:i]);
                rect.origin.x -= (padding+eachWidth)/2;
                [tempArray addObject:NSStringFromCGRect(rect)];
            }
            [array replaceObjectsInRange:NSMakeRange(0, 2) withObjectsFromArray:tempArray];
        }
        
    } else if (count != 4 && count < 9) {
        if (count == 8) {
            [array removeObjectAtIndex:0];
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:2];
            for (int i=0; i<2; i++) {
                CGRect rect = CGRectFromString([array objectAtIndex:i]);
                rect.origin.x -= (padding+eachWidth)/2;
                [tempArray addObject:NSStringFromCGRect(rect)];
            }
            [array replaceObjectsInRange:NSMakeRange(0, 2) withObjectsFromArray:tempArray];
        } else {
            [array removeObjectAtIndex:2];
            [array removeObjectAtIndex:0];
        }
    }
    
    return array;
}

- (void)getRects:(NSMutableArray *)array padding:(CGFloat)padding inset:(CGFloat)inset width:(CGFloat)eachWidth count:(int)count {
    
    for (int i=0; i<count; i++) {
        int sqrtInt = (int)sqrt(count);
        int line = i%sqrtInt;
        int row = i/sqrtInt;
        CGRect rect = CGRectMake((padding+eachWidth) * line + inset , (padding + eachWidth) * row + inset, eachWidth, eachWidth);
        [array addObject:NSStringFromCGRect(rect)];
    }
}
@end

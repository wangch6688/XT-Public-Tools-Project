//
//  NSString+path.m
//  03-沙盒演练
//
//  Created by Apple on 16/10/08.
//  Copyright © 2016年  张发政. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

// 提示 : 这种实现更加复杂
+ (NSString *)appendCaches:(NSString *)icon
{
    // 获取caches文件的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    // 获取网络图片的名字
    NSString *fileName = [icon lastPathComponent];
    
    // 拼接文件路径
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    return filePath;
}

- (NSString *)appendCaches
{
    // 获取caches文件的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    
    // 获取网络图片的名字
    NSString *fileName = [self lastPathComponent];
    
    // 拼接文件路径
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    return filePath;
}

- (NSString *)appendDocuments
{
    // 获取caches文件的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 获取网络图片的名字
    NSString *fileName = [self lastPathComponent];
    
    // 拼接文件路径
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    return filePath;
}


+ (NSString *)appendDocuments:(NSString *)icon
{
    // 获取caches文件的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 获取网络图片的名字
    NSString *fileName = [icon lastPathComponent];
    
    // 拼接文件路径
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    return filePath;
}

- (NSString *)appendtemp
{
    // 获取caches文件的路径
    NSString *path = NSTemporaryDirectory();
    
    // 获取网络图片的名字
    NSString *fileName = [self lastPathComponent];
    
    // 拼接文件路径
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    
    return filePath;
}


#pragma mark - 计算字体size
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


+ (NSString *)stringNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (!str) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
        str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    }
    return str;
}
@end

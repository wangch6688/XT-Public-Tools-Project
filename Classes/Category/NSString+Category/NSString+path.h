//
//  NSString+path.h
//  03-沙盒演练
//
//  Created by Apple on 16/10/08.
//  Copyright © 2016年  张发政. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (path)

// 不靠谱
+ (NSString *)appendCaches:(NSString *)icon;

- (NSString *)appendCaches;

- (NSString *)appendDocuments;

+ (NSString *)appendDocuments:(NSString *)icon;

- (NSString *)appendtemp;


#pragma mark - 计算字体size
-(CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**文件命名
 Create a string from the file in main bundle (similar to [UIImage imageNamed:]).
 
 @param name The file name (in main bundle).
 
 @return A new string create from the file in UTF-8 character encoding.
 */
+ (NSString *)stringNamed:(NSString *)name;

@end

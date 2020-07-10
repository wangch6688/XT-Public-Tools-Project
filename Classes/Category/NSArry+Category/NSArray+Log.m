

#import "NSArray+Log.h"

@implementation NSArray (Log)

/// 打印数组和字典时会自动调用这个方法,在分类中重写这个方法时,在使用时不需要导入头文件

- (NSString *)descriptionWithLocale:(id)locale
{
    // 创建可变字符串
    NSMutableString *stringM = [NSMutableString string];
    // 拼接开头
    [stringM appendString:@"(\n"];
    // 遍历出元素,拼接中间的内容部分
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [stringM appendFormat:@"\t%@,\n",obj];
    }];
    // 拼接结尾
    [stringM appendString:@")\n"];
    
    return stringM;
}

- (NSString *)descriptionWithSeparator:(NSString *)separator{
    // 创建可变字符串
    NSMutableString *stringM = [NSMutableString string];
    // 拼接开头
    [stringM appendString:@""];
    // 遍历出元素,拼接中间的内容部分
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [stringM appendFormat:@"%@%@",obj,separator];
    }];
    // 删除结尾
    [stringM deleteCharactersInRange:NSMakeRange(stringM.length-separator.length, separator.length)];
    
    return stringM;
}

@end

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    // 创建可变字符串
    NSMutableString *stringM = [NSMutableString string];
    // 拼接开头
    [stringM appendString:@"{\n"];
    //  遍历出元素,拼接中间的内容部分
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [stringM appendFormat:@"\t%@ = %@;\n",key,obj];
    }];
    // 拼接结尾
    [stringM appendString:@"}\n"];
    
    return stringM;
}


@end

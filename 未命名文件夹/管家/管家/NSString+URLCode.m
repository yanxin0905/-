//
//  NSString+URLCode.m
//  LOL
//
//  Created by 刘清 on 16/3/10.
//  Copyright (c) 2016年 LQ. All rights reserved.
//

#import "NSString+URLCode.h"

@implementation NSString (URLCode)

- (NSString *)URLEncodedString
{
    /*
     CFURLCreateStringByAddingPercentEscapes函数是Core Foundation框架提供的C函数，可以把内容转换成URL【资源定位符】编码，
     
     */
    
    NSString *result = ( NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,//指定了将本身为非法的URL字符不进行编码的字符集合
                                                              CFSTR("!*();+$,%#[] "),//将本身为合法的URL字符需要进行编码的字符集合
                                                              kCFStringEncodingUTF8));
    return result;
}

- (NSString*)URLDecodedString
{
    //    CFURLCreateStringByReplacingPercentEscapesUsingEncoding与CFURLCreateStringByAddingPercentEscapes相反，是进行URL解码
//    Foundation框架
//    NSString*ss;
//    [ss stringByReplacingPercentEscapesUsingEncoding:<#(NSStringEncoding)#>]
    
//    CoreFoundation框架
//    CFURLCreateStringByReplacingPercentEscapesUsingEncoding
    
    NSString *result = ( NSString *)
    CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                              (CFStringRef)self,
                                                                              CFSTR(""),//指定不进行解码的字符集
                                                                              kCFStringEncodingUTF8));
    return result;
}

@end

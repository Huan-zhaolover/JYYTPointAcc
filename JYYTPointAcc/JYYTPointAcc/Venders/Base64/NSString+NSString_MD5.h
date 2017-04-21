//
//  NSString+NSString_MD5.h
//  JYYTPointAcc
//
//  Created by shjyyt on 2017/4/21.
//  Copyright © 2017年 shjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_MD5)
+(NSString *)md5StringWIthOrinalString:(NSString *)oldstring;
+(NSString*)md5StringWIthOrinalString:(NSString *)oldstring  withSecret:(NSString *)secrect;
// 加密方法
+ (NSString*)encrypt:(NSString*)plainText;
// 解密方法
+ (NSString*)decrypt:(NSString*)encryptText;


@end

//
//  NSString+Extension.h
//  startvhelper
//
//  Created by 张晓珊 on 16/2/25.
//  Copyright © 2016年 张晓珊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
+ (BOOL)validateMobile:(NSString *)mobile;
/****** 加密 ******/
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
/****** 解密 ******/
+(NSString *) decryptUseDES:(NSString *)plainText key:(NSString *)key;
@end

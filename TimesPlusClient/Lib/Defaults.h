//
//  Defaults.h
//  TimesPlusClient
//
//  Created by yoko_net on 2014/03/02.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Defaults : NSObject

+ (void)showAll;

+ (void)setCardNo1:(NSString *)str;
+ (NSString *)getCardNo1;
+ (void)setCardNo2:(NSString *)str;
+ (NSString *)getCardNo2;

+ (void)setPassword:(NSString *)str;
+ (NSString *)getPassword;

@end

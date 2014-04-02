//
//  UIColor+ColorWithHex.h
//  TimesPlusClient
//
//  Created by yoko_net on 2014/03/08.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorWithHex)

+ (id)colorWithHexString:(NSString *)hex;
+ (id)colorWithHexString:(NSString *)hex alpha:(CGFloat)a;

@end

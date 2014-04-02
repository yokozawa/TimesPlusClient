//
//  UIColor+ColorWithHex.m
//  TimesPlusClient
//
//  Created by yoko_net on 2014/03/08.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import "UIColor+ColorWithHex.h"

@implementation UIColor (ColorWithHex)

+ (id)colorWithHexString:(NSString *)hex
{
    return [self colorWithHexString:hex alpha:1.0f];
}

+ (id)colorWithHexString:(NSString *)hex alpha:(CGFloat)a
{
    NSScanner *colorScanner = [NSScanner scannerWithString:hex];
    unsigned int color;
    if (![colorScanner scanHexInt:&color]) return nil;
    CGFloat r = ((color & 0xFF0000) >> 16)/255.0f;
    CGFloat g = ((color & 0x00FF00) >> 8) /255.0f;
    CGFloat b =  (color & 0x0000FF) /255.0f;
    return [UIColor colorWithRed:r green:g blue:b alpha:a];
}

@end

//
//  Defaults.m
//  TimesPlusClient
//
//  Created by yoko_net on 2014/03/02.
//  Copyright (c) 2014年 yoko_net. All rights reserved.
//

#import "Defaults.h"

@implementation Defaults

static NSString *kDefaultsCardNo1Key = @"cardNo1";
static NSString *kDefaultsCardNo2Key = @"cardNo2";
static NSString *kDefaultsPasswordKey = @"password";

+ (void)showAll {
//    NSDictionary * dic = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
//    DLog(@"defualts:%@", dic);
}

+ (void)setCardNo1:(NSString *)str
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:kDefaultsCardNo1Key];
    [defaults synchronize];
}

+ (NSString*)getCardNo1
{
    NSUserDefaults*defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:kDefaultsCardNo1Key];
}

+ (void)setCardNo2:(NSString *)str
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:kDefaultsCardNo2Key];
    [defaults synchronize];
}

+ (NSString*)getCardNo2
{
    NSUserDefaults*defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:kDefaultsCardNo2Key];
}


+ (void)setPassword:(NSString *)str
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:str forKey:kDefaultsPasswordKey];
    [defaults synchronize];
}

+ (NSString*)getPassword
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults stringForKey:kDefaultsPasswordKey];
}


@end

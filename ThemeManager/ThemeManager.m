//
//  ThemeManager.m
//  Wealth88
//
//  Created by wjc on 15/5/27.
//  Copyright (c) 2015年 wjc. All rights reserved.
//

#import "ThemeManager.h"

static UIFont * __font18;
static UIFont * __font16;
static UIFont * __font14;
static UIFont * __font12;
static UIColor * __separatorColor;

@implementation ThemeManager

+ (ThemeManager *)shareManager
{
    static ThemeManager *shareInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [ThemeManager new];
        __font18 = [ThemeManager font:18.0];
        __font16 = [ThemeManager font:16.0];
        __font14 = [ThemeManager font:14.0];
        __font12 = [ThemeManager font:12.0];
        __separatorColor = [UIColor colorWithWhite:.0 alpha:0.2];
    });
    return shareInstance;
}

+ (UIFont *)font:(CGFloat)fontSize
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
    if (font == nil) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

+ (UIFont *)getFont:(CGFloat)fontSize
{
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
    if (font == nil) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

+ (UIColor *)getNavColor
{
    return JCColor(164, 0, 0);
}

+ (UIColor *)getDeepGrayColor
{
    return JCColor(67, 67, 67);
}

+ (UIColor *)getGrayColor
{
    return JCColor(125, 125, 125);
}

+ (UIColor *)getLightGrayColor
{
    return JCColor(170, 170, 170);
}

+ (UIColor *)getRedColor
{
    return JCColor(208, 62, 67);
}

+ (UIColor *)getDeepRedColor
{
    return JCColor(164, 0, 0);
}

+ (UIColor *)getGoldColor
{
    return JCColor(177, 130, 71);
}

+ (UIColor *)getOrangeColor
{
    return JCColor(235, 97, 0);
}

+ (UIColor *)getGreenColor
{
    return [UIColor colorWithHexString:@"#1aad34"];
}

+ (UIColor *)getGlobalGreenColor
{
    return JCColor(50, 177, 108);
}

+ (CGFloat)separatorHeiht
{
    return isDeviceRetina ? 0.5 : 1.0;
}

+ (UIFont *)font18
{
    return __font18;
}

+ (UIFont *)font16
{
    return __font16;
}

+ (UIFont *)font14
{
    return __font14;
}

+ (UIFont *)font12
{
    return __font12;
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)separatorColor
{
    return [UIColor colorWithRed:0.7529 green:0.7529 blue:0.7529 alpha:1.0];
}

@end

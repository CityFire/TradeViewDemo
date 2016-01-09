//
//  ThemeManager.h
//  Wealth88
//
//  Created by wjc on 15/5/27.
//  Copyright (c) 2015年 wjc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject

+ (ThemeManager *)shareManager;

+ (UIFont *)font:(CGFloat)fontSize;

+ (UIFont *)getFont:(CGFloat)fontSize;

+ (UIFont *)font18;

+ (UIFont *)font16;

+ (UIFont *)font14;

+ (UIFont *)font12;

+ (UIColor *)getNavColor;

+ (UIColor *)getDeepGrayColor;

+ (UIColor *)getGrayColor;

+ (UIColor *)getLightGrayColor;

+ (UIColor *)getRedColor;

+ (UIColor *)getDeepRedColor;

+ (UIColor *)getGoldColor;

+ (UIColor *)getOrangeColor;

+ (UIColor *)getGreenColor;

+ (UIColor *)getGlobalGreenColor;

+ (CGFloat)separatorHeiht;
+ (UIColor *)separatorColor;

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

@end

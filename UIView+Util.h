//
//  UIView+Util.h
//  TradeViewDemo
//
//  Created by wjc on 15/8/24.
//  Copyright (c) 2015年 wjc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)
/**
 *  设置圆角
 *
 *  @param cornerRadius 圆形角度
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;
/**
 *  设置边框宽度和颜色
 *
 *  @param width 宽度
 *  @param color 颜色
 */
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color;
/**
 *  截图
 *
 *  @return 图片
 */
- (UIImage *)convertViewToImage;

@end

//
//  CustomTradeKeyboard.h
//  TradeViewDemo
//
//  Created by wjc on 15/10/30.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const CustomTradeKeyboardDeleteButtonClickKey;
extern NSString *const CustomTradeKeyboardNumberButtonClickKey;
extern NSString *const CustomTradeKeyboardNumberKey;

@class ZKCTradeKeyboard;

@protocol CustomTradeKeyboardDelegate <NSObject>

@optional
/** 数字按钮点击 */
- (void)tradeKeyboard:(ZKCTradeKeyboard *)keyboard numBtnClick:(NSInteger)num;
/** 删除按钮点击 */
- (void)tradeKeyboardDeleteBtnClick;
/** 确定按钮点击 */
- (void)tradeKeyboardOkBtnClick;
@end


@interface CustomTradeKeyboard : UIView

@property (nonatomic, weak) id<CustomTradeKeyboardDelegate> delegate;

@end

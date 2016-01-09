//
//  CustomTradeInputView.h
//  Wealth88
//
//  Created by wjc on 15/10/30.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const CustomTradeInputViewCloseButtonClick;
extern NSString *const CustomTradeInputViewForgetButtonClick;
extern NSString *const CustomTradeInputViewInputFinished;
extern NSString *const CustomTradeInputViewPwdKey;

@class CustomTradeInputView;

@protocol CustomTradeInputViewDelegate <NSObject>

@optional
/** 完毕 */
- (void)tradeInputViewFinished:(CustomTradeInputView *)tradeInputView;
/** 关闭按钮点击 */
- (void)tradeInputView:(CustomTradeInputView *)tradeInputView closeBtnClick:(UIButton *)closeBtn;
/** 忘记密码点击 */
- (void)tradeInputView:(CustomTradeInputView *)tradeInputView forgetBtnClick:(UIButton *)forgetBtn;

@end

@interface CustomTradeInputView : UIView

@property (nonatomic, weak) id<CustomTradeInputViewDelegate> delegate;
/** 付款 */
@property (nonatomic, copy) NSString *payMoney;

@end

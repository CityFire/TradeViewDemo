//
//  ZKCTradeInputView.h
//  Wealth88
//
//  Created by wjc on 15/10/30.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const ZKCTradeInputViewCloseButtonClickKey;
extern NSString *const ZKCTradeInputViewForgetButtonClickKey;
extern NSString *const ZKCTradeInputViewInputFinishedKey;
extern NSString *const ZKCTradeInputViewPwdKey;

@class ZKCTradeInputView;

@protocol ZKCTradeInputViewDelegate <NSObject>

@optional
/** 完毕 */
- (void)tradeInputViewFinished:(ZKCTradeInputView *)tradeInputView;
/** 关闭按钮点击 */
- (void)tradeInputView:(ZKCTradeInputView *)tradeInputView closeBtnClick:(UIButton *)closeBtn;
/** 忘记密码点击 */
- (void)tradeInputView:(ZKCTradeInputView *)tradeInputView forgetBtnClick:(UIButton *)forgetBtn;

@end

@interface ZKCTradeInputView : UIView

@property (nonatomic, weak) id<ZKCTradeInputViewDelegate> delegate;
@property (nonatomic, copy) NSString *payMoney;

@end

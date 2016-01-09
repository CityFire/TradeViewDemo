//
//  ZKCTradeView.h
//  Wealth88
//
//  Created by wjc on 15/10/30.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKCTradeView;

@protocol ZKCTradeViewDelegate <NSObject>

@optional

- (void)tradeViewDidCloseView:(ZKCTradeView *)tradeView;
- (void)tradeViewForgetPassword:(ZKCTradeView *)tradeView;
- (void)tradeViewDidFinish:(ZKCTradeView  *)tradeView password:(NSString *)password;

@end

@interface ZKCTradeView : UIView

@property (nonatomic, copy) NSString *payMoney;

@property (nonatomic, weak) id<ZKCTradeViewDelegate>delegate;

+ (instancetype)tradeView;

- (void)show;
- (void)dismiss;

@end

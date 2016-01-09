//
//  CustomTradeView.h
//  Wealth88
//
//  Created by wjc on 15/10/30.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomTradeView;

@protocol CustomTradeViewDelegate <NSObject>

@optional

- (void)tradeViewForgetPassword:(CustomTradeView *)tradeView;
- (void)tradeViewDidFinish:(CustomTradeView *)tradeView password:(NSString *)password;

@end

@interface CustomTradeView : UIView

@property (nonatomic, copy) NSString *payMoney;

@property (nonatomic, weak) id<CustomTradeViewDelegate>delegate;

+ (instancetype)tradeView;

- (void)show;
- (void)dismiss;

@end

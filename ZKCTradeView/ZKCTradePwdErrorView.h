//
//  ZKCTradePwdErrorView.h
//  Wealth88
//
//  Created by wjc on 15/11/3.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZKCTradePwdErrorView;

@protocol ZKCTradePwdErrorViewDelegate <NSObject>

@required
- (void)tradePwdErrorViewReInput:(ZKCTradePwdErrorView *)view;
- (void)tradePwdErrorViewForgetPwd:(ZKCTradePwdErrorView *)view;

@end

@interface ZKCTradePwdErrorView : UIView

@property (nonatomic,weak) id<ZKCTradePwdErrorViewDelegate>delegate;

+ (instancetype)tradePwdErrorView;
- (void)showInSuperView:(UIView *)superView;
- (void)dismiss;

@end

//
//  ZKCTradePwdErrorView.m
//  Wealth88
//
//  Created by wjc on 15/11/3.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import "ZKCTradePwdErrorView.h"
#import "DivideView.h"
#import "ThemeManager.h"

typedef NS_ENUM(NSInteger, btnType) {
    btnTypeRetry = 0x11,  // 重试
    btnTypeForget = 0x12, // 忘记密码
};

@interface ZKCTradePwdErrorView ()

@property (nonatomic, strong) UIButton *cover;
@property (nonatomic, weak) UIView *superView;
@property (nonatomic, weak) UILabel *titleLb;
@property (nonatomic, weak) DivideView *divideUpView;
@property (nonatomic, weak) DivideView *divideBottomView;
@property (nonatomic, weak) UIButton *forgetBtn;
@property (nonatomic, weak) UIButton *retryBtn;

@end

@implementation ZKCTradePwdErrorView

#pragma mark - LifeCircle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = YES;
        
        [self setupCover];
        [self setupLabel];
        [self setupBtns];
        [self setupDivideViews];
    }
    return self;
}

+ (instancetype)tradePwdErrorView
{
    return [[self alloc] init];
}

- (void)setupCover
{
    UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
    cover.frame = [UIScreen mainScreen].bounds;
    [cover setBackgroundColor:[UIColor blackColor]];
    cover.alpha = 0.4;
//    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
}

- (void)setupLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 27, self.width, 30)];
    label.text = @"交易密码错误，请重试";
    label.textColor = JCColor(60, 60, 60);
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.titleLb = label;
}

- (void)setupBtns
{
    NSArray *btnTitle = @[@"重试", @"忘记密码"];
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((self.width*0.5+1)*i, self.height-45, (self.width-1)*0.5, 45);
        [btn setTitleColor:JCColor(55, 145, 252) forState:UIControlStateNormal];
        [btn setTitleColor:JCColor(55, 145, 252) forState:UIControlStateHighlighted];
        [btn setBackgroundImage:[UIColor imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIColor imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
        [btn setTitle:btnTitle[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (i == 0) {
            self.retryBtn = btn;
            btn.tag = btnTypeRetry;
        } else {
            self.forgetBtn = btn;
            btn.tag = btnTypeForget;
        }
    }
}

- (void)setupDivideViews
{
    CGFloat lineWH = isDeviceRetina?0.5:1;
    DivideView *divideView = [[DivideView alloc] initWithFrame:CGRectMake(0, self.height-45-lineWH, self.width, lineWH)];
    divideView.backgroundColor = [ThemeManager separatorColor];
    divideView.alpha = 0.7;
    [self addSubview:divideView];
    self.divideUpView = divideView;
    
    divideView = [[DivideView alloc] initWithFrame:CGRectMake((self.width-lineWH)*0.5, self.height-45, lineWH, 45)];
    divideView.backgroundColor = [ThemeManager separatorColor];
    divideView.alpha = 0.7;
    [self addSubview:divideView];
    self.divideBottomView = divideView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cover.frame = _superView.bounds;
    CGFloat lineWH = isDeviceRetina?0.5:1;
    self.divideUpView.frame = CGRectMake(0, self.height-45-lineWH, self.width, lineWH);
    self.divideBottomView.frame = CGRectMake((self.width-lineWH)*0.5, self.height-45, lineWH, 45);
    self.titleLb.frame = CGRectMake(0, 20, self.width, 30);
    self.retryBtn.frame = CGRectMake(0, self.height-45, (self.width-lineWH)*0.5, 45);
    self.forgetBtn.frame = CGRectMake(self.retryBtn.right+lineWH, self.height-45, self.retryBtn.width, self.retryBtn.height);
}

#pragma TouchAction

- (void)showInSuperView:(UIView *)superView
{
    _superView = superView;
    [_superView addSubview:_cover];
    [_superView addSubview:self];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        [self.cover removeFromSuperview];
        [self removeFromSuperview];
    }];
}

- (void)btnClick:(UIButton *)btn
{
    if (btn.tag == btnTypeRetry) {
        // 重试
        if ([self.delegate respondsToSelector:@selector(tradePwdErrorViewReInput:)]) {
            [self.delegate tradePwdErrorViewReInput:self];
        }
    } else if (btn.tag == btnTypeForget) {
        // 忘记密码
        if ([self.delegate respondsToSelector:@selector(tradePwdErrorViewForgetPwd:)]) {
            [self.delegate tradePwdErrorViewForgetPwd:self];
        }
    }
}

@end

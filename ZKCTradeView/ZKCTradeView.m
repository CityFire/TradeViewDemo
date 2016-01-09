//
//  ZKCTradeView.m
//  Wealth88
//
//  Created by wjc on 15/10/30.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import "ZKCTradeView.h"
#import "ZKCTradeInputView.h"

@interface ZKCTradeView () // <ZKCTradeInputViewDelegate>

@property (nonatomic, weak) ZKCTradeInputView *inputView;

@property (nonatomic, weak) UIButton *cover;

@end

@implementation ZKCTradeView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - LifeCircle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
  
        [self setupCover];
 
        [self setupInputView];
    }
    return self;
}

#pragma mark - 初始化函数

+ (instancetype)tradeView
{
    return [[self alloc] init];
}

- (void)setupCover
{
    UIButton *cover = [UIButton buttonWithType:UIButtonTypeCustom];
    [cover setBackgroundColor:[UIColor blackColor]];
    cover.alpha = 0.6;
    [self addSubview:cover];
    self.cover = cover;
}

- (void)setupInputView
{
    ZKCTradeInputView *inputView = [[ZKCTradeInputView alloc] init];
//    inputView.delegate = self;
    [self addSubview:inputView];
    self.inputView = inputView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgetPassword) name:ZKCTradeInputViewForgetButtonClickKey object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(close) name:ZKCTradeInputViewCloseButtonClickKey object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputViewFinished:) name:ZKCTradeInputViewInputFinishedKey object:nil];
}

- (void)setPayMoney:(NSString *)payMoney
{
    _payMoney = payMoney;
    self.inputView.payMoney = _payMoney;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cover.frame = self.bounds;
}

#pragma mark - TouchAction

- (void)show
{
    self.alpha = 1.0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.inputView.width = screenWidth * 260 / 320;
    self.inputView.height = 245;
    CGFloat keyboardHeight = 216;
    self.inputView.frame = CGRectMake((screenWidth - self.inputView.width) * 0.5, self.height - self.inputView.height - keyboardHeight - (isIPHONE4Size?0:45), self.inputView.width, self.inputView.height);
    
}

- (void)dismiss
{
    self.alpha = 0.0;
    NSMutableArray *nums = [self.inputView valueForKeyPath:@"nums"];
    [nums removeAllObjects];
    [self.cover removeFromSuperview];
    [self removeFromSuperview];
}

#pragma mark - NSNotification
- (void)forgetPassword
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tradeViewForgetPassword:)]) {
        [self.delegate tradeViewForgetPassword:self];
    }
    [self dismiss];
}

- (void)close
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tradeViewDidCloseView:)]) {
        [self.delegate tradeViewDidCloseView:self];
    }
    [self dismiss];
}

- (void)inputViewFinished:(NSNotification *)note
{
    // 获取密码
    NSString *pwd = note.userInfo[ZKCTradeInputViewPwdKey];

    self.alpha = 0.0;
    if ([self.delegate respondsToSelector:@selector(tradeViewDidFinish:password:)]) {
        [self.delegate tradeViewDidFinish:self password:pwd];
    }
    [self dismiss];
}

#pragma mark - ZKCTradeInputViewDelegate



@end

//
//  CustomTradeView.m
//  Wealth88
//
//  Created by wjc on 15/10/30.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import "CustomTradeView.h"
#import "CustomTradeInputView.h"
#import "CustomTradeKeyboard.h"

@interface CustomTradeView () // <ZKCTradeInputViewDelegate>

@property (nonatomic, weak) CustomTradeInputView *inputView;

@property (nonatomic, weak) CustomTradeKeyboard *keyboard;

@property (nonatomic, weak) UIButton *cover;

@property (nonatomic, weak) UITextField *responsder;

@property (nonatomic, assign, getter=isKeyboardShow) BOOL keyboardShow;

@property (nonatomic, copy) NSString *passWord;

@end

@implementation CustomTradeView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DLog(@"dealloc---");
}

#pragma mark - LifeCircle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
  
        [self setupCover];
   
        [self setupkeyboard];
 
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
    cover.alpha = 0.4;
    [self addSubview:cover];
    self.cover = cover;
}

- (void)setupInputView
{
    CustomTradeInputView *inputView = [[CustomTradeInputView alloc] init];
//    inputView.delegate = self;
    [self addSubview:inputView];
    self.inputView = inputView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forgetPassword) name:CustomTradeInputViewForgetButtonClick object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(close) name:CustomTradeInputViewCloseButtonClick object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputViewFinished:) name:CustomTradeInputViewInputFinished object:nil];
}

- (void)setupkeyboard
{
    CustomTradeKeyboard *keyboard = [[CustomTradeKeyboard alloc] init];
    [self addSubview:keyboard];
    self.keyboard = keyboard;
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

#pragma mark - Private

- (void)showKeyboard
{
    self.keyboardShow = YES;
    
    CGFloat marginTop;
    if (isIPHONE4Size) {
        marginTop = 30;
    } else if (iphone5) {
        marginTop = 100;
    } else if (iphone6) {
        marginTop = 120;
    } else {
        marginTop = 140;
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.keyboard.transform = CGAffineTransformMakeTranslation(0, -self.keyboard.height);
        self.inputView.transform = CGAffineTransformMakeTranslation(0, marginTop - self.inputView.y);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidenKeyboard:(void (^)(BOOL finished))completion
{
    self.keyboardShow = NO;

    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.keyboard.transform = CGAffineTransformIdentity;
        self.inputView.transform = CGAffineTransformIdentity;
    } completion:completion];
}

#pragma mark - NSNotification
- (void)forgetPassword
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tradeViewForgetPassword:)]) {
        [self.delegate tradeViewForgetPassword:self];
    }
    [self dismiss];
}

- (void)dismiss
{
    self.alpha = 0.0;
    [self hidenKeyboard:^(BOOL finished) {
        NSMutableArray *nums = [self.inputView valueForKeyPath:@"nums"];
        [nums removeAllObjects];
        [self removeFromSuperview];
        [self.inputView setNeedsDisplay];
    }];
}

- (void)close
{
    [self dismiss];
}

- (void)show
{
    self.alpha = 1.0;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.keyboard.frame = CGRectMake(0, screenHeight, screenWidth, screenWidth*0.65);
    
    self.inputView.width = screenWidth * 260 / 320;
    self.inputView.height = 245;
    self.inputView.frame = CGRectMake((screenWidth - self.inputView.width) * 0.5, (self.height - self.inputView.height) * 0.5, self.inputView.width, self.inputView.height);
    
    [self showKeyboard];
}

- (void)inputViewFinished:(NSNotification *)note
{
    // 获取密码
    NSString *pwd = note.userInfo[CustomTradeInputViewPwdKey];

    self.alpha = 0.0;
    if ([self.delegate respondsToSelector:@selector(tradeViewDidFinish:password:)]) {
        [self.delegate tradeViewDidFinish:self password:pwd];
    }
    [self hidenKeyboard:^(BOOL finished) {
        NSMutableArray *nums = [self.inputView valueForKeyPath:@"nums"];
        [nums removeAllObjects];
        [self removeFromSuperview];
        [self.inputView setNeedsDisplay];
    }];
}

#pragma mark - ZKCTradeInputViewDelegate



@end

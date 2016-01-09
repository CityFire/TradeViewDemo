//
//  ZKCTradeInputView.m
//  Wealth88
//
//  Created by wjc on 15/10/30.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import "ZKCTradeInputView.h"
#import "UIView+util.h"
#import "DivideView.h"
#import "ThemeManager.h"

NSString *const ZKCTradeInputViewCloseButtonClickKey = @"ZKCTradeInputViewCloseButtonClick";
NSString *const ZKCTradeInputViewForgetButtonClickKey = @"ZKCTradeInputViewForgetButtonClick";
NSString *const ZKCTradeInputViewInputFinishedKey = @"ZKCTradeInputViewInputFinished";
NSString *const ZKCTradeInputViewPwdKey = @"ZKCTradeInputViewPwdKey";

static const float kZKCTradeInputViewNumCount = 6;
static const float kZKCTrandeInputPasswordDotSize = 8;

@interface ZKCTradeInputView () <UITextFieldDelegate>

@property (nonatomic, weak) UITextField *inputField;

@property (nonatomic, weak) UILabel *titleLb;
@property (nonatomic, weak) DivideView *divideUpView;
@property (nonatomic, weak) DivideView *divideBottomView;
@property (nonatomic, weak) UILabel *moneyLb;
@property (nonatomic, weak) UILabel *payMoneyLb;
@property (nonatomic, weak) UIButton *forgetBtn;
@property (nonatomic, weak) UIButton *closeBtn;
// 数字数组
@property (nonatomic, strong) NSMutableArray *nums;
// 存储之前输入的数字字符串
@property (nonatomic, strong) NSString *OldNumberStr;

@end

@implementation ZKCTradeInputView

#pragma mark - 懒加载

- (NSMutableArray *)nums
{
    if (_nums == nil) {
        _nums = [NSMutableArray array];
    }
    return _nums;
}

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.OldNumberStr = nil;
        [self setCornerRadius:10.0];

        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    UITextField *inputField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    inputField.hidden = YES;
    inputField.keyboardType = UIKeyboardTypeNumberPad;
    [inputField addTarget:self action:@selector(textchange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:inputField];
    self.inputField = inputField;
    [self.inputField becomeFirstResponder];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"请输入交易密码";
    label.textColor = JCColor(60, 60, 60);
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:15.0];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.titleLb = label;
    
    DivideView *divideView = [[DivideView alloc] initWithFrame:CGRectZero];
    divideView.backgroundColor = [ThemeManager separatorColor];
    divideView.alpha = 0.7;
    [self addSubview:divideView];
    self.divideUpView = divideView;
    
    divideView = [[DivideView alloc] initWithFrame:CGRectZero];
    divideView.backgroundColor = [ThemeManager separatorColor];
    divideView.alpha = 0.4;
    [self addSubview:divideView];
    self.divideBottomView = divideView;
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"支付金额";
    label.textColor = JCColor(70, 70, 70);
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13.0];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.moneyLb = label;
    
    label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.text = @"￥0";
    label.font = [UIFont systemFontOfSize:25.0];
    label.backgroundColor = [UIColor clearColor];
    [self addSubview:label];
    self.payMoneyLb = label;
    
    // 忘记密码按钮
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:11.0];
    [forgetBtn setTitleColor:JCColor(55, 145, 252) forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(forgetClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:forgetBtn];
    self.forgetBtn = forgetBtn;
    
    // 关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeBtn];
    self.closeBtn = closeBtn;
}

#pragma mark - setter
- (void)setPayMoney:(NSString *)payMoney
{
    _payMoney = payMoney;
    self.payMoneyLb.text = _payMoney;
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLb.frame = CGRectMake(0, 0, self.width, 40);
    self.closeBtn.frame = CGRectMake(self.width-40, 0, 40, 40);
    self.divideUpView.frame = CGRectMake(0, self.closeBtn.bottom, self.width, isDeviceRetina?0.5:1);
    self.moneyLb.frame = CGRectMake(0, self.divideUpView.bottom+14, self.width, 15);
    self.payMoneyLb.frame = CGRectMake(0, self.moneyLb.bottom+10, self.width, 30);
    self.divideBottomView.frame = CGRectMake(15, self.height-101, self.width-30, isDeviceRetina?0.5:1);
    self.forgetBtn.frame = CGRectMake(self.width-75, self.height-42, 70, 30);
}

#pragma mark - touchAction
- (void)closeClick:(UIButton *)btn
{
    [self.inputField resignFirstResponder];//隐藏键盘
    if (btn == self.closeBtn) {
        // 关闭按钮点击
        if ([self.delegate respondsToSelector:@selector(tradeInputView:closeBtnClick:)]) {
            [self.delegate tradeInputView:self closeBtnClick:btn];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:ZKCTradeInputViewCloseButtonClickKey object:self];
    }
}

- (void)forgetClick:(UIButton *)btn
{
    [self.inputField resignFirstResponder];//隐藏键盘
    if (btn == self.forgetBtn) {
        if ([self.delegate respondsToSelector:@selector(tradeInputView:forgetBtnClick:)]) {
            [self.delegate tradeInputView:self forgetBtnClick:btn];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:ZKCTradeInputViewForgetButtonClickKey object:self];
    }
}

#pragma mark 文本框内容改变
- (void)textchange:(UITextField *)textField
{
    NSString *password = textField.text;
    
    for (NSInteger i = self.OldNumberStr.length; i < password.length; i++)
    {
        NSString *pwd = [password substringWithRange:NSMakeRange(i, 1)];
        [self.nums addObject:pwd];
    }
    
    if (password.length < self.OldNumberStr.length) {
        [self.nums removeLastObject];
    }
    
    self.OldNumberStr = textField.text;
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGFloat fieldW = 220 * self.width / 260;
    CGFloat fieldLM = 20 * self.width / 260;
    // 画图
    UIImage *inputField = [UIImage imageNamed:@"password_input.png"];
    [inputField drawInRect:CGRectMake(fieldLM, self.height-79, fieldW, 38)];
    
    // 画点
    UIImage *pointImage = [UIImage imageNamed:@"password_dot.png"];
    CGFloat oneInputFieldW = fieldW / 6;
    CGFloat pointY = self.height-63;
    CGFloat pointX = 0;
    CGFloat margin = (self.width-fieldW)*0.5;
    CGFloat padding = (oneInputFieldW-kZKCTrandeInputPasswordDotSize)*0.5;
    
    NSInteger dotsCount = self.nums.count;
    if (dotsCount > kZKCTradeInputViewNumCount) {
        // 防止主线程延迟画第7个点
        dotsCount = kZKCTradeInputViewNumCount;
    }
    
    for (int i = 0; i < dotsCount; i++) {
        pointX = margin + padding + i * (kZKCTrandeInputPasswordDotSize + 2 * padding);
        [pointImage drawInRect:CGRectMake(pointX, pointY, kZKCTrandeInputPasswordDotSize, kZKCTrandeInputPasswordDotSize)];
    }
    
    if (self.nums.count == kZKCTradeInputViewNumCount) {
        // 输入完毕
        dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 0.25*NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [self finish];
        });
    }

}

// 输入完毕
- (void)finish
{
    [self.inputField resignFirstResponder];// 隐藏键盘
    
    if ([self.delegate respondsToSelector:@selector(tradeInputViewFinished:)]) {
        [self.delegate tradeInputViewFinished:self];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[ZKCTradeInputViewPwdKey] = self.OldNumberStr;
    [[NSNotificationCenter defaultCenter] postNotificationName:ZKCTradeInputViewInputFinishedKey object:self userInfo:dict];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.inputField becomeFirstResponder];
}

- (void)dealloc
{
    DLog(@"dealloc");
}


@end

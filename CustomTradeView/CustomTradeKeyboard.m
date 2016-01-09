//
//  CustomTradeKeyboard.m
//  TradeViewDemo
//
//  Created by wjc on 15/10/30.
//  Copyright © 2015年 wjc. All rights reserved.
//

#import "CustomTradeKeyboard.h"
#import <AudioToolbox/AudioToolbox.h>

NSString *const CustomTradeKeyboardDeleteButtonClickKey = @"CustomTradeKeyboardDeleteButtonClick";
NSString *const CustomTradeKeyboardNumberButtonClickKey = @"CustomTradeKeyboardNumberButtonClick";
NSString *const CustomTradeKeyboardNumberKey = @"CustomTradeKeyboardNumberKey";

static const float ZKCKeyboardBtnCount = 12;

@interface CustomTradeKeyboard ()

// 所有数字按钮的数组
@property (nonatomic, strong) NSMutableArray *numBtns;

@end

@implementation CustomTradeKeyboard

- (NSMutableArray *)numBtns
{
    if (_numBtns == nil) {
        _numBtns = [NSMutableArray array];
    }
    return _numBtns;
}

#pragma mark - LifeCircle

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupBtns];
    }
    return self;
}

- (void)setupBtns
{
    for (int i = 0; i < ZKCKeyboardBtnCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(playTock) forControlEvents:UIControlEventTouchDown];
        [btn setBackgroundImage:[UIImage imageNamed:@"number_bg"] forState:UIControlStateNormal];
        if (i == 9) {
            [btn addTarget:self action:@selector(blankBtnClick) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            if (i == 10) {
                [btn setTitle:@"0" forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:screenWidth * 0.06875];
                btn.tag = 0;
                [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.numBtns addObject:btn];
            } else if (i == 11) {
                [btn setTitle:@"删除" forState:UIControlStateNormal];
//                [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:screenWidth * 0.046875];
                [btn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
            } else {
                [btn setTitle:[NSString stringWithFormat:@"%d", i + 1] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:screenWidth * 0.06875];
                btn.tag = i + 1;
                [btn addTarget:self action:@selector(numBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.numBtns addObject:btn];
            }
        }
        [self addSubview:btn];
    }
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 定义列数
    NSInteger Cols = 3;
    
    // 定义间距
    CGFloat margin = screenWidth * 0.015625;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = screenWidth * 0.3125;
    CGFloat h = screenWidth * 0.14375;
    
    // 列数 行数
    NSInteger row = 0;
    NSInteger col = 0;
    for (int i = 0; i < ZKCKeyboardBtnCount; i++) {
        row = i / Cols;
        col = i % Cols;
        x = margin + col * (w + margin);
        y = row * (h + margin) + margin;
        UIButton *btn = self.subviews[i];
        btn.frame = CGRectMake(x, y, w, h);
    }
}

#pragma mark - Private touch

- (void)deleteBtnClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:CustomTradeKeyboardDeleteButtonClickKey object:self];
}

- (void)blankBtnClick
{
    return;
}

- (void)numBtnClick:(UIButton *)numBtn
{
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[CustomTradeKeyboardNumberKey] = @(numBtn.tag);
    [[NSNotificationCenter defaultCenter] postNotificationName:CustomTradeKeyboardNumberButtonClickKey object:self userInfo:userInfo];
}

// 播放系统音效
- (void)playTock
{
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",@"Tock",@"caf"];
//    [[NSBundle mainBundle] URLForResource: @"tap" withExtension: @"aif"];  获取自定义的声音
    if (path) {
        SystemSoundID sound;
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
        if (error != kAudioServicesNoError) {
            sound = 0;
        }
        
        AudioServicesPlaySystemSound(sound);
    }
}


@end

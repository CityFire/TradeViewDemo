//
//  CustomKeyboardExample.m
//  TradeViewDemo
//
//  Created by wjc on 16/1/6.
//  Copyright © 2016年 wjc. All rights reserved.
//

#import "CustomKeyboardExample.h"
#import "CustomTradeView.h"
#import "ZKCTradePwdErrorView.h"
#import "PayPwdResetVerifyViewController.h"

@interface CustomKeyboardExample () <CustomTradeViewDelegate,ZKCTradePwdErrorViewDelegate>

// 交易密码页面
@property (nonatomic, strong) CustomTradeView *tradeView;

@property (weak, nonatomic) IBOutlet UILabel *successTipLb;

@end

@implementation CustomKeyboardExample

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (IBAction)buyClick:(id)sender {
    if (self.successTipLb.alpha == 1.0) {
        self.successTipLb.alpha = 0.0;
    }
    // 交易密码显示
    CustomTradeView *tradeView = [CustomTradeView tradeView];
    tradeView.delegate = self;
    tradeView.payMoney = [NSString stringWithFormat:@"￥%.2f", 20000.00];
    [tradeView show];
}

#pragma mark - CustomTradeViewDelegate

- (void)tradeViewDidCloseView:(CustomTradeView *)tradeView
{
    DLog(@"关闭");
    [self.view setNeedsLayout];
}

- (void)tradeViewForgetPassword:(CustomTradeView *)tradeView
{
    PayPwdResetVerifyViewController *vc = [[PayPwdResetVerifyViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)tradeViewDidFinish:(CustomTradeView *)tradeView password:(NSString *)password
{
//    DLog(@"交易密码:%@", password);
    // 密码正确
    if ([password isEqualToString:@"123456"]) {
        [tradeView dismiss];
        self.successTipLb.alpha = 1.0;
        return;
    }
    [self payByPassword:password];
}

- (void)payByPassword:(NSString *)pwd
{
    // 密码错误
    ZKCTradePwdErrorView *errorView = [ZKCTradePwdErrorView tradePwdErrorView];
    errorView.frame = CGRectMake((screenWidth-260)*0.5, (screenHeight-115)*0.5, 260, 115);
    errorView.delegate = self;
    [errorView showInSuperView:self.navigationController.view];
}

- (void)setupTradeView
{
    CustomTradeView *tradeView = [CustomTradeView tradeView];
    tradeView.delegate = self;
    tradeView.payMoney = [NSString stringWithFormat:@"￥%.2f", 20000.00];
    [tradeView show];
}

#pragma mark - ZKCTradePwdErrorViewDelegate

- (void)tradePwdErrorViewReInput:(ZKCTradePwdErrorView *)view
{
    [view dismiss];
    [self setupTradeView];
}

- (void)tradePwdErrorViewForgetPwd:(ZKCTradePwdErrorView *)view
{
    [view dismiss];
    [self tradeViewForgetPassword:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

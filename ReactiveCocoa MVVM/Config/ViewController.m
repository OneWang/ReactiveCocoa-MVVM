//
//  ViewController.m
//  ReactiveCocoa MVVM
//
//  Created by LI on 16/8/3.
//  Copyright © 2016年 LI. All rights reserved.
//

#import "ViewController.h"

#import "GloabalHeader.h"

#import "LoginViewModel.h"

#import "RequestViewModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *acountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

/** viewModel */
@property (strong, nonatomic) LoginViewModel *loginVM;

/** requestViewModel */
@property (strong, nonatomic) RequestViewModel *requestVM;

@end

@implementation ViewController

- (RequestViewModel *)requestVM
{
    if (!_requestVM) {
        _requestVM = [[RequestViewModel alloc] init];
    }
    return _requestVM;
}

- (LoginViewModel *)loginVM
{
    if (!_loginVM) {
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //发送请求
    RACSignal *signal = [self.requestVM.requestCommand execute:nil];
    
    //订阅信号
    [signal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    
    /** 
        MVVM:
        VM:视图模型,外界页面所有的业务逻辑
        每个控制器对应一个 VM 模型
        VM 最好不要包含视图 view
     */
    
    [self bindViewModel];
    
    
    [self loginEvent];
}

#pragma mark 绑定viewModel 模型
- (void)bindViewModel{
    //1.给视图模型的账号和密码绑定信号
    RAC(self.loginVM, account) = _acountField.rac_textSignal;
    RAC(self.loginVM, pwd) = _pwdField.rac_textSignal;
}

#pragma mark 处理绑定事件
- (void)loginEvent{
    //2.设置按钮是否可以点击
    RAC(self.loginBtn,enabled) = self.loginVM.loginBtnSignal;
    
    //3.监听登录按钮的点击
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击登录按钮");
        //处理登录事件
        [self.loginVM.loginCommand execute:nil];
    }];
}

@end

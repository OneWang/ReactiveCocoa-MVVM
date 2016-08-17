//
//  LoginViewModel.m
//  ReactiveCocoa MVVM
//
//  Created by LI on 16/8/4.
//  Copyright © 2016年 LI. All rights reserved.
//

#import "LoginViewModel.h"
#import "MBProgressHUD/MBProgressHUD+XMG.h"

@implementation LoginViewModel

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    //处理文本框的业务逻辑
    _loginBtnSignal = [RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, pwd)] reduce:^id(NSString *account,NSString *pwd){
        return @(account.length && pwd.length);
    }];
    
    //处理登录点击
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        //block: 执行命令就会调用这个block
        //block 的作用:事件处理
        //发送登录请求
        NSLog(@"发送登录请求");
        
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //发送数据
                [subscriber sendNext:@"请求登录数据"];
                [subscriber sendCompleted];
            });
            return nil;
        }];
    }];

    //处理登录的请求返回的结果
    //获取命令中的信号源
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    //监听命令执行过程
    [[_loginCommand.executing skip:1]subscribeNext:^(id x) {
        if ([x boolValue] == YES) {
            //正在执行
            NSLog(@"正在执行");
            //显示蒙版
            [MBProgressHUD showMessage:@"正在登录ing..."];
        }else{
            //执行完成
            NSLog(@"执行完成");
            //隐藏蒙版
            [MBProgressHUD hideHUD];
        }
    }];
}

@end

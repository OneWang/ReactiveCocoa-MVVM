//
//  LoginViewModel.h
//  ReactiveCocoa MVVM
//
//  Created by LI on 16/8/4.
//  Copyright © 2016年 LI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GloabalHeader.h"


@interface LoginViewModel : NSObject

/** 账号 */
@property (copy, nonatomic) NSString * account;
/** 密码 */
@property (copy, nonatomic) NSString * pwd;


/** 设置登录信号 */
@property (strong, nonatomic, readonly) RACSignal *loginBtnSignal;
/** 登录按钮的命令 */
@property (strong, nonatomic, readonly) RACCommand *loginCommand;

@end

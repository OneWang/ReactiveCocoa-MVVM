//
//  RequestViewModel.m
//  ReactiveCocoa MVVM
//
//  Created by LI on 16/8/4.
//  Copyright © 2016年 LI. All rights reserved.
//

#define path @"https://api.douban.com/v2/book/search"

#import "RequestViewModel.h"
#import "NSObject+Property.h"

@implementation RequestViewModel

- (instancetype)init{
    if (self = [super init]) {
        [self p_setup];
    }
    return self;
}

- (void)p_setup{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        /**
            RACSignal使用步骤：
            1.创建信号；+ (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
            2.订阅信号才会激活信号；- (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
            3.发送信号；- (void)sendNext:(id)value
         
            RACSignal的底层原理：
            1.创建信号，首先把didSubscribe保存到信号中，还不会触发；
            2.当信号被订阅，也就是调用signal的subscribeNext:nextBlock
                2.1.subscribeNext内部会调用siganl的didSubscrib
                2.2.subscribeNext内部首先会创建订阅者 subscriber ,并且把nextBlock保存到subscriber中
            3.siganl的didSubscribe中调用[subscriber sendNext:@1];
                3.1 sendNext底层其实就是执行subscriber的nextBlock;
         */
        //创建信号
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:path parameters:@{@"q" : @"美女"} progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"%@",downloadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
                NSLog(@"请求成功");
                NSArray *dictArray = responseObject[@"books"];
                NSArray *modelArray = [[dictArray.rac_sequence map:^id(id value) {
                    return [[NSObject alloc] init];
                }] array];
                [subscriber sendNext:modelArray];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"%@",error);
            }];
            return nil;
        }];
        return signal;
    }];
}

@end

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

- (instancetype)init
{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
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

//
//  RequestViewModel.h
//  ReactiveCocoa MVVM
//
//  Created by LI on 16/8/4.
//  Copyright © 2016年 LI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GloabalHeader.h"

@interface RequestViewModel : NSObject

/** 请求命令 */
@property (strong, nonatomic, readonly)  RACCommand *requestCommand;

@end

//
//  NSObject+Property.h
//  Practice
//
//  Created by John on 14/7/27.
//  Copyright © 2014年 John. All rights reserved.
//  通过解析字典自动生成属性代码

#import <Foundation/Foundation.h>

@interface NSObject (Property)

+ (void)createPropertyCodeWithDict:(NSDictionary *)dict;

@end

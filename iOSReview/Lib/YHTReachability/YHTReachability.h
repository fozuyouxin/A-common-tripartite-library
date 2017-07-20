//
//  YHTReachability.h
//  SZKNetWorkUtils
//
//  Created by 于海涛 on 16/7/23.
//  Copyright © 2016年 孙赵凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ netStateBlock)(NSInteger netState);

@interface YHTReachability : NSObject

/**
 *  网络监测
 *
 *  @param block 判断结果回调
 *
 *  @return 网络监测
 */
+(void)netWorkState:(netStateBlock)block;

+ (void)reachabilityChanged;

@end

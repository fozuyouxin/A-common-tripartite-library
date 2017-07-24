//
//  GuidanceController.h
//  LoveLimiteFree
//
//  Created by KennyHito on 16-5-11.
//  Copyright (c) 2016年 YuHaitao. All rights reserved.
/*
 实现引导页功能,当显示最后一张图片时,点击button跳转到分栏控制器.
 app第一次打开时候显示,之后不再显示.
 
 
 */

#import <UIKit/UIKit.h>

typedef void(^MyBlock)(void);

@interface GuidanceController : UIViewController

- (instancetype)initWithImages:(NSArray *)images andBlock:(MyBlock)block;
//images引导页图片
//block点击跳转时回调到APPDelegate


@end

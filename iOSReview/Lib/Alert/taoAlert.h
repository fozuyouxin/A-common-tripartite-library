//
//  taoAlert.h
//  CustomAlert
//
//  Created by CodeMonkey on 16-4-25.
//  Copyright (c) 2016年 CodeMonkey.Tao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>//支持UI
/*
 从外部传递一个控制器 提示的title message 提示的时间
 */
@interface taoAlert : NSObject
+(void)showAlertWithController:(UIViewController *)ctrView andTitlt:(NSString *)title andMessage:(NSString *)message andTime:(NSTimeInterval)time;

@end

//
//  YHTReachability.m
//  SZKNetWorkUtils
//
//  Created by 于海涛 on 16/7/23.
//  Copyright © 2016年 于海涛. All rights reserved.
//

#import "YHTReachability.h"
#import "AFNetworkReachabilityManager.h"
@implementation YHTReachability

+ (void)reachabilityChanged{
    __block typeof(self) WeakSelf = self;
    [YHTReachability netWorkState:^(NSInteger netState) {
        switch (netState) {
            case 1:{
                //NSLog(@"您正在使用3G/4G流量");
               break;
            }
            case 2:{
                //NSLog(@"您正在使用的是WiFi");
                break;
            }
            default:{
                //NSLog(@"没网");
                [WeakSelf showWarningViewAndTitle:@"当前没有网络,请检查网络!"];
                break;
            }
        }
    }];

}

#pragma mark----网络检测
+(void)netWorkState:(netStateBlock)block;
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    // 提示：要监控网络连接状态，必须要先调用单例的startMonitoring方法
    [manager startMonitoring];
    //检测的结果
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status==0||status==-1) {
            //将netState值传入block中
            block(status);
        }else{
            //将netState值传入block中
            block(status);
        }
    }];
}
#pragma mark---网络断开时弹出提示框
+(void)showWarningViewAndTitle:(NSString *)title{
    
    UIAlertView * alert =[[UIAlertView alloc]initWithTitle:@"提示" message:title delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
    [alert show];
    
}

+(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        NSLog(@"取消");
    }else{
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
#endif

    }
}

@end

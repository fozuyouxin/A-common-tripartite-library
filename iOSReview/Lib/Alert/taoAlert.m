//
//  taoAlert.m
//  CustomAlert
//
//  Created by CodeMonkey on 16-4-25.
//  Copyright (c) 2016年 CodeMonkey.Tao. All rights reserved.
//

#import "taoAlert.h"

@implementation taoAlert

+ (void)showAlertWithController:(UIViewController *)ctrView andTitlt:(NSString *)title andMessage:(NSString *)message andTime:(NSTimeInterval)time{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [ctrView presentViewController:alert animated:YES completion:nil];
    
    [self performSelector:@selector(dismissAlert:) withObject:alert afterDelay:time];
    
}
+ (void)dismissAlert:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
}
@end

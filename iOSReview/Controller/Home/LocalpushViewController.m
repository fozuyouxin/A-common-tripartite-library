//
//  LocalpushViewController.m
//  Summarize
//
//  Created by 于海涛 on 17/3/6.
//  Copyright © 2017年 于海涛. All rights reserved.
//

#import "LocalpushViewController.h"

@interface LocalpushViewController ()

@end

@implementation LocalpushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    HitoAllocInit(UILabel, lab);
    lab.frame = CGRectMake(20, 100, HitoScreenW-40, 100);
    lab.lineBreakMode = YES;
    lab.numberOfLines = 4;
    lab.text = @"“本地”可以理解为”不联网”;即使没有网络情况下,也可以推送通知消息;进入当前页面就触发本地通知了,等待10秒,就会有新的通知了,最后让app推到后台,否则效果看不出!";
    
    [self.view addSubview:lab];
    
    // 1.创建通知
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    // 2.设置通知的必选参数
    // 设置通知显示的内容
    localNotification.alertBody = @"本地通知测试";
    // 设置通知的发送时间
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    
    localNotification.alertAction = @"赶紧的了!";
    
    localNotification.applicationIconBadgeNumber = 1;
    
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    // 3.发送通知
    // 方式一: 根据通知的发送时间(fireDate)发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    // 方式二: 立即发送通知
    //[[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

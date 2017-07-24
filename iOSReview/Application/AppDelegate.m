//
//  AppDelegate.m
//  iOSReview
//
//  Created by 于海涛 on 2017/6/22.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //使用app中,屏幕不允许常亮状态
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    //1.从本地读取安装的标记
    BOOL isInstall = [[NSUserDefaults standardUserDefaults]integerForKey:@"IS_INSTALL"];
    if (!isInstall) {
        self.window.rootViewController = [self createGuidanceController];
    }else{
        HitoAllocInit(BaseTabBarController, tabVC);
        self.window.rootViewController = tabVC;
    }

    //本地推送
    [self requestAuthor];
    
#pragma mark -- 检测网络状态
    [YHTReachability reachabilityChanged];
    
     [self.window makeKeyAndVisible];
    return YES;
}

//在AppDelegate中写：
//强制使用系统键盘 >=iOS8
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier{
    if ([extensionPointIdentifier isEqualToString:@"com.apple.keyboard-service"]) {
        return NO;
    }
    return YES;
}

//创建本地通知
- (void)requestAuthor
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 设置通知的类型可以为弹窗提示,声音提示,应用图标数字提示
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        // 授权通知
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}


#pragma mark -- 创建引导页
- (GuidanceController *)createGuidanceController{
    NSArray * images = @[@"Guidance01.jpg",@"Guidance02.jpg",@"Guidance03.jpg"];
    
    MyBlock blcok = ^{
        //回调是将根控制器改为分栏
        HitoAllocInit(BaseTabBarController, tabVC);
        self.window.rootViewController = tabVC;
        
    };
    GuidanceController * guidance = [[GuidanceController alloc]initWithImages:images andBlock:blcok];
    
    return guidance;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

#pragma mark --> NSLog(@"\n ===> 程序进入前台 !");
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

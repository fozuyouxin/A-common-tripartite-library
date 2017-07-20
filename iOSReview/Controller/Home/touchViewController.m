//
//  touchViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/14.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "touchViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface touchViewController ()

@property (nonatomic,strong)UITextField * nametf;
@property (nonatomic,strong)UITextField * passtf;

@end

@implementation touchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self fingerPrint];
}

/* 设置登录页面 */
- (void)setUI{
    
    _nametf = [self createTextFieldPlaceholderTitle:@"请输入用户名" andFont:16 andTitleColor:[UIColor blackColor] andTag:100 andFrame:CGRectMake(10, 100, HitoScreenW-20 , 50) andSecureTextEntry:NO];
    [self.view addSubview:_nametf];
    
    _passtf = [self createTextFieldPlaceholderTitle:@"请输入密码" andFont:16 andTitleColor:[UIColor blackColor] andTag:101 andFrame:CGRectMake(10, CGRectGetMaxY(_nametf.frame)+15, HitoScreenW-20 , 50) andSecureTextEntry:YES];
    [self.view addSubview:_passtf];
    
    UIButton * btn = [self createButtonTitle:@"登录" andFont:18 andTitleColor:[UIColor redColor] andBackColor:[UIColor yellowColor] andTag:1000 andFrame:CGRectMake(HitoScreenW/2-50, CGRectGetMaxY(_passtf.frame)+30, 100, 50)];
    [self.view addSubview:btn];
}

- (void)btnClick:(UIButton *)btn{
    
    if ([_nametf.text isEqual:@"aaa"]&&[_passtf.text isEqual:@"123"]) {
        HitoAllocInit(sucessViewController, vc);
        [self pushNextViewController:vc];
    }else{
         [self showAlertMessage:@"登录失败"];
    }
   
}

/* 指纹解锁 */
- (void)fingerPrint{
    LAContext *context = [LAContext new];
    
    //这个属性是设置指纹输入失败之后的弹出框的选项
    context.localizedFallbackTitle = @"验证密码登录";
    context.localizedCancelTitle = @"取消";
    __weak typeof(self) WeakSelf = self;
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        NSLog(@"支持指纹识别");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请在此状态下验证你的TouchID的指纹" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"验证成功 刷新主界面");
                //这里需要开启线程,否则跳转会有问题
                dispatch_async(dispatch_get_main_queue(), ^{
                    HitoAllocInit(sucessViewController, vc);
                    [WeakSelf pushNextViewController:vc];
                });
            }else{
                switch (error.code) {
                    case LAErrorSystemCancel:
                    {
                        NSLog(@"手机切换到桌面 或者 系统取消授权，如其他APP切入");
                        break;
                    }
                    case LAErrorUserCancel:
                    {
                        NSLog(@"用户取消验证Touch ID");
                        break;
                    }
                    case LAErrorAuthenticationFailed:
                    {
                        NSLog(@"3次指纹登录失败,即为授权失败");
                        break;
                    }
                    case LAErrorPasscodeNotSet:
                    {
                        NSLog(@"系统未设置密码");
                        break;
                    }
                    case LAErrorTouchIDNotAvailable:
                    {
                        NSLog(@"设备Touch ID不可用，例如未打开");
                        break;
                    }
                    case LAErrorTouchIDNotEnrolled:
                    {
                        NSLog(@"设备Touch ID不可用，用户未录入");
                        break;
                    }
                    case LAErrorUserFallback:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"用户选择输入密码，切换主线程处理");
                        }];
                        break;
                    }
                    default:
                    {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            NSLog(@"其他情况，切换主线程处理");
                            [self.navigationController popViewControllerAnimated:YES];
                        }];
                        break;
                    }
                }
            }
        }];
    }else{
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
    }
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

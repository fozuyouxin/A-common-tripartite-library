//
//  secondViewController.m
//  iOSReview
//
//  Created by 于海涛 on 2017/6/22.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "secondViewController.h"
#import "HeadTools.h"

@interface secondViewController ()

@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI{
    [self setNavBackgroudColor:[UIColor whiteColor]];
    [self addNavCenterTitle:@"Second" andColor:[UIColor redColor] andFontSize:16];
    [self addNavLeftBarButtonWithImage:@"back"];
    //    [self addNavRightBarButtonWithImage:@"next"];
    [self addNavRightBarButtonWithText:@"Go!" andTextColor:[UIColor greenColor]];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 100, 50)];
    [btn setTitle:@"测试一下" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor yellowColor];
    btn.tag= 1000;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSLog(@"===%@",[self firstCharacterWithString:@"我们"]);
    NSLog(@"===%@",[self firstCharacterWithString:@"zoedear"]);
    
    UIButton * btn1 = [self createButtonTitle:@"嗨起来" andFont:18 andTitleColor:[UIColor redColor] andBackColor:[UIColor yellowColor] andTag:2000 andFrame:CGRectMake(10,CGRectGetMaxY(btn.frame)+5 , 140, 50)];
    [self.view addSubview:btn1];
    
    UITextField * tf = [self createTextFieldPlaceholderTitle:@"请输入昵称" andFont:16 andTitleColor:[UIColor redColor] andTag:1000 andFrame:CGRectMake(10,CGRectGetMaxY(btn1.frame)+5, 200,40)andSecureTextEntry:NO];
    [self.view addSubview:tf];
    
    UILabel * lab = [self createLabelTitle:@"123哈456哈789哈000111" andFont:18 andTitleColor:[UIColor redColor] andBackColor:[UIColor yellowColor] andTag:3000 andFrame:CGRectMake(10,CGRectGetMaxY(tf.frame)+5, 300,40) andTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:lab];
    
    [self colorLabel:lab andFont:20 andRange:NSMakeRange(0, 6) andColor:[UIColor greenColor]];
    
    [self getRequestWithUrl:@"http://luckfairy.16mb.com/PHPExercise/PHP_JSON_3.php" andParameter:@{} andReturnBlock:^(NSData *data, NSError *error) {
        if (data!=nil) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
        }else{
            NSLog(@"===%@===",error.localizedDescription);
        }
    }];
    
    

}

- (void)btnClick:(UIButton *)btn{
    if (btn.tag==1000) {
//        [self skipAppStoreWithID:@"1173184488"];
//        [self showMessage];
//        [self skipQQ:@"275108586"];
//        NSString * str = [self getVersionNumber:@"1173184488"];
//        NSLog(@"current version number:%@",str);
//        [self clearCache];
        btn.backgroundColor = self.RandomColor;
        
        
    }else if(btn.tag==2000) {
//        [self showAlertMessage:@"按钮1被点击!"];
//        NSLog(@"%@",[self getCurrentTimeNumber]);
//        NSLog(@"%@",[self timeSwitchString:[self getCurrentTimeNumber]]);
//        [self showMessageTitle:@"由于开发需要提示信息很多,无法显示完整,需求要求,显示完整,自动换行等功能;需要开发者自己重写三方的代码,代码如下" andDelay:3 andImage:@"next"];
        NSLog(@"%@",[self showCache]);
    }
}



@end

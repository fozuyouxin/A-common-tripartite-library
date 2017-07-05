//
//  ViewController.m
//  iOSReview
//
//  Created by 于海涛 on 2017/6/22.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "secondViewController.h"
#import "HeadTools.h"
#import "thirdViewController.h"
#import "fourViewController.h"
#import "filmViewController.h"

#define Alloc_vc(obj,Controller) Controller * obj = [[Controller alloc]init]

@interface ViewController ()
@property (nonatomic,copy)NSString * stu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithTitle:@"测试1" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
    item1.tag = 1000;
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithTitle:@"测试2" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
    item2.tag = 1001;
    self.navigationItem.rightBarButtonItems =@[item1,item2];
    NSLog(@"=====%f",HitoSystemVersion);
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"视频" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
    item.tag = 2000;
    self.navigationItem.leftBarButtonItem = item;
    
    
    NSArray *oldArr = @[@"12",@"123",@"123"];
    //去除数组中相同的元素
    NSArray *newArr = [oldArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"====%@====",newArr);
    
    
    NSArray * titleArr = @[@"third",@"four",@"five"];
    for (int i = 0 ; i<3; i++) {
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn1.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [btn1 setTitle:titleArr[i] forState:UIControlStateNormal];
        btn1.tag = 1000+i;
        [btn1 setFrame:CGRectMake(20, 100+i*50, HitoScreenW-40, 40)];
        [btn1.layer setMasksToBounds:YES];
        [btn1.layer setCornerRadius:4.0];
        btn1.backgroundColor = [UIColor redColor];
        [btn1 setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn1];
    }
}

- (void)btnClick:(UIButton *)btn{
    if (btn.tag ==1000) {
        HitoAllocInit(thirdViewController, view);
        [self.navigationController pushViewController:view animated:YES];
    }else if(btn.tag == 1001){
        HitoAllocInit(fourViewController, view);
        [self.navigationController pushViewController:view animated:YES];
    }else if(btn.tag == 1002){
        HitoAllocInit(fiveViewController, view);
        [self.navigationController pushViewController:view animated:YES];
    }
}



-(void)itemClick:(UIBarButtonItem * )item{
//    NSLog(@"%ld",item.tag);
    if (item.tag == 1000) {
        Alloc_vc(vc,secondViewController);
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (item.tag == 1001) {
        Alloc_vc(vc,NextViewController);
        vc.hidesBottomBarWhenPushed = YES;
        vc.block = ^(NSString * aa) {
            NSLog(@"===%@===",aa);
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if(item.tag == 2000){
        Alloc_vc(vc, filmViewController);
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

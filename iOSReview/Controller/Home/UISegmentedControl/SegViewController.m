//
//  SegViewController.m
//  Summarize
//
//  Created by 于海涛 on 2017/5/26.
//  Copyright © 2017年 于海涛. All rights reserved.
//

#import "SegViewController.h"


@interface SegViewController ()

@property (nonatomic,strong) UISegmentedControl * segC;
@property (nonatomic,strong) UIView * aview;
@property (nonatomic,strong) UIView * aview1;

@end

@implementation SegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = [NSArray arrayWithObjects:@"iOS",@"PHP", nil];
    
    self.segC = [[UISegmentedControl alloc]initWithItems:array];
    
    self.segC.frame = CGRectMake(0, 0, 100, 30);
    //更改选中的颜色
    self.segC.tintColor = [UIColor greenColor];
    //添加点击事件
    [self.segC addTarget:self action:@selector(segClick:) forControlEvents:UIControlEventValueChanged];
    //默认选择第一个
    self.segC.selectedSegmentIndex = 0;
    //添加到导航栏中
    self.navigationItem.titleView = self.segC;
    
    
    _aview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 64, HitoScreenW, HitoScreenH-64)];
    _aview1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_aview1];
    UILabel * lab1 = [[UILabel alloc]initWithFrame:CGRectMake(110, 50, 100, 50)];
    lab1.text = @"第二个view";
    [_aview1 addSubview:lab1];
    
    _aview = [[UIView alloc]initWithFrame:CGRectMake(50, 64,HitoScreenW,HitoScreenH-64)];
    _aview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_aview];
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, 100, 50)];
    lab.text = @"第一个view";
    [_aview addSubview:lab];

}

- (void)segClick:(UISegmentedControl *)segment{
    switch (segment.selectedSegmentIndex) {
        case 0:{
            [self.view bringSubviewToFront:_aview];
            break;
        }
        case 1:{
            [self.view bringSubviewToFront:_aview1];
            break;
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

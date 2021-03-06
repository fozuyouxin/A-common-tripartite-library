//
//  vipViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/19.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "vipViewController.h"

@interface vipViewController ()

@end

@implementation vipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UIView背景颜色渐变
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 100, HitoScreenW-20, 200)];
    [self.view addSubview:view];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor whiteColor] CGColor], nil];
    [view.layer insertSublayer:gradient atIndex:0];
    
    // 左上角和右上角添加圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(20, 20)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
    
    //会员卡
    UILabel * lab = [self createLabelTitle:@"Zoedear会员卡" andFont:0 andTitleColor:[UIColor redColor] andBackColor:[UIColor clearColor] andTag:50 andFrame:CGRectMake(0, 20, CGRectGetWidth(view.bounds), 30) andTextAlignment:NSTextAlignmentCenter];
    
    [view addSubview:lab];
    
    //为一个view添加虚线边框
    CAShapeLayer *border = [CAShapeLayer layer];
    border.strokeColor = [UIColor colorWithRed:67/255.0f green:37/255.0f blue:83/255.0f alpha:1].CGColor;
    border.fillColor = nil;
    border.lineDashPattern = @[@4, @2];
    border.path = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
    border.frame = view.bounds;
    [view.layer addSublayer:border];
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

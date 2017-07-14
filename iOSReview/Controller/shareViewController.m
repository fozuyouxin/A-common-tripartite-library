//
//  shareViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/10.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "shareViewController.h"

@interface shareViewController ()
@property (nonatomic,strong)UIButton * btn;
@end

@implementation shareViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addNavCenterTitle:@"Masonry使用" andColor: [UIColor orangeColor] andFontSize:15];

    [self setUI];
}

- (void)setUI{
    UIView *superview = self.view;
    superview.backgroundColor = [UIColor orangeColor];
    
    UIView *view1 = [[UIView alloc] init];
    view1.backgroundColor = [UIColor greenColor];
    [superview addSubview:view1];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(74, 10, 10, 10);
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(padding.top);
        make.left.equalTo(superview.mas_left).with.offset(padding.left);
        make.bottom.equalTo(superview.mas_bottom).with.offset(-padding.bottom);
        make.right.equalTo(superview.mas_right).with.offset(-padding.right);
    }];
    
    UIEdgeInsets padding1 = UIEdgeInsetsMake(84, 20, 20, 20);
    UIView * view2 = [[UIView alloc]init];
    view2.backgroundColor = [UIColor yellowColor];
    [superview addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superview).with.insets(padding1);
    }];
    
    self.btn = [[UIButton alloc]init];
    _btn.backgroundColor = [UIColor redColor];
    [view2 addSubview:self.btn];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view2.mas_top);//上
        make.left.mas_equalTo(view2.mas_left);//左
        make.width.mas_equalTo(@100);//宽
        make.height.mas_equalTo(@50);//高
    }];
    
    
    UIButton * btn1 = [[UIButton alloc]init];
    [view2 addSubview:btn1];
    btn1.backgroundColor = [UIColor blueColor];
    UIButton * btn2 = [[UIButton alloc]init];
    [view2 addSubview:btn2];
    btn2.backgroundColor = [UIColor darkGrayColor];
    
    int padding_t = 10;
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2).offset(padding_t);
        make.centerY.equalTo(view2);
        make.height.equalTo(@150);
        make.width.mas_equalTo(100);
        make.right.equalTo(btn2.mas_left).with.offset(-padding_t);
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view2).offset(-padding_t);
        make.centerY.equalTo(view2);
        make.height.equalTo(@150);
        make.width.mas_equalTo(btn1);
    }];
    
    UIButton * btn3 = [[UIButton alloc]init];
    btn3.backgroundColor = [UIColor cyanColor];
    [view2 addSubview:btn3];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.mas_bottom).offset(10);
        make.centerX.equalTo(btn1);
        make.width.equalTo(btn1);
        make.height.equalTo(btn1);
    }];
    
    UIButton * btn4 = [[UIButton alloc]init];
    btn4.backgroundColor = [UIColor purpleColor];
    [view2 addSubview:btn4];
    
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view2);
        make.bottom.equalTo(btn1.mas_top).offset(-10);
        make.width.equalTo(btn1);
        make.height.equalTo(btn1);
    }];
    
    
}


@end

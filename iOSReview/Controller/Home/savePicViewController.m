//
//  savePicViewController.m
//  iOSReview
//
//  Created by Apple on 2017/8/1.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "savePicViewController.h"

@interface savePicViewController ()

@property (nonatomic,strong) UIImageView * imageV;

@end

@implementation savePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     保存图片有两种方式:
     1>.按钮方式;
     2>.长按图片方式;
     */
    //显示图片
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(20, 150, HitoScreenW-40, 200)];
    //[注意🐷] : "mainAD" 这里是图片名的名字,用户更改成相应的图片名
    [_imageV sd_setImageWithURL:[NSURL URLWithString:@"http://a.hiphotos.baidu.com/image/pic/item/48540923dd54564e1a04c280bbde9c82d1584f21.jpg"] placeholderImage:[UIImage imageNamed:@"mainAD"]];
    
    //使用手势必须开启交互性
    _imageV.userInteractionEnabled = YES;
    [self.view addSubview:_imageV];
    
    //方式一 : 给图片添加长按手势
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    //设置长按时间,默认0.5秒
    longPress.minimumPressDuration = 1.0;
    [self.imageV addGestureRecognizer:longPress];
    
    //方式二 : 创建按钮
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:@"保存相册" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.frame =CGRectMake(30, 70, 90, 40);
    btn.center = CGPointMake(self.view.center.x, 100);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_imageV.frame)+20, HitoScreenW-40, 80)];
    lab.text = @"⚠️ : 该模块的功能是将图片保存到系统的相册中,保存的方式有两种,一是通过点击保存按钮;二是通过长按图片即可保存!";
    lab.font = [UIFont systemFontOfSize:17];
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    lab.numberOfLines = 3;
    [self.view addSubview:lab];
}

//长按手势实现图片保存
- (void)longPressClick:(UIGestureRecognizer *)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan ) {
        [self savePicture:self.imageV.image];
    }
}

//按钮点击事件的实现
- (void)btnClick:(UIButton *)btn{
    [self savePicture:self.imageV.image];
}


@end

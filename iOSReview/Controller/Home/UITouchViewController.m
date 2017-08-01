//
//  UITouchViewController.m
//  iOSReview
//
//  Created by Apple on 2017/8/1.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "UITouchViewController.h"

@interface UITouchViewController ()

@property (nonatomic,strong) UIImageView * imageV;
@property (nonatomic,assign) CGPoint mPtLast;

@end

@implementation UITouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 260, 300)];
    _imageV.image = [UIImage imageNamed:@"bao.jpg"];
    [self.view addSubview:_imageV];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch * touch = [touches anyObject];
    if (touch.tapCount == 1) {
        NSLog(@"单次点击");
    }else if(touch.tapCount == 2){
        NSLog(@"双次点击");
    }
    
    CGPoint pt = [touch locationInView:self.view];
    _mPtLast = pt;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint imageVPt = _imageV.frame.origin;
    //    NSLog(@"x = %f,y = %f",imageVPt.x,imageVPt.y);
    //[注意]🐷 : 200 和 300 分别代表imageV的宽和高
    //if语句用来判断,手势是否在图片上进行移动,没有这个判断可以在任何区域进行移动;
    if (_mPtLast.x >= imageVPt.x && _mPtLast.x <= imageVPt.x + 260 && _mPtLast.y >= imageVPt.y && _mPtLast.y <= imageVPt.y + 300) {
        
        UITouch * touch = [touches anyObject];
        CGPoint pt = [touch locationInView:self.view];
        NSLog(@"x = %f,y = %f",pt.x,pt.y);
        
        //获得x,y偏移量
        float xOffset = pt.x - _mPtLast.x;
        float yOffset = pt.y - _mPtLast.y;
        
        //必须将最后的位置赋给 _mPtLast
        _mPtLast = pt;
        
        _imageV.frame = CGRectMake(_imageV.frame.origin.x+xOffset, _imageV.frame.origin.y+yOffset, 260, 300);
    }
    
}



@end

//
//  fourViewController.m
//  iOSReview
//
//  Created by 于海涛 on 2017/6/26.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "fourViewController.h"
#import "HeadTools.h"


@interface fourViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIImageView * imageV;
@end

@implementation fourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"four";
    UIView * view = [self createUIViewFrame:CGRectMake(10, 100, 200, 80) andBackgroudColor:[UIColor redColor] andCircle:YES andShadow:YES andShadowColor:[UIColor blueColor]];
    [self.view addSubview:view];
    
    _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 300, 300, 300)];
    _imageV.userInteractionEnabled = YES;
//    UIImage * ia = [self colorSwitchImageWidth:50 andImageHeight:50 andColor:[UIColor orangeColor]];
//    _imageV.image = ia;
//    _imageV.image = [UIImage imageNamed:@"ying"];
//    _imageV.image = [self covertToGrayImageFromImage:[UIImage imageNamed:@"ying"]];
    NSString *playString = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"mp4"];
    UIImage * iv = [self getVideoFirstImage:playString];
    _imageV.image = iv;
    [self.view addSubview:_imageV];
    
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
    //设置长按时间,默认0.5秒
    longPress.minimumPressDuration = 1.0;
    [self.imageV addGestureRecognizer:longPress];
    
    NSLog(@"沙盒路径 : %@",HitoHomePath);
    /* 获取手机型号 */
    NSLog(@"%@",self.getDeviceInfo);
    
    NSLog(@"one---%@---",[self removeSpaceAndNewline:@"welcome to beijing!"]);
    NSLog(@"two---%d---",[self isBlank:@"welcome to beijing!"]);
    
    
}

- (void)longPressClick:(UIGestureRecognizer *)longPress{
    //必须加上判断语句防止多次保存
    if (longPress.state == UIGestureRecognizerStateBegan ) {
        [self savePicture:self.imageV.image];
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

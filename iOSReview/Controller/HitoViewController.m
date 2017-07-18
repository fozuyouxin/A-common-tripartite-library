//
//  HitoViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/10.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "HitoViewController.h"

#define Alloc_vc(obj,Controller) Controller * obj = [[Controller alloc]init]

@interface HitoViewController ()

@property (nonatomic,strong) UIButton * button;//客服按钮

@end

@implementation HitoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setUpService];
    
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc]initWithTitle:@"基本" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
    item1.tag = 1000;
    UIBarButtonItem * item2 = [[UIBarButtonItem alloc]initWithTitle:@"block回调" style:UIBarButtonItemStylePlain target:self action:@selector(itemClick:)];
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
    
    
    NSArray * titleArr = @[@"tableViewCell",@"four",@"会员卡",@"分享",@"Masonry",@"指纹解锁"];
    for (int i = 0 ; i<titleArr.count; i++) {
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
    
    NSDictionary * dic = @{@"id":@"123",@"name":@"xiaoming"};
    NSLog(@"==0==%@",dic);
    NSMutableDictionary * dic1 = [[NSMutableDictionary alloc]initWithDictionary:@{@"id":@"456",@"score":@(89)}];
    NSLog(@"==1==%@",dic1);
    [dic1 addEntriesFromDictionary:dic];
    NSLog(@"==2==%@",dic1);
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
    }else if(btn.tag == 1003){
        //苹果系统自带分享功能
        UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[@"分享内容名称",[NSURL URLWithString:@"https://github.com/NSLog-YuHaitao/iOSReview"]] applicationActivities:nil];
        [self presentViewController:avc animated:YES completion:nil];
        
    }else if(btn.tag == 1004){
        
        HitoAllocInit(shareViewController, view);
        [self.navigationController pushViewController:view animated:YES];
        
    }else if(btn.tag == 1005){
        
        HitoAllocInit(touchViewController, view);
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

- (void)setUpService{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"客服" forState:UIControlStateNormal];
    button.titleLabel.numberOfLines = 0;
    button.titleLabel.textAlignment = 1;
    button.titleLabel.font = [UIFont systemFontOfSize:11];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor yellowColor];
    button.layer.cornerRadius = 20;
    button.layer.masksToBounds = YES;
    [HitoApplication addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));//设置按钮大小
        make.right.mas_equalTo(0);//距右边边距
        make.bottom.mas_lessThanOrEqualTo(0);//小于或等于
        make.top.mas_greaterThanOrEqualTo(200);//大于或等于
    }];
    
    self.button = button;
    
    // 手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [button addGestureRecognizer:pan];
}

- (void)present{
    [self skipQQ:@"1154180808"];
}

#pragma mark - 手势
- (void)pan:(UIPanGestureRecognizer *)panGesture{
//locationInView:获取到的是手指点击屏幕实时的坐标点；
//translationInView：获取到的是手指移动后，在相对坐标中的偏移量

    UIView *button = panGesture.view;
    CGPoint newCenter = CGPointMake([panGesture translationInView:panGesture.view].x + button.center.x - [UIScreen mainScreen].bounds.size.width / 2, [panGesture translationInView:panGesture.view].y + button.center.y - [UIScreen mainScreen].bounds.size.height / 2);
    
    [button mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(newCenter).priorityLow();
    }];
    [panGesture setTranslation:CGPointZero inView:panGesture.view];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [HitoApplication removeFromSuperview];
}
@end

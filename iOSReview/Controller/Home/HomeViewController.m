//
//  HomeViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/19.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "HomeViewController.h"
#import "UIImage+GIF.h"
#import "WindowView.h"

@interface HomeViewController ()

@property (nonatomic, strong) WindowView *windowView1;
@property (nonatomic, strong) WindowView *windowView2;


@end

@implementation HomeViewController

#pragma mark -- 客服功能
- (void)setUpService{
    
//    self.windowView1 = [[WindowView alloc] initWithWindowView: CGSizeZero withClickBlock:^{
//        [self skipQQ:@"1154180808"];
//    }];
    
    self.windowView2 = [[WindowView alloc] initWithWindowView: CGSizeMake(40, 40) withImage:@"kefu.png" withClickBlock:^{
        [self skipQQ:@"1154180808"];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self.dataArr addObjectsFromArray:@[@"Masonry使用",@"指纹解锁",@"网络/本地 视频播放",@"制作会员卡",@"苹果系统自带分享功能",@"苹果自带摇一摇功能",@"Block回调使用",@"AFNetworking网络请求",@"苹果原生定位系统",@"自学PHP后台开发",@"调用相机/相册",@"UIScrollView轮播效果",@"UISegmentedControl分段",@"本地推送",@"二维码扫描",@"物流查询功能",@"FMDB如何使用,收藏功能",@"HTML5交互",@"仿京东地址选择器",@"UITouch移动图片位置",@"图片保存",@"打开/关闭闪光灯",@"标签选择",@"加入购物车动画"]];
    
    [self addNavRightBarButtonWithText:@"无网络" andTextColor:[UIColor whiteColor]];
    
    NSArray *oldArr = @[@"12",@"123",@"123"];
    //去除数组中相同的元素
    NSArray *newArr = [oldArr valueForKeyPath:@"@distinctUnionOfObjects.self"];
    NSLog(@"====%@====",newArr);
    
    NSLog(@"%f,%f",HitoScreenW,HitoScreenH);
    NSLog(@"%f,%f",HitoActureWidth(100),HitoActureHeight(206));

    [self addDropUpRefresh];
    [self addDropDownRefresh];

    //自定义动画
    //[self showHudInView:HitoApplication];
    
}

/* 点击右侧导航栏按钮 */
- (void)rightNavClick:(UIBarButtonItem *)item{
    NSLog(@"===点击右侧导航栏按钮===");
}

- (void)showHudInView:(UIView *)view{
    //自定义动画
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HitoScreenW/2-30, HitoScreenH/2-30, 60, 60)];
    gifImageView.backgroundColor = [UIColor whiteColor];
    gifImageView.image = [UIImage imageNamed:@"king1"];
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    for (int i = 1; i < 6; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"king%d", i]];
        [arrM addObject:image];
    }
    [gifImageView setAnimationImages:arrM];
    [gifImageView setAnimationDuration:0.5];
    [gifImageView startAnimating];
    [view addSubview:gifImageView];
}

/* cell内容 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //Masonry使用
        HitoAllocInit(MasonryViewController, view);
        view.navigationItem.title = @"Masonry使用";
        [self pushNextViewController:view];
        
    }else if(indexPath.row == 1) {
        //指纹解锁
        HitoAllocInit(touchViewController, view);
        view.navigationItem.title = @"指纹解锁";
        [self pushNextViewController:view];        
    }else if(indexPath.row == 2) {
        //视频播放
        HitoAllocInit(VideoViewController, view);
        view.navigationItem.title = @"视频播放";
        [self pushNextViewController:view];
    }else if(indexPath.row == 3) {
        //会员卡制作
        HitoAllocInit(vipViewController, view);
        view.navigationItem.title = @"会员卡制作";
        [self pushNextViewController:view];        
    }else if(indexPath.row == 4) {
        //苹果系统自带分享功能
        UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[@"分享内容名称",[NSURL URLWithString:@"https://github.com/NSLog-YuHaitao/iOSReview"]] applicationActivities:nil];
        [self presentViewController:avc animated:YES completion:nil];

    }else if(indexPath.row == 5) {
        //原生摇一摇
        HitoAllocInit(ShakeViewController, view);
        view.navigationItem.title = @"原生摇一摇";
        [self pushNextViewController:view];
        
    }else if(indexPath.row == 6) {
        //Block回调
        HitoAllocInit(BlockViewController, view);
        view.navigationItem.title = @"Block回调";
        view.block = ^(NSString * aa) {
            NSLog(@"===%@===",aa);
        };
        [self pushNextViewController:view];
        
    }else if(indexPath.row == 7) {
        //网络请求
        HitoAllocInit(AFViewController, view);
        view.navigationItem.title = @"网络请求";
        [self pushNextViewController:view];
        
    }else if(indexPath.row == 8) {
        //原生定位
        HitoAllocInit(LocationViewController, view);
        view.navigationItem.title = @"原生定位";
        [self pushNextViewController:view];
    }else if(indexPath.row == 9) {
        //自学php
        HitoAllocInit(ownViewController, view);
        view.navigationItem.title = @"自学php";
        [self pushNextViewController:view];
    }else if(indexPath.row == 10) {
        //相机相册
        HitoAllocInit(photoViewController, view);
        view.navigationItem.title = @"相机相册";
        [self pushNextViewController:view];
    }else if(indexPath.row == 11) {
        HitoAllocInit(YHTScrollView, view);
        view.navigationItem.title = @"轮播图";
        [self pushNextViewController:view];
    }else if(indexPath.row == 12) {
        HitoAllocInit(SegViewController, view);
        [self pushNextViewController:view];
        
    }else if(indexPath.row == 13) {
        HitoAllocInit(LocalpushViewController, view);
        view.navigationItem.title = @"本地推送";
        [self pushNextViewController:view];
        
    }else if(indexPath.row == 14) {
        HitoAllocInit(QRCodeViewController, view);
        view.navigationItem.title = @"二维码扫描";
        [self pushNextViewController:view];
    }else if(indexPath.row == 15) {
        HitoAllocInit(logisticsViewController, view);
        view.navigationItem.title = @"物流查询";
        [self pushNextViewController:view];
    }else if(indexPath.row == 16) {
        HitoAllocInit(DBViewController, view);
        view.navigationItem.title = @"FMDB";
        [self pushNextViewController:view];
    }else if(indexPath.row == 17) {
        HitoAllocInit(HTML5ViewController, view);
        view.navigationItem.title = @"HTML5交互";
        [self pushNextViewController:view];
    }else if(indexPath.row == 18) {
        HitoAllocInit(addressViewController, view);
        view.navigationItem.title = @"仿京东地址选择器";
        [self pushNextViewController:view];
    }else if(indexPath.row == 19) {
        HitoAllocInit(UITouchViewController, view);
        view.navigationItem.title = @"图片位置";
        [self pushNextViewController:view];
    }else if(indexPath.row == 20) {
        HitoAllocInit(savePicViewController, view);
        view.navigationItem.title = @"图片保存";
        [self pushNextViewController:view];
    }else if(indexPath.row == 21) {
        HitoAllocInit(lightViewController, view);
        view.navigationItem.title = @"打开/关闭闪光灯";
        [self pushNextViewController:view];
    }else if(indexPath.row == 22) {
        HitoAllocInit(tagViewController, view);
        view.navigationItem.title = @"标签";
        [self pushNextViewController:view];
    }else if(indexPath.row == 23) {
        HitoAllocInit(GouwuViewController, view);
        view.navigationItem.title = @"购物车";
        [self pushNextViewController:view];
    }

}

#pragma mark --下拉刷新
- (void)addDropDownRefresh{
    NSLog(@"dddf");
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //下拉刷新
        [self.tableView. mj_header endRefreshing];
    }];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
    self.tableView. mj_header = header;
}

#pragma mark -- 上拉加载
- (void)addDropUpRefresh{
    MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        //加载更多方法调用
        [self.tableView. mj_footer endRefreshing];
    }];
    [footer setTitle:@"正在加载" forState:MJRefreshStateRefreshing ];
    [footer setTitle:@"松开加载" forState:MJRefreshStatePulling];
    self.tableView. mj_footer = footer;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.windowView2 windowButtonHide];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpService];
}

@end

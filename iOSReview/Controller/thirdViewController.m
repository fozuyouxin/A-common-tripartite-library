//
//  thirdViewController.m
//  iOSReview
//
//  Created by 于海涛 on 2017/6/26.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "thirdViewController.h"
#import "HeadTools.h"

@interface thirdViewController ()

@end

@implementation thirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"third";
    [self setUpTableView];
    self.tableView.frame = CGRectMake(0,0, HitoScreenW, HitoScreenH);
    [self addDropUpRefresh];
    [self addDropDownRefresh];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
/* cell内容 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.textLabel.text =[NSString stringWithFormat:@"This's %ld data!",indexPath.row];
    return cell;
}

#pragma mark --下拉刷新
- (void)addDropDownRefresh{
#pragma mark 文字加载
//    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        
//        //下拉刷新
//        [self.tableView. mj_header endRefreshing];
//    }];
//    
//    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
//    [header setTitle:@"松开刷新" forState:MJRefreshStatePulling];
//    self.tableView. mj_header = header;
    
#pragma mark 动画加载
//    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    //隐藏刷新时间
//    header.lastUpdatedTimeLabel.hidden = YES;
//    //隐藏刷新提示文字
//    header.stateLabel.hidden = YES;
//    NSMutableArray * arr = [[NSMutableArray alloc]init];
//    for (int i=1; i<9; i++) {
//        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"niao_%d.png",i]]];
//    }
//    NSArray * idleImages = arr;
//    [header setImages:idleImages forState:MJRefreshStatePulling];
//    self.tableView.mj_header = header;
    

}

- (void)loadNewData{
    [self.tableView.mj_header endRefreshing];
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


@end

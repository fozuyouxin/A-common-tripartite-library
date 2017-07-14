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

@property (nonatomic,strong) NSMutableArray * dataAr;

@end

@implementation thirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataAr = [[NSMutableArray alloc]init];
    self.navigationItem.title = @"third";
    [self setUpTableView];
    self.tableView.frame = CGRectMake(0,0, HitoScreenW, HitoScreenH);
    [self addDropUpRefresh];
    [self addDropDownRefresh];
    [self AFNetworking];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataAr.count;
}

/* cell内容 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Student * user = _dataAr[indexPath.row];
    cell.textLabel.text = user.stuName;
    cell.detailTextLabel.text = user.stuHeight;
    return cell;
}

#pragma mark 下拉刷新
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
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    //隐藏刷新时间
    header.lastUpdatedTimeLabel.hidden = YES;
    //隐藏刷新提示文字
    header.stateLabel.hidden = YES;
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (int i=1; i<9; i++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"niao_%d.png",i]]];
    }
    NSArray * idleImages = arr;
    [header setImages:idleImages forState:MJRefreshStatePulling];
    self.tableView.mj_header = header;
}

- (void)loadNewData{
    [self AFNetworking];
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


- (void)AFNetworking{
    [self.dataAr removeAllObjects];
    [self getRequestWithUrl:@"http://luckfairy.16mb.com/PHPExercise/PHP_JSON_3.php" andParameter:@{} andReturnBlock:^(NSData *data, NSError *error) {
        if (data!=nil) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",dic);
            NSArray * arr = dic[@"data"];
            for (NSDictionary * d in arr) {
                Student *stu = [Student mj_objectWithKeyValues:d];
                [_dataAr addObject:stu];
            }
            NSLog(@"json====%ld",_dataAr.count);
            [self.tableView reloadData];
        }else{
            NSLog(@"===%@===",error.localizedDescription);
        }
    }];
}

@end

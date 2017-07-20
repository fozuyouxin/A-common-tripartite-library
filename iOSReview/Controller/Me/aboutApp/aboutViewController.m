//
//  aboutViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/20.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "aboutViewController.h"

@interface aboutViewController ()

@end

@implementation aboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    self.tableView.backgroundColor = HitoRGBA(230.0, 230.0, 230.0, 1);
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:@[@"去评价"]];
}

/* 组头高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    UIImageView * iv = [[UIImageView alloc]init];
    int width = 80;
    iv.frame = CGRectMake(HitoScreenW/2-width/2, 20, width, width);
    iv.image = [UIImage imageNamed:@"zoedear.jpg"];
    iv.layer.cornerRadius = 10;
    iv.layer.masksToBounds = YES;
    [view addSubview:iv];
    
    NSString *localVersion = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    UILabel * lab = [self createLabelTitle:[NSString stringWithFormat:@"版本号:%@",localVersion] andFont:12 andTitleColor:[UIColor blackColor] andBackColor:[UIColor clearColor] andTag:100 andFrame:CGRectMake(0, CGRectGetMaxY(iv.frame)+10, HitoScreenW, 20) andTextAlignment:NSTextAlignmentCenter];
    [view addSubview:lab];
    
    return view;
}
/* cell点击事件 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSString * MyID = @"1173184488";
        NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8", MyID];
        [self openFuncCommd:urlStr];
    }
}

@end

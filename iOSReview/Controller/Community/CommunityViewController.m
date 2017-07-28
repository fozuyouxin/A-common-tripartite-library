//
//  CommunityViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/19.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "CommunityViewController.h"

@interface CommunityViewController ()

@property (nonatomic,strong)NSMutableArray *flagArray;//标识

@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _flagArray = [[NSMutableArray alloc]init];
    [self setData];
    [self setUpTableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setData{
    [self.dataArr removeAllObjects];
    for (int i = 0; i<26; i++) {
        [self.dataArr addObject:[NSString stringWithFormat:@"%c",i+65]];
         [_flagArray addObject:@"0"];
    }
}

/* 组数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
/* 组尾高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
/* 行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
/* 组头高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

/* cell显示 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.textLabel.text = [NSString stringWithFormat:@"%@中的第%ld条记录",self.dataArr[indexPath.section],indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.clipsToBounds = YES;//必须加上
    return cell;
}

//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_flagArray[indexPath.section] isEqualToString:@"1"]){
        return 0;
    }else{
        return 44;
    }
}

//组头视图
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HitoAllocInit(UIView, view);
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, HitoScreenW-60, 30)];
    label.text = self.dataArr[section];
    label.backgroundColor = [UIColor clearColor];
    label.userInteractionEnabled = YES;
    label.tag = section;
    [view addSubview:label];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(HitoScreenW-40, 0, 20, 20)];
    if ([_flagArray[section] isEqualToString:@"0"]) {
        [btn setImage:[UIImage imageNamed:@"xia"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"you"] forState:UIControlStateNormal];
    }
    [view addSubview:btn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sectionClick:)];
    [label addGestureRecognizer:tap];
    
    return view;
}

//右侧索引
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.dataArr;
}
//根据索引定位位置
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    
    NSLog(@"===%@  ===%ld",title,index);
    //点击索引 列表跳转到对应索引的行
    [tableView
      scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
       atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}

- (void)sectionClick:(UITapGestureRecognizer *)tap{
    NSUInteger index = tap.view.tag;
    
    if ([_flagArray[index] isEqualToString:@"0"]) {
        
        _flagArray[index] = @"1";
        NSRange range = NSMakeRange(index, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationAutomatic];
        
    } else {

        _flagArray[index] = @"0";
        NSRange range = NSMakeRange(index, 1);
        NSIndexSet *sectionToReload = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.tableView reloadSections:sectionToReload withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

@end

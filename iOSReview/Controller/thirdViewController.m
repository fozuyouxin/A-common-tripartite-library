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

    [self setUpTableView];
    self.tableView.frame = CGRectMake(0,0, HitoScreenW, HitoScreenH);
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




@end

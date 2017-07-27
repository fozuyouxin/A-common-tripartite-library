//
//  DBViewController.m
//  iOSReview
//
//  Created by Apple on 2017/7/26.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "DBViewController.h"

@interface DBViewController ()

@end

@implementation DBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    self.tableView.frame = CGRectMake(0,0, HitoScreenW, HitoScreenH);
    [self AFNetworking];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

/* cell内容 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    Student * user = self.dataArr[indexPath.row];
    cell.textLabel.text = user.stuName;

    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(HitoScreenW-180, 0, 100, CGRectGetHeight(cell.bounds))];
    label.textAlignment = NSTextAlignmentRight;
    label.font = [UIFont systemFontOfSize:13];
    [cell.contentView addSubview:label];
    
    UISwitch * sw = [[UISwitch alloc]initWithFrame:CGRectMake(50, 50, 100, 50)];
    sw.on = NO;//默认关闭状态
    label.text = @"未收藏";
    sw.tag = [user.MyID integerValue];
    if ([[SQliteManager defaultSqliteManager] isExsitMenuWithID:user.MyID]) {
        sw.on = YES;
        label.text = @"已收藏";
    }
    [sw addTarget:self action:@selector(changeEvent:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = sw;
    
    return cell;
}
#pragma mark -- UISwitch开关按钮事件实现
- (void)changeEvent:(UISwitch *)sw{
  
    NSString * strTag = [NSString stringWithFormat:@"%ld",sw.tag];
    if (sw.on) {
        //开启
        [[SQliteManager defaultSqliteManager] menuWithID:strTag];
    }else{
        //关闭
        [[SQliteManager defaultSqliteManager] deleteMenuWithID:strTag];
    }
    [self reloadTableView];
}

- (void)AFNetworking{
    [self.dataArr removeAllObjects];
    [self getRequestWithUrl:@"http://luckfairy.16mb.com/PHPExercise/PHP_JSON_3.php" andParameter:@{} andReturnBlock:^(NSData *data, NSError *error) {
        if (data!=nil) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray * arr = dic[@"data"];
            for (NSDictionary * d in arr) {
                Student *stu = [[Student alloc]init];
                [stu setValuesForKeysWithDictionary:d];
                [self.dataArr addObject:stu];
            }
            [self.tableView reloadData];
        }else{
            
        }
    }];
}


@end

//
//  TopLineViewController.m
//
//  Created by 于海涛 on 16/7/18.
//  Copyright © 2016年 sun. All rights reserved.
//

#import "TopLineViewController.h"
#import "MenuModel.h"
#import "showViewController.h"

#define MENU_NAME @"http://mapi.damai.cn/proj/HotProj.aspx?CityId=0&source=10099&version=30602"

@interface TopLineViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation TopLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    _dataArr = [[NSMutableArray alloc]init];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-264-44) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    //注册cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
    
    [self.view addSubview:_tableView];
    
    [self createRequest];
    
}

- (void)createRequest{
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [[NSSet alloc]initWithObjects:@"text/html",@"application/json", nil];
    [manager GET:MENU_NAME parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
        if (responseObject!= nil) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //            NSLog(@"%@",dic);
            
            NSArray * listArr = dic[@"list"];
            //            NSLog(@"%@",listArr);
            
            for (NSDictionary * listDic in listArr) {
                MenuModel * model = [[MenuModel alloc]init];
                [model setValuesForKeysWithDictionary:listDic];
                [_dataArr addObject:model];
            }
            [_tableView reloadData];
            
#pragma mark -- 最后一条文本放到最后
//            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataArr.count - 1 inSection:0];
//            [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
    }];
    
}

#pragma mark -- tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    
    MenuModel * model = _dataArr[indexPath.row];
    
    cell.textLabel.text = model.Name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    showViewController * showVC = [[showViewController alloc]init];
    [showVC sendDataArr:_dataArr[indexPath.row]];
    [self.navigationController pushViewController:showVC animated:YES];
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

//
//  DetailsLogisticsViewController.m
//  singleTest
//
//  Created by 于海涛 on 16/12/15.
//  Copyright © 2016年 KennyHito. All rights reserved.
//

#import "DetailsLogisticsViewController.h"

#define Base_URL  @"http://www.kuaidi100.com/query"

@interface DetailsLogisticsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) UITableView * tabelView;
@property (nonatomic,strong) UILabel * lab;

@end

@implementation DetailsLogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"物流详情";
    [self createTableView];
    [self requestData];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
    }
    return _dataArr;
}

- (void)requestData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    //self.logistCompany  self.logistNum
    [params addEntriesFromDictionary:@{@"type":self.logistCompany,@"postid":self.logistNum,@"id":@"1",@"valicode":@"",@"temp":@"12345"}];

    [manager GET:Base_URL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *Dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray * dataArr = Dict[@"data"];
        
        if (!dataArr.count) {
            [taoAlert showAlertWithController:self andTitlt:@"错误信息:" andMessage:@"输入的订单号或者物流公司有误,请检查!" andTime:3.0];
            return;
        }
        for (NSDictionary * dataDic in dataArr) {
            
            dataModel * model = [[dataModel alloc]init];
            [model setValuesForKeysWithDictionary:dataDic];
            [self.dataArr addObject:model];
            
        }
         [_tabelView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
       
    }];

}

- (void)createTableView{
    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, HitoScreenW, HitoScreenH-64) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tabelView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"cell1";
    
    BaseTableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    dataModel * model = self.dataArr[indexPath.row];
    [cell setText:model.context andTime:model.time];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    dataModel * model = self.dataArr[indexPath.row];
    CGSize size = [self sizeWithString:model.context size:CGSizeMake(HitoScreenW-30, MAXFLOAT) font:[UIFont systemFontOfSize:14]];
    return size.height+40;
}

- (CGSize)sizeWithString:(NSString *)string size:(CGSize)size1 font:(UIFont *)font{
    CGRect rect = [string boundingRectWithSize:size1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return rect.size;
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

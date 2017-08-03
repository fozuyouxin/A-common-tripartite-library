//
//  tagViewController.m
//  iOSReview
//
//  Created by Apple on 2017/8/3.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "tagViewController.h"
#import "tagModel.h"

static NSString * cellID = @"cellID";

@interface tagViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray * dataArr;
@end

@implementation tagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setData];
    [self setCollectionView];
}

- (void)setData{
    _dataArr = [[NSMutableArray alloc]init];
    NSString * path = [[NSBundle mainBundle]pathForResource:@"tagsData" ofType:@"plist"];
    NSArray * arr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary * dic in arr) {
        tagModel * model = [[tagModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArr addObject:model];
    }
}

- (void)setCollectionView{
    UICollectionViewFlowLayout * layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.minimumLineSpacing = 5;
    layOut.minimumInteritemSpacing = 5;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, HitoScreenW-20, HitoScreenH-20) collectionViewLayout:layOut];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self.view addSubview:_collectionView];
}

#pragma mark -------------------UICollectionDelegate----------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    tagModel * model = self.dataArr[indexPath.row];
    UILabel * lab = [[UILabel alloc]init];
    lab.layer.borderWidth = 1;
    lab.layer.borderColor = [self colorWithHexadecimal:model.color].CGColor;
    lab.backgroundColor = [UIColor whiteColor];
    lab.textColor = [self colorWithHexadecimal:model.color];
    lab.text = model.title;
    lab.textAlignment = NSTextAlignmentCenter;
    CGSize size = [self widthForLabel:lab.text fontSize:16];
    lab.frame = CGRectMake(0, 0,size.width+10, 21);
    [cell addSubview:lab];
    
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    tagModel *model = self.dataArr[indexPath.row];
    CGFloat width = [self widthForLabel:model.title fontSize:16].width;
    return CGSizeMake(width+10,32);
}

/* 计算文字宽度 */
- (CGSize)widthForLabel:(NSString *)text fontSize:(CGFloat)font{
    
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    return size;
}

- (UIColor *)colorWithHexadecimal:(NSString *)hexCode{
    NSString *cleanString = [hexCode stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end

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
@property (nonatomic,strong) NSMutableArray * titleArr;
@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) NSMutableArray * allArr;//全部标签
@property (nonatomic,strong) NSMutableArray * meArr;//我的标签

@end

@implementation tagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArr = [NSMutableArray arrayWithArray:@[@"我的标签",@"全部标签"]];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setData];
    [self setCollectionView];
}

//初始化数据
- (void)setData{
    _dataArr = [[NSMutableArray alloc]init];
    _allArr = [[NSMutableArray alloc]init];
    _meArr = [[NSMutableArray alloc]init];
    NSString * path = [[NSBundle mainBundle]pathForResource:@"tagsData" ofType:@"plist"];
    NSArray * arr = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary * dic in arr) {
        tagModel * model = [[tagModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.allArr addObject:model];
    }
    [self.dataArr addObjectsFromArray:@[self.meArr,self.allArr]];
}

//创建CollectionView
- (void)setCollectionView{
    UICollectionViewFlowLayout * layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.minimumLineSpacing = 5;
    layOut.minimumInteritemSpacing = 5;
    layOut.headerReferenceSize=CGSizeMake(self.view.frame.size.width, 30); //设置collectionView头视图的大小
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, HitoScreenW-20, HitoScreenH-20) collectionViewLayout:layOut];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    //注册cell
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    //注册头视图
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    [self.view addSubview:_collectionView];
}

#pragma mark -------------------UICollectionDelegate----------------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * arr = self.dataArr[section];
    return arr.count;
}

//cell内容
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    // 防止复用
    for (UIView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    tagModel * model = self.dataArr[indexPath.section][indexPath.row];
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

//cell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    tagModel *model = self.dataArr[indexPath.section][indexPath.row];
    CGFloat width = [self widthForLabel:model.title fontSize:16].width;
    return CGSizeMake(width+10,32);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];

        HitoAllocInit(UILabel, lab);
        lab.frame = header.bounds;
        lab.text = _titleArr[indexPath.section];
        lab.textColor = [UIColor blackColor];
        lab.backgroundColor = [UIColor whiteColor];
        for (UIView *view in header.subviews) {
            [view removeFromSuperview];
        } // 防止复用分区头
        [header addSubview:lab];
        return header;
    } else {
        return nil;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld组===第%ld个",indexPath.section,indexPath.row);
    
    if (indexPath.section == 0) {
        [self.allArr addObject:self.meArr[indexPath.row]];
        [self.meArr removeObjectAtIndex:indexPath.row];
    }else{
        [self.meArr addObject:self.allArr[indexPath.row]];
        [self.allArr removeObjectAtIndex:indexPath.row];
    }
    [collectionView reloadData];
}

/* 计算文字宽度 */
- (CGSize)widthForLabel:(NSString *)text fontSize:(CGFloat)font{
    
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:font], NSFontAttributeName, nil]];
    return size;
}

//十六进制转颜色
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

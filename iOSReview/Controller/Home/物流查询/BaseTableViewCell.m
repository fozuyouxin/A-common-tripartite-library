//
//  BaseTableViewCell.m
//  Summarize
//
//  Created by 于海涛 on 16/12/16.
//  Copyright © 2016年 于海涛. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, HitoScreenW-30, 100)];
    _lab.lineBreakMode = NSLineBreakByWordWrapping;
    _lab.numberOfLines = 3;
    [self.contentView addSubview:_lab];
    
    _lab1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 8, 8)];
    _lab1.backgroundColor = [UIColor redColor];
    _lab1.layer.cornerRadius = 4;
    _lab1.layer.masksToBounds = YES;
    _lab1.center = CGPointMake(5, _lab.center.y);
    [self.contentView addSubview:_lab1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

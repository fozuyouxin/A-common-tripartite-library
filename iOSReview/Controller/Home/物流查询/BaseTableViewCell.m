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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    _lab = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, HitoScreenW-30, 100)];
    _lab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_lab];
    
    _lab1 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(_lab.frame), HitoScreenW-30, 20)];
    _lab1.textColor = [UIColor grayColor];
    _lab1.font = [UIFont systemFontOfSize:12];
    [self addSubview:_lab1];
}

- (void)setText:(NSString *)text andTime:(NSString *)time{
    _lab.text = text;
    _lab.numberOfLines = 100;
    CGSize size = [self sizeWithString:_lab.text size:CGSizeMake(HitoScreenW-30, MAXFLOAT) font:_lab.font];
    _lab.frame = CGRectMake(15, 5, HitoScreenW-30, size.height);
    
    _lab1.frame = CGRectMake(15, CGRectGetMaxY(_lab.frame)+3, HitoScreenW-30, 20);
    _lab1.text = time;
}

- (CGSize)sizeWithString:(NSString *)string size:(CGSize)size1 font:(UIFont *)font{
    CGRect rect = [string boundingRectWithSize:size1 options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil];
    return rect.size;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

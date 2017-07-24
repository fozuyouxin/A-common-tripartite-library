//
//  BaseTableViewCell.h
//  Summarize
//
//  Created by 于海涛 on 16/12/16.
//  Copyright © 2016年 于海涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel * lab;
@property (nonatomic,strong) UILabel * lab1;

- (void)setText:(NSString *)text andTime:(NSString *)time;
@end

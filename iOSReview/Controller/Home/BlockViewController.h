//
//  BlockViewController.h
//  iOSReview
//
//  Created by Apple on 2017/7/19.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^ myBlock)(NSString *);

@interface BlockViewController : BaseViewController

@property (nonatomic,strong)myBlock  block;

@end

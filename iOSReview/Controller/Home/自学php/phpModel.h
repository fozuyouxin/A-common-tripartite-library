//
//  phpModel.h
//  phpOwnTest
//
//  Created by 于海涛 on 2017/5/25.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import <Foundation/Foundation.h>
#define PROPERTY(key) @property (nonatomic,strong) NSString * key

@interface phpModel : NSObject

PROPERTY(stuName);
PROPERTY(stuAge);
PROPERTY(stuHeight);

- (void)setValue:(id)value forUndefinedKey:(NSString *)key;

@end

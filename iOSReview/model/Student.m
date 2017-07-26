//
//  Student.m
//  iOSReview
//
//  Created by Apple on 2017/7/13.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        self.MyID = value;
    }
}


@end

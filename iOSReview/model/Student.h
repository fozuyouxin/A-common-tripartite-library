//
//  Student.h
//  iOSReview
//
//  Created by Apple on 2017/7/13.
//  Copyright © 2017年 KennyHito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

HitoProperty(stuAge);
HitoProperty(stuHeight);
HitoProperty(stuName);
- (void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end

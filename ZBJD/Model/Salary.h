//
//  Salary.h
//  ZBJD
//
//  Created by 叶帆 on 14-10-26.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Salary : NSObject

@property (nonatomic, copy) NSString *finish;
@property (nonatomic, copy) NSString *line;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *sellMonth;
@property (nonatomic, copy) NSString *sellYear;

- (id)initWithDict:(NSDictionary *)dict;

@end

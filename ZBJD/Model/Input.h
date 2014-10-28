//
//  Input.h
//  ZBJD
//
//  Created by 叶帆 on 14-10-28.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Input : NSObject

@property (nonatomic, copy) NSString *finish;
@property (nonatomic, copy) NSString *line;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *month;
@property (nonatomic, copy) NSString *year;

- (id)initWithDict:(NSDictionary *)dict;

@end

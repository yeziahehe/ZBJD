//
//  Develop.h
//  ZBJD
//
//  Created by 叶帆 on 14-10-25.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Develop : NSObject

@property (nonatomic, copy)NSString *cancel;
@property (nonatomic, copy)NSString *developDate;
@property (nonatomic, copy)NSString *finish;
@property (nonatomic, copy)NSString *line;

- (id)initWithDict:(NSDictionary *)dict;

@end

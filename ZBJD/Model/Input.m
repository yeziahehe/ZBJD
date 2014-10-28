//
//  Input.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-28.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "Input.h"

@implementation Input

@synthesize finish,line,province,month,year;

- (id)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        for(NSString *key in [dict allKeys])
        {
            NSString *value = [dict objectForKey:key];
            if([value isKindOfClass:[NSNumber class]])
                value = [NSString stringWithFormat:@"%@",value];
            else if([value isKindOfClass:[NSNull class]])
                value = @"";
            @try {
                [self setValue:value forKey:key];
            }
            @catch (NSException *exception) {
                NSLog(@"试图添加不存在的key:%@到实例:%@中.",key,NSStringFromClass([Develop class]));
            }
        }
    }
    return self;
}

@end

//
//  MonthDevelopNumView.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-25.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "MonthDevelopNumView.h"

@implementation MonthDevelopNumView
@synthesize dayDevelopNumLabel;

#pragma mark - Public Methods
- (void)reloadData:(NSInteger )num
{
    [YFCommon animationPopToLabel:self.dayDevelopNumLabel withValue:num];
}

#pragma mark - UIView Methods
- (void)awakeFromNib
{
    [super awakeFromNib];
}

@end

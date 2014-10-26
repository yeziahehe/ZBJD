//
//  MonthDevelopNumView.h
//  ZBJD
//
//  Created by 叶帆 on 14-10-25.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthDevelopNumView : UIView
@property (strong, nonatomic) IBOutlet UILabel *dayDevelopNumLabel;

- (void)reloadData:(NSInteger )num;

@end

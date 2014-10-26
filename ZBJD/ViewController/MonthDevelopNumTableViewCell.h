//
//  MonthDevelopNumTableViewCell.h
//  ZBJD
//
//  Created by 叶帆 on 14-10-25.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MonthDevelopNumTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UIImageView *progressBarImageView;
@property (assign, nonatomic) float progressBarWidth;

- (void)loadProgressBarAnimation;

@end

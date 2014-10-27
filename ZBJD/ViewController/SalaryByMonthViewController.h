//
//  SalaryByMonthViewController.h
//  ZBJD
//
//  Created by 叶帆 on 14-10-27.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "BaseViewController.h"

@interface SalaryByMonthViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *judgeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *finishIcon;
@property (strong, nonatomic) IBOutlet UIImageView *allIcon;
@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong, nonatomic) IBOutlet UILabel *finishLabel;
@property (strong, nonatomic) IBOutlet UILabel *allLabel;
@property (strong, nonatomic) IBOutlet UILabel *bgLabel;
@property (strong, nonatomic) IBOutlet UIImageView *progressBarImageView;


@end

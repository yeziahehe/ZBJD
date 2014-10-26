//
//  HomeViewController.h
//  ZBJD
//
//  Created by 叶帆 on 14-10-24.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMenuViewController.h"

@interface HomeViewController : BaseMenuViewController
@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong, nonatomic) IBOutlet UIView *userDevelopNumView;
@property (strong, nonatomic) IBOutlet UIView *increaseSalaryView;
@property (strong, nonatomic) IBOutlet UIView *moreDataView;
@property (strong, nonatomic) IBOutlet UILabel *developNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *salaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *remainDevelopLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayDevelopLabel;
@property (strong, nonatomic) IBOutlet UILabel *monthCancelLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayCancelLabel;


@end

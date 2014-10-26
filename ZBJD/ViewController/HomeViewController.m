//
//  HomeViewController.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-24.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "HomeViewController.h"
#import "MoreViewController.h"
#import "MonthDevelopNumViewController.h"

@interface HomeViewController ()
@property (nonatomic, strong) NSArray *developArray;
@property (nonatomic, strong) NSArray *salaryArray;
@end

@implementation HomeViewController
@synthesize contentScrollView,userDevelopNumView,increaseSalaryView,moreDataView;
@synthesize developArray,salaryArray;
@synthesize developNumLabel,salaryLabel,remainDevelopLabel,dayDevelopLabel,monthCancelLabel,dayCancelLabel;

#pragma mark - UIView Init
- (UIView *)userDevelopNumView
{
    if (userDevelopNumView == nil) {
        userDevelopNumView = [[UIView alloc]init];
    }
    return userDevelopNumView;
}

- (UIView *)increaseSalaryView
{
    if (increaseSalaryView == nil) {
        increaseSalaryView = [[UIView alloc]init];
    }
    return increaseSalaryView;
}

- (UIView *)moreDataView
{
    if (moreDataView == nil) {
        moreDataView = [[UIView alloc]init];
    }
    return moreDataView;
}

#pragma mark - Private Methods
- (void)loadSubViews
{
    [self.contentScrollView setContentSize:CGSizeMake(self.contentScrollView.frame.size.width, self.moreDataView.frame.size.height + self.moreDataView.frame.origin.y)];
}

- (void)buttonClicked
{
    MonthDevelopNumViewController *mdnvc = [[MonthDevelopNumViewController alloc]initWithNibName:@"MonthDevelopNumViewController" bundle:nil];
    [self.navigationController pushViewController:mdnvc animated:YES];
}

#pragma mark - Notification Methods
- (void)developInfoInThisMonthbyDayNotification:(NSNotification *)notification
{
    self.developArray = [NSArray arrayWithArray:[DataManager sharedManager].developInfoInThisMonthByDay];
    NSInteger developNum = 0;
    NSInteger cancelNum = 0;
    NSInteger remainNum = 0;
    for (Develop *d in self.developArray) {
        developNum += [d.finish integerValue];
        cancelNum += [d.cancel integerValue];
        remainNum += [d.line integerValue];
    }
    [YFCommon animationPopToLabel:self.developNumLabel withValue:developNum];
    [YFCommon animationPopToLabel:self.remainDevelopLabel withValue:remainNum];
    [YFCommon animationPopToLabel:self.dayDevelopLabel withValue:developNum/self.developArray.count];
    [YFCommon animationPopToLabel:self.monthCancelLabel withValue:cancelNum];
    [YFCommon animationPopToLabel:self.dayCancelLabel withValue:cancelNum/self.developArray.count];
}

- (void)salaryInfoInThisMonthByProvinceNotification:(NSNotification *)notification
{
    self.salaryArray = [NSArray arrayWithArray:[DataManager sharedManager].salaryInfoInThisMonthByProvince];
    NSInteger salaryNum = 0;
    for (Salary *s in self.salaryArray) {
        salaryNum += [s.finish integerValue];
    }
    [YFCommon animationPopToLabel:self.salaryLabel withValue:salaryNum];
}

#pragma mark - IBAction Methods
- (IBAction)userDevelopNumButtonClicked:(id)sender {
    [self buttonClicked];
}

- (IBAction)increaseSalaryButtonClicked:(id)sender {
    [self buttonClicked];
}

- (IBAction)remainingDevelopNumButtonClicked:(id)sender {
    [self buttonClicked];
}

- (IBAction)dayDevelopNumButtonClicked:(id)sender {
    [self buttonClicked];
}

- (IBAction)monthCancelNumButtonClicked:(id)sender {
    [self buttonClicked];
}

- (IBAction)dayCancelNumButtonClicked:(id)sender {
    [self buttonClicked];
}

#pragma mark - BaseViewController Methods
- (void)leftItemTapped
{
    [[DataManager sharedManager] requestForDevelopInfoInThisMonthByDay];
    [[DataManager sharedManager] requestForSalaryInfoInThisMonthByProvince];
}

- (void)rightItemTapped
{
    MoreViewController *moreViewController = [[MoreViewController alloc]initWithNibName:@"MoreViewController" bundle:nil];
    [self.navigationController pushViewController:moreViewController animated:YES];
}

#pragma mark - UIViewController Methods
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNaviTitle:@"电子黄页项目组"];
    [self loadSubViews];
    
    [[DataManager sharedManager] requestForDevelopInfoInThisMonthByDay];
    [[DataManager sharedManager] requestForSalaryInfoInThisMonthByProvince];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(developInfoInThisMonthbyDayNotification:) name:kDevelopInfoInThisMonthbyDayNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(salaryInfoInThisMonthByProvinceNotification:) name:kSalaryInfoInThisMonthByProvinceNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MonthDevelopNumViewController.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-25.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "MonthDevelopNumViewController.h"
#import "MonthDevelopNumView.h"
#import "MonthDevelopNumTableViewCell.h"

@interface MonthDevelopNumViewController ()
@property (nonatomic, strong)MonthDevelopNumView *monthDevelopNumView;
@property (nonatomic, strong)NSArray *developArray;
@property (nonatomic, assign)float maxNum;
@end

@implementation MonthDevelopNumViewController
@synthesize monthDevelopNumTableView,monthDevelopNumView;
@synthesize developArray,maxNum;

#pragma mark - Init Methods
- (MonthDevelopNumView *)monthDevelopNumView
{
    if (nil == monthDevelopNumView) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"MonthDevelopNumView" owner:self options:nil];
        monthDevelopNumView = [nibs lastObject];
    }
    return monthDevelopNumView;
}

#pragma mark - Notification Methods
- (void)developInfoInRecentMonthByDayNotification:(NSNotification *)notificaiton
{
    self.developArray = [DataManager sharedManager].developInfoInRecentMonthByDay;
    NSInteger dayDevelopNum = 0;
    self.maxNum = 0;
    for (Develop *d in self.developArray) {
        dayDevelopNum += [d.finish integerValue];
        if ([d.finish floatValue] > self.maxNum) {
            self.maxNum = [d.finish floatValue];
        }
    }
    [self.monthDevelopNumView reloadData:dayDevelopNum/self.developArray.count];
    [self.monthDevelopNumTableView reloadData];
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
    [self setTitle:@"日均发展量"];
    self.monthDevelopNumTableView.separatorStyle = NO;
    self.monthDevelopNumTableView.tableHeaderView = self.monthDevelopNumView;
    [[DataManager sharedManager] requestForDevelopInfoInRecentMonthByDay];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(developInfoInRecentMonthByDayNotification:) name:kDevelopInfoInRecentMonthByDayNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.developArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentity = @"MonthDevelopNumTableViewCell";
    MonthDevelopNumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (nil == cell)
    {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"MonthDevelopNumTableViewCell" owner:self options:nil];
        cell = [nibs lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"MonthDevelopNumTableViewCell" owner:self options:nil];
    cell = [nibs lastObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Develop *d = [self.developArray objectAtIndex:indexPath.row];
    cell.dataLabel.text = [NSString stringWithFormat:@"  %@     %@",d.developDate,d.finish];
    cell.progressBarWidth = [d.finish floatValue]/self.maxNum * cell.dataLabel.frame.size.width;
    [cell loadProgressBarAnimation];
    
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end

//
//  SalaryByProvinceViewController.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-27.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "SalaryByProvinceViewController.h"
#import "PNPieChart.h"

@interface SalaryByProvinceViewController ()
@property (nonatomic, strong) NSArray *salaryArray;
@end

@implementation SalaryByProvinceViewController
@synthesize titleLabel,judgeLabel,salaryArray;

#pragma mark - Private Methods
- (void)initLabel
{
    NSDateFormatter *dateDayformate=[[NSDateFormatter alloc]init];
    [dateDayformate setDateFormat:@"dd"];
    NSString *date_Day = [dateDayformate stringFromDate:[NSDate date]];
    NSDateFormatter *dateMonthformate=[[NSDateFormatter alloc]init];
    [dateMonthformate setDateFormat:@"MM"];
    NSString *date_Month = [dateMonthformate stringFromDate:[NSDate date]];
    if ([date_Day isEqualToString:@"1"] || [date_Day isEqualToString:@"2"]) {
        self.judgeLabel.hidden = NO;
        self.titleLabel.text = [NSString stringWithFormat:@"%d月份各省净增收入",[date_Month intValue]-1];
        //做一次请求上月数据
        //to do
    } else {
        self.judgeLabel.hidden = YES;
        self.titleLabel.text = [NSString stringWithFormat:@"%@月份各省净增收入",date_Month];
        //使用已经加载好的本月数据
        self.salaryArray = [DataManager sharedManager].salaryInfoInThisMonthByProvince;
        [self loadSubViewWithData];
    }
}

- (void)loadSubViewWithData
{
    NSMutableArray *items = [NSMutableArray array];
    CGFloat g = 56.f;
    BOOL flag = NO;
    for (Salary *s in self.salaryArray) {
        if ([s.finish floatValue] >= 0) {
            [items addObject:[PNPieChartDataItem dataItemWithValue:[s.finish floatValue] color:[UIColor colorWithRed:255.f/255.f green:g/255.f blue:0.f/255.f alpha:1.0f] description:s.province]];
            g += 10.f;
        } else {
            [items addObject:[PNPieChartDataItem dataItemWithValue:-[s.finish floatValue] color:TextLightGray description:s.province]];
            flag = YES;
        }
    }
    
    PNPieChart *pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(40.f, self.judgeLabel.frame.origin.y + 40, ScreenWidth - 80.f, ScreenWidth - 80.f) items:items];
    pieChart.descriptionTextColor = [UIColor whiteColor];
    pieChart.descriptionTextFont  = [UIFont fontWithName:@"Avenir-Medium" size:10.0];
    pieChart.descriptionTextShadowColor = [UIColor clearColor];
    [pieChart strokeChart];
    
    [self.view addSubview:pieChart];
    
    if (flag) {
        UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(40.f, pieChart.frame.size.height + pieChart.frame.origin.y + 40, ScreenWidth - 40.f, 20.f)];
        tipLabel.text = @"表示该省份净增收入为负值";
        tipLabel.font = [UIFont systemFontOfSize:12.f];
        tipLabel.textColor = TextLightGray;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25.f, pieChart.frame.size.height + pieChart.frame.origin.y + 5.f + 40.f, 10.f, 10.f)];
        imageView.image = [YFCommon imageFromColor:TextLightGray];
        [self.view addSubview:tipLabel];
        [self.view addSubview:imageView];
    }
}

#pragma mark - UIViewControllerView Methods
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
    [self setTitle:@"净增收入详情"];
    [self initLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  SalaryByMonthViewController.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-27.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

/**
 Ye Fan 对PNBarChart进行了高度定制，若要使用请移步https://github.com/kevinzhow/PNChart
 */
#import "SalaryByMonthViewController.h"
#import "PNBarChart.h"

@interface SalaryByMonthViewController ()
@property (nonatomic, strong)NSArray *salaryArray;
@property (nonatomic, assign)NSInteger finishNum;
@end

@implementation SalaryByMonthViewController
@synthesize contentScrollView;
@synthesize titleLabel,judgeLabel,salaryArray;
@synthesize finishIcon,allIcon;
@synthesize finishLabel,allLabel,bgLabel,progressBarImageView,percentageLabel;

#pragma mark - Private Methods
- (void)initLabel
{
    self.finishIcon.image = [YFCommon imageFromColor:LightRed];
    self.allIcon.image = [YFCommon imageFromColor:LightGrey];
    NSDateFormatter *dateDayformate=[[NSDateFormatter alloc]init];
    [dateDayformate setDateFormat:@"dd"];
    NSString *date_Day = [dateDayformate stringFromDate:[NSDate date]];
    NSDateFormatter *dateMonthformate=[[NSDateFormatter alloc]init];
    [dateMonthformate setDateFormat:@"MM"];
    NSString *date_Month = [dateMonthformate stringFromDate:[NSDate date]];
    if ([date_Day isEqualToString:@"01"] || [date_Day isEqualToString:@"02"]) {
        self.judgeLabel.hidden = NO;
        self.titleLabel.text = [NSString stringWithFormat:@"%d月份各省净增收入",[date_Month intValue]-1];
        //做一次请求上月数据
        [[DataManager sharedManager]requestForSalaryInfoInLastMonthByProvince];
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
    BOOL flag = NO;
    self.finishNum = 0;
    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *yArray = [NSMutableArray array];
    NSMutableArray *cArray = [NSMutableArray array];
    for (Salary *s in self.salaryArray) {
        [xArray addObject:s.province];
        if ([s.finish intValue] < 0) {
            [yArray addObject:[NSNumber numberWithInt:-[s.finish intValue]]];
            [cArray addObject:TextLightGray];
            flag = YES;
        } else {
            [yArray addObject:[NSNumber numberWithInt:[s.finish intValue]]];
            [cArray addObject:LightRed];
        }
        self.finishNum += [s.finish floatValue];
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    self.finishLabel.text = [NSString stringWithFormat:@"%@元", [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.finishNum]]];
    self.percentageLabel.text = [NSString stringWithFormat:@"%1.1f%%",(double)self.finishNum/200000.0*100];
    UIImage *progressImage = [UIImage imageNamed:@"bg_dot_red.png"];
    progressImage = [progressImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, progressImage.size.width/2-1, 0, progressImage.size.width/2)];
    self.progressBarImageView.image = progressImage;
    self.progressBarImageView.frame = CGRectMake(20.f, 376.f, 0.f, 34.f);
    CGFloat progressBarWidth = self.finishNum/200000.0f * self.bgLabel.frame.size.width;
    [UIView animateWithDuration:0.8f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect progressFrame = self.progressBarImageView.frame;
        progressFrame.size.width = progressBarWidth;
        self.progressBarImageView.frame = progressFrame;
    } completion:nil];
    
    CGFloat width = 0.f;
    if (xArray.count < 5) {
        width = ScreenWidth - 30;
    } else {
        width = ScreenWidth/5 * xArray.count;
    }
    PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0.f, self.judgeLabel.frame.origin.y + 40, width, 220.f)];
    barChart.backgroundColor = [UIColor clearColor];
    barChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
        return labelText;
    };
    barChart.labelMarginTop = 5.0;
    barChart.xLabels = xArray;
    barChart.yValues = yArray;
    barChart.strokeColors = cArray;
    barChart.yLabelSum = 0;
    [barChart strokeChart];
    [self.contentScrollView addSubview:barChart];
    
    if (flag) {
        UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(40.f, barChart.frame.size.height + barChart.frame.origin.y, ScreenWidth - 40.f, 20.f)];
        tipLabel.text = @"表示该省份净增收入为负值";
        tipLabel.font = [UIFont systemFontOfSize:12.f];
        tipLabel.textColor = TextLightGray;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25.f, barChart.frame.size.height + barChart.frame.origin.y + 5.f, 10.f, 10.f)];
        imageView.image = [YFCommon imageFromColor:TextLightGray];
        [self.contentScrollView addSubview:tipLabel];
        [self.contentScrollView addSubview:imageView];
    }
    [self.contentScrollView setContentSize:CGSizeMake(ScreenWidth, self.finishLabel.frame.size.height + self.finishLabel.frame.origin.y + 20)];
}

#pragma mark - Notificaiton Methods
- (void)salaryInfoInLastMonthByProvinceNotification:(NSNotification *)notification
{
    self.salaryArray = [DataManager sharedManager].salaryInfoInLastMonthByProvince;
    [self loadSubViewWithData];
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
    [self setTitle:@"净增收入详情"];
    [self initLabel];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(salaryInfoInLastMonthByProvinceNotification:) name:kSalaryInfoInLastMonthByProvinceNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

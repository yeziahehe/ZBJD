//
//  InputInfoViewController.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-26.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

/**
 Ye Fan 对PNBarChart进行了高度定制，若要使用请移步https://github.com/kevinzhow/PNChart
 */
#import "InputInfoViewController.h"
#import "PNBarChart.h"

@interface InputInfoViewController ()
@property (nonatomic, strong) NSArray *inputArray;
@property (nonatomic, assign) NSInteger finishNum;
@property (nonatomic, assign) NSInteger allNum;
@end

@implementation InputInfoViewController
@synthesize contentScrollView;
@synthesize titleLabel,inputArray;
@synthesize finishIcon,allIcon;
@synthesize finishLabel,allLabel,bgLabel,progressBarImageView,percentageLabel;

#pragma mark - Private Methods
- (void)initLabel
{
    self.finishIcon.image = [YFCommon imageFromColor:LightRed];
    self.allIcon.image = [YFCommon imageFromColor:LightGrey];
    NSDateFormatter *dateMonthformate=[[NSDateFormatter alloc]init];
    [dateMonthformate setDateFormat:@"MM"];
    NSString *date_Month = [dateMonthformate stringFromDate:[NSDate date]];

    self.titleLabel.text = [NSString stringWithFormat:@"%@月份各省录单情况跟踪",date_Month];
    [[DataManager sharedManager]requestForInputInfoInThisMonthByProvince];
    
}

- (void)loadSubViewWithData
{
    self.finishNum = 0;
    self.allNum = 0;
    NSMutableArray *xArray = [NSMutableArray array];
    NSMutableArray *yArray = [NSMutableArray array];
    NSMutableArray *lArray = [NSMutableArray array];
    NSMutableArray *cArray = [NSMutableArray array];
    for (Input *i in self.inputArray) {
        [xArray addObject:i.province];
        [lArray addObject:i.line];
        if ([i.finish intValue] < 0) {
            [yArray addObject:[NSNumber numberWithInt:-[i.finish intValue]]];
            [cArray addObject:TextLightGray];
        } else {
            [yArray addObject:[NSNumber numberWithInt:[i.finish intValue]]];
            [cArray addObject:LightRed];
        }
        self.finishNum += [i.finish floatValue];
        self.allNum += [i.line floatValue];
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    self.finishLabel.text = [NSString stringWithFormat:@"%@个", [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.finishNum]]];
    self.allLabel.text = [NSString stringWithFormat:@"%@个", [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.allNum]]];
    self.percentageLabel.text = [NSString stringWithFormat:@"%1.1f%%",(double)self.finishNum/(double)self.allNum*100];
    UIImage *progressImage = [UIImage imageNamed:@"bg_dot_red.png"];
    progressImage = [progressImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, progressImage.size.width/2-1, 0, progressImage.size.width/2)];
    self.progressBarImageView.image = progressImage;
    self.progressBarImageView.frame = CGRectMake(20.f, 376.f, 0.f, 34.f);
    CGFloat progressBarWidth = (double)self.finishNum/(double)self.allNum * self.bgLabel.frame.size.width;
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
    PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0.f, self.titleLabel.frame.origin.y + 83.f, width, 220.f)];
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
    barChart.showLine = YES;
    barChart.lineValues = lArray;
    [barChart strokeChart];
    [self.contentScrollView addSubview:barChart];
    
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(40.f, barChart.frame.size.height + barChart.frame.origin.y, ScreenWidth - 40.f, 20.f)];
    tipLabel.text = @"表示该省份本月总指标";
    tipLabel.font = [UIFont systemFontOfSize:12.f];
    tipLabel.textColor = TextLightGray;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(25.f, barChart.frame.size.height + barChart.frame.origin.y + 6.f, 8.f, 8.f)];
    imageView.image = [UIImage imageNamed:@"linePoint"];
    [self.contentScrollView addSubview:tipLabel];
    [self.contentScrollView addSubview:imageView];
    
    [self.contentScrollView setContentSize:CGSizeMake(ScreenWidth, self.finishLabel.frame.size.height + self.finishLabel.frame.origin.y + 20)];
}

#pragma mark - Notification Methods
- (void)inputInfoThisMotnByProvinceNotification:(NSNotification *)notification
{
    self.inputArray = [DataManager sharedManager].inputInfoThisMotnByProvince;
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
    [self setNaviTitle:@"当月各省录单情况跟踪"];
    [self initLabel];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(inputInfoThisMotnByProvinceNotification:) name:kInputInfoThisMotnByProvinceNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MoreViewController.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-25.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "MoreViewController.h"
#import "InputInfoViewController.h"
#import "SalaryByMonthViewController.h"
#import "SalaryByProvinceViewController.h"
#import "DevelopByMonthViewController.h"
#import "DevelopByProvinceViewController.h"

@interface MoreViewController ()
@property (nonatomic, strong) NSArray *targetInfoArray;
@end

@implementation MoreViewController
@synthesize targetInfoTableView,targetInfoArray;

#pragma mark - Private Methods
- (void)loadFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:kTargetInfoMapFileName ofType:@"plist"];
    self.targetInfoArray = [NSMutableArray arrayWithContentsOfFile:path];
    [self.targetInfoTableView reloadData];
}

#pragma mark - UIViewContrller Methods
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
    [self setNaviTitle:@"更多指标进度"];
    [self loadFile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.targetInfoArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dict = [self.targetInfoArray objectAtIndex:section];
    return ((NSArray *)[dict objectForKey:@"detail"]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TargetInfoTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    NSDictionary *dict = [self.targetInfoArray objectAtIndex:indexPath.section];
    cell.textLabel.text = [[dict objectForKey:@"detail"]objectAtIndex:indexPath.row];
    cell.textLabel.textColor = TextBlack;
    
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30.f)];
    NSDictionary *dict = [self.targetInfoArray objectAtIndex:section];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.f, 0, 200.f, 30.f)];
    label.font = [UIFont systemFontOfSize:12.f];
    label.textColor = TextLightGray;
    label.backgroundColor = [UIColor clearColor];
    label.text = [dict objectForKey:@"title"];
    [sectionView addSubview:label];
    return sectionView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            if (indexPath.row == 0) {
                SalaryByMonthViewController *sbmvc = [[SalaryByMonthViewController alloc]initWithNibName:@"SalaryByMonthViewController" bundle:nil];
                [self.navigationController pushViewController:sbmvc animated:YES];
            }
            else if (indexPath.row == 1) {
                SalaryByProvinceViewController *sbpvc = [[SalaryByProvinceViewController alloc]initWithNibName:@"SalaryByProvinceViewController" bundle:nil];
                [self.navigationController pushViewController:sbpvc animated:YES];
            }
        }
            break;
            
        case 1:
        {
            if (indexPath.row == 0) {
                DevelopByMonthViewController *dbmvc = [[DevelopByMonthViewController alloc]initWithNibName:@"DevelopByMonthViewController" bundle:nil];
                [self.navigationController pushViewController:dbmvc animated:YES];
            }
            else if (indexPath.row == 1) {
                DevelopByProvinceViewController *dbpvc = [[DevelopByProvinceViewController alloc]initWithNibName:@"DevelopByProvinceViewController" bundle:nil];
                [self.navigationController pushViewController:dbpvc animated:YES];
            }
        }
            break;
            
        case 2:
        {
            InputInfoViewController *iivc = [[InputInfoViewController alloc]initWithNibName:@"InputInfoViewController" bundle:nil];
            [self.navigationController pushViewController:iivc animated:YES];
        }
            
        default:
            break;
    }
}

@end

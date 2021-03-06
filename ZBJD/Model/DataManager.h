//
//  DataManager.h
//  ZBJD
//
//  Created by 叶帆 on 14-10-25.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Develop.h"
#import "Salary.h"
#import "Input.h"

#define kDevelopInfoInThisMonthByDayDownloaderKey       @"DevelopInfoInThisMonthByDayDownloaderKey"
#define kSalaryInfoInThisMonthByProvinceDownloaderKey   @"SalaryInfoInThisMonthByProvinceDownloaderKey"
#define kDevelopInfoInRecentMonthByDayDownloaderKey     @"DevelopInfoInRecentMonthByDayDownloaderKey"
#define kInputInfoThisMotnByProvinceDownloaderKey       @"InputInfoThisMotnByProvinceDownloaderKey"
#define kDevelopInfoInThisMonthByProvinceDownloaderKey  @"DevelopInfoInThisMonthByProvinceDownloaderKey"
#define kSalaryInfoInLastMonthByProvinceDownloaderKey       @"SalaryInfoInLastMonthByProvinceDownloaderKey"

@interface DataManager : NSObject<YFDownloaderDelegate>

@property (nonatomic, strong) NSMutableArray *developInfoInThisMonthByDay;
@property (nonatomic, strong) NSMutableArray *salaryInfoInThisMonthByProvince;
@property (nonatomic, strong) NSMutableArray *developInfoInRecentMonthByDay;
@property (nonatomic, strong) NSMutableArray *inputInfoThisMotnByProvince;
@property (nonatomic, strong) NSMutableArray *developInfoInThisMonthByProvince;
@property (nonatomic, strong) NSMutableArray *salaryInfoInLastMonthByProvince;

+ (DataManager *)sharedManager;

/**
 获取本月用户发展量
 @param flag  1表示按日期   0表示按省份
 @param index 1表示本月     0表示近一月
 */

/**
 按日期获取本月用户发展量
 */
- (void)requestForDevelopInfoInThisMonthByDay;

/**
 按省份获取本月的净增收入
 */
- (void)requestForSalaryInfoInThisMonthByProvince;

/**
 按日期获取近一月用户发展量
 */
- (void)requestForDevelopInfoInRecentMonthByDay;

/**
 按省份获取本月的录单情况
 */
- (void)requestForInputInfoInThisMonthByProvince;

/**
 按省份获取本月用户发展量
 */
- (void)requestForDevelopInfoInThisMonthByProvince;

/**
 按省份获取上月的录单情况
 */
- (void)requestForSalaryInfoInLastMonthByProvince;

@end

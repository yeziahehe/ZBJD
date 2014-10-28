//
//  DataManager.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-25.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager
@synthesize developInfoInThisMonthByDay,salaryInfoInThisMonthByProvince,developInfoInRecentMonthByDay,inputInfoThisMotnByProvince,developInfoInThisMonthByProvince;

#pragma mark - Public Methods
- (void)requestForDevelopInfoInThisMonthByDay
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kServerAddress,kDevelopThisMonthByDayUrl];
    [[YFDownloaderManager sharedManager]requestDataByGetWithURLString:url
                                                             delegate:self
                                                              purpose:kDevelopInfoInThisMonthByDayDownloaderKey];
}

- (void)requestForSalaryInfoInThisMonthByProvince
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kServerAddress,kSalaryThisMonthByProvinceUrl];
    [[YFDownloaderManager sharedManager]requestDataByGetWithURLString:url
                                                             delegate:self
                                                              purpose:kSalaryInfoInThisMonthByProvinceDownloaderKey];
}

- (void)requestForDevelopInfoInRecentMonthByDay
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kServerAddress,kRecentThisMonthByDayUrl];
    [[YFDownloaderManager sharedManager]requestDataByGetWithURLString:url
                                                             delegate:self
                                                              purpose:kDevelopInfoInRecentMonthByDayDownloaderKey];
}

- (void)requestForInputInfoInThisMonthByProvince
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kServerAddress,kInputThisMotnByProvinceUrl];
    [[YFDownloaderManager sharedManager]requestDataByGetWithURLString:url
                                                             delegate:self
                                                              purpose:kInputInfoThisMotnByProvinceDownloaderKey];
}

- (void)requestForDevelopInfoInThisMonthByProvince
{
    NSString *url = [NSString stringWithFormat:@"%@%@",kServerAddress,kkDevelopThisMonthByProvinceUrl];
    [[YFDownloaderManager sharedManager]requestDataByGetWithURLString:url
                                                             delegate:self
                                                              purpose:kDevelopInfoInThisMonthByProvinceDownloaderKey];
}

#pragma mark - Singleton Methods
+ (DataManager *)sharedManager
{
    static DataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });
    return manager;
}

- (void)dealloc
{
    [[YFDownloaderManager sharedManager] cancelDownloaderWithDelegate:self purpose:nil];
}

#pragma mark - YFDownloaderDelegate methods
- (void)downloader:(YFDownloader*)downloader completeWithNSData:(NSData*)data
{
    if ([downloader.purpose isEqualToString:kDevelopInfoInThisMonthByDayDownloaderKey]) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [str JSONValue];
        if (![[dict objectForKey:@"data"] isKindOfClass:[NSNull class]])
        {
            self.developInfoInThisMonthByDay = [[NSMutableArray alloc]init];
            NSArray *valueArray = (NSArray *)[dict objectForKey:@"data"];
            for(NSDictionary *valueDict in valueArray)
            {
                Develop *d = [[Develop alloc]initWithDict:valueDict];
                [self.developInfoInThisMonthByDay addObject:d];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kDevelopInfoInThisMonthbyDayNotification object:nil];
        }
        else
        {
            NSString *message = @"指标进度获取失败!";
            [[YFCommon sharedProgressHUD] showFailureViewWithMessage:message hideDelay:2.f];
        }
    }
    else if ([downloader.purpose isEqualToString:kSalaryInfoInThisMonthByProvinceDownloaderKey]) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [str JSONValue];
        if (![[dict objectForKey:@"data"] isKindOfClass:[NSNull class]])
        {
            self.salaryInfoInThisMonthByProvince = [[NSMutableArray alloc]init];
            NSArray *valueArray = (NSArray *)[dict objectForKey:@"data"];
            for(NSDictionary *valueDict in valueArray)
            {
                Salary *s = [[Salary alloc]initWithDict:valueDict];
                [self.salaryInfoInThisMonthByProvince addObject:s];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kSalaryInfoInThisMonthByProvinceNotification object:nil];
        }
        else
        {
            NSString *message = @"指标进度获取失败!";
            [[YFCommon sharedProgressHUD] showFailureViewWithMessage:message hideDelay:2.f];
        }
    }
    else if ([downloader.purpose isEqualToString:kDevelopInfoInRecentMonthByDayDownloaderKey]) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [str JSONValue];
        if (![[dict objectForKey:@"data"] isKindOfClass:[NSNull class]])
        {
            self.developInfoInRecentMonthByDay = [[NSMutableArray alloc]init];
            NSArray *valueArray = (NSArray *)[dict objectForKey:@"data"];
            for(NSDictionary *valueDict in valueArray)
            {
                Develop *d = [[Develop alloc]initWithDict:valueDict];
                [self.developInfoInRecentMonthByDay addObject:d];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kDevelopInfoInRecentMonthByDayNotification object:nil];
        }
        else
        {
            NSString *message = @"日均发展量获取失败!";
            [[YFCommon sharedProgressHUD] showFailureViewWithMessage:message hideDelay:2.f];
        }
    }
    else if ([downloader.purpose isEqualToString:kInputInfoThisMotnByProvinceDownloaderKey]) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [str JSONValue];
        if (![[dict objectForKey:@"data"] isKindOfClass:[NSNull class]])
        {
            self.inputInfoThisMotnByProvince = [[NSMutableArray alloc]init];
            NSArray *valueArray = (NSArray *)[dict objectForKey:@"data"];
            for(NSDictionary *valueDict in valueArray)
            {
                Input *i = [[Input alloc]initWithDict:valueDict];
                [self.inputInfoThisMotnByProvince addObject:i];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kInputInfoThisMotnByProvinceNotification object:nil];
        }
        else
        {
            NSString *message = @"各省录单情况获取失败!";
            [[YFCommon sharedProgressHUD] showFailureViewWithMessage:message hideDelay:2.f];
        }
    }
    else if ([downloader.purpose isEqualToString:kDevelopInfoInThisMonthByProvinceDownloaderKey]) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict = [str JSONValue];
        if (![[dict objectForKey:@"data"] isKindOfClass:[NSNull class]])
        {
            self.developInfoInThisMonthByProvince = [[NSMutableArray alloc]init];
            NSArray *valueArray = (NSArray *)[dict objectForKey:@"data"];
            for(NSDictionary *valueDict in valueArray)
            {
                Develop *d = [[Develop alloc]initWithDict:valueDict];
                [self.developInfoInThisMonthByProvince addObject:d];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kDevelopInfoInThisMonthByProvinceNotification object:nil];
        }
        else
        {
            NSString *message = @"各省发展量获取失败!";
            [[YFCommon sharedProgressHUD] showFailureViewWithMessage:message hideDelay:2.f];
        }
    }
}

- (void)downloader:(YFDownloader *)downloader didFinishWithError:(NSString *)message
{
    NSLog(@"%@",message);//to delete
    [[YFCommon sharedProgressHUD] showFailureViewWithMessage:kNetWorkErrorString hideDelay:2.f];
}

@end

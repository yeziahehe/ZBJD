//
//  Constant.h
//  ZBJD
//
//  Created by 叶帆 on 14-10-24.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#ifndef ZBJD_Constant_h
#define ZBJD_Constant_h

//Constant Values
#define IsIos8              [[UIDevice currentDevice].systemVersion floatValue]>=8.0?YES:NO
#define IsDevicePhone5      [UIScreen mainScreen].bounds.size.height==568.f?YES:NO
#define IsDevicePhone6      [UIScreen mainScreen].bounds.size.height==667.f?YES:NO
#define IsDevicePhone6P     [UIScreen mainScreen].bounds.size.height==736.f?YES:NO
#define ScreenWidth         [UIScreen mainScreen].bounds.size.width
#define ScreenHeight        [UIScreen mainScreen].bounds.size.height
#define kMainProjColor      [UIColor colorWithRed:34.f/255 green:38.f/255 blue:53.f/255 alpha:0.8f]
#define kNetWorkErrorString @"网络错误"

//Notification Values
#define kDevelopInfoInThisMonthbyDayNotification        @"DevelopInfoInThisMonthbyDayNotification"
#define kSalaryInfoInThisMonthByProvinceNotification    @"SalaryInfoInThisMonthByProvinceNotification"
#define kDevelopInfoInRecentMonthByDayNotification      @"DevelopInfoInRecentMonthByDayNotification"
#define kInputInfoThisMotnByProvinceNotification        @"InputInfoThisMotnByProvinceNotification"

//Url Values
#define kServerAddress              @"http://m.10001.name:9080/flow-log-worker/flowlog?"
#define kDevelopThisMonthByDayUrl      @"cmd=develop.develop.info.target&flag=1&index=1"
#define kSalaryThisMonthByProvinceUrl  @"cmd=develop.collection.payment.target"
#define kRecentThisMonthByDayUrl       @"cmd=develop.develop.info.target&flag=1&index=0"
#define kInputThisMotnByProvinceUrl     @"cmd=develop.input.info.target"

#endif
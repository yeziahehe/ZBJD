//
//  YFCommon.h
//  ZBJD
//
//  Created by 叶帆 on 14-10-25.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 yefan为每一个项目定制的常用库
 */

#define HUD_IMAGE_SUCCESS      [UIImage imageNamed:@"YFProgressHUD.bundle/success.png"]
#define HUD_IMAGE_ERROR        [UIImage imageNamed:@"YFProgressHUD.bundle/error.png"]

#define TextBlack       [UIColor colorWithRed:30.f/255.f green:30.f/255.f blue:30.f/255.f alpha:1.0]
#define TextLightGray   [UIColor colorWithRed:175.f/255.f green:175.f/255.f blue:175.f/255.f alpha:1.0f]
#define LightRed        [UIColor colorWithRed:255.f/255.f green:56.f/255.f blue:0.f/255.f alpha:1.0f]
#define LightGrey       [UIColor colorWithRed:225.f/255.f green:225.f/255.f blue:225.f/255.f alpha:1.0f]

@interface YFCommon : NSObject

+ (YFCommon *)sharedProgressHUD;
/**
 为UILabel加上数字累加动画
 @param label UILabel
 @param value endValue
 */
+ (void)animationPopToLabel:(UILabel *)label withValue:(NSInteger)value;

/**
 网络请求成功和失败的提示
 */
- (void)showSuccessViewWithMessage:(NSString *)startMessage hideDelay:(CGFloat)delay;
- (void)showFailureViewWithMessage:(NSString *)startMessage hideDelay:(CGFloat)delay;

/**
 将UIColor转变为UIImage
 @param color UIColor
 @return UIImage
 */
+ (UIImage *)imageFromColor:(UIColor *)color;

+ (NSDate *) startOfLastMonth;
+ (NSDate *) endOfLastMonth;

@end

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

@end

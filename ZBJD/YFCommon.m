//
//  YFCommon.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-25.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "YFCommon.h"
#import "POP.h"

@interface YFCommon ()
@property(nonatomic, strong)MBProgressHUD *hud;
@end

@implementation YFCommon
@synthesize hud;

#pragma mark - Init Methods
- (id)init
{
    if(self = [super init])
    {
        UIWindow *hudWindow = [[UIApplication sharedApplication].windows objectAtIndex:0];
        hud = [[MBProgressHUD alloc] initWithWindow:hudWindow];
        [hudWindow addSubview:hud];
        hud.userInteractionEnabled = NO;
    }
    return self;
}

+ (YFCommon *)sharedProgressHUD
{
    static YFCommon *_progressHUD = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _progressHUD = [[YFCommon alloc] init];
    });
    return _progressHUD;
}

+ (void)animationPopToLabel:(UILabel *)label withValue:(NSInteger)value
{
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    animation.property = [POPMutableAnimatableProperty
                          propertyWithName:@"com.curer.test"
                          initializer:^(POPMutableAnimatableProperty *prop) {
                              prop.writeBlock = ^(id obj, const CGFloat values[]) {
                                  UILabel *label = (UILabel *)obj;
                                  NSNumber *number = @(values[0]);
                                  NSInteger num = [number integerValue];
                                  label.text = [@(num) stringValue];
                                  if ([number integerValue] == value) {
                                      NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
                                      [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
                                      label.text = [numberFormatter stringFromNumber:number];
                                  }
                              };
                          }];;
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.12 :1: 0.11:0.94];
    animation.fromValue = @(0);
    animation.toValue = @(value);
    animation.duration = 0.8f;
    
    [label pop_addAnimation:animation forKey:@"numberLabelAnimation"];
}

#pragma mark - Public methods
- (void)showWithMessage:(NSString *)message customView:(UIView *)customView hideDelay:(CGFloat)delay
{
    if(nil == message || [message isEqualToString:@""])
    {
        NSLog(@"YFProgressHUD显示空信息.");
        [hud hide:YES];
        return;
    }
    UIWindow *hudWindow = (UIWindow *)hud.superview;
    [hudWindow bringSubviewToFront:hud];
    hud.userInteractionEnabled = NO;
    UIView *cv = [[UIView alloc] init];
    cv.backgroundColor = [UIColor clearColor];
    if(!customView)
        hud.customView = cv;
    else
        hud.customView = customView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = message;
    [NSObject cancelPreviousPerformRequestsWithTarget:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
}

- (void)showSuccessViewWithMessage:(NSString *)startMessage hideDelay:(CGFloat)delay
{
    [self showWithMessage:startMessage customView:[[UIImageView alloc]initWithImage:HUD_IMAGE_SUCCESS] hideDelay:delay];
}

- (void)showFailureViewWithMessage:(NSString *)startMessage hideDelay:(CGFloat)delay
{
    [self showWithMessage:startMessage customView:[[UIImageView alloc]initWithImage:HUD_IMAGE_ERROR] hideDelay:delay];
}

@end

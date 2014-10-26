//
//  YFCommon.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-25.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "YFCommon.h"
#import "POP.h"

@implementation YFCommon

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

@end

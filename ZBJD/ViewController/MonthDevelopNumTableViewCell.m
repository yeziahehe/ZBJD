//
//  MonthDevelopNumTableViewCell.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-25.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "MonthDevelopNumTableViewCell.h"

@implementation MonthDevelopNumTableViewCell
@synthesize dataLabel,progressBarImageView,progressBarWidth;

- (void)loadProgressBarAnimation
{
    [UIView animateWithDuration:0.8f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect progressFrame = self.progressBarImageView.frame;
        progressFrame.size.width = progressBarWidth;
        self.progressBarImageView.frame = progressFrame;
    } completion:nil];
}

- (void)awakeFromNib
{
    // Initialization code
    UIImage *progressImage = [UIImage imageNamed:@"bg_dot.png"];
    progressImage = [progressImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, progressImage.size.width/2-1, 0, progressImage.size.width/2)];
    self.progressBarImageView.image = progressImage;
    self.progressBarImageView.frame = CGRectMake(0.f, 0.f, 0.f, 34.f);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

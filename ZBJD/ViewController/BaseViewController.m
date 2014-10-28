//
//  BaseViewController.m
//  RootDirectory
//
//  Created by 叶帆 on 14-9-2.
//  Copyright (c) 2014年 yefan. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - BaseViewController methods
- (void)leftItemTapped
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemTapped
{}

- (void)setLeftItemEnable:(BOOL)enable
{
    self.navigationItem.leftBarButtonItem.enabled = enable;
}

- (void)setRightItemEnable:(BOOL)enable
{
    self.navigationItem.rightBarButtonItem.enabled = enable;
}

- (void)setLeftNaviItemWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    if(imageName)
    {
        UIImage *leftImage = [UIImage imageNamed:imageName];
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftButton setImage:leftImage forState:UIControlStateNormal];
        leftButton.frame = CGRectMake(0, 0, leftImage.size.width, leftImage.size.height);
        [leftButton addTarget:self action:@selector(leftItemTapped) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.leftBarButtonItem = leftItem;
        return;
    }
    if(title)
    {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftItemTapped)];
        self.navigationItem.leftBarButtonItem = leftItem;
        return;
    }
}

- (void)setRightNaviItemWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    if(imageName)
    {
        UIImage *rightImage = [UIImage imageNamed:imageName];
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightButton setImage:rightImage forState:UIControlStateNormal];
        rightButton.frame = CGRectMake(0, 0, rightImage.size.width, rightImage.size.height);
        [rightButton addTarget:self action:@selector(rightItemTapped) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = rightItem;
        return;
    }
    if(title)
    {
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rightItemTapped)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)setNaviTitle:(NSString *)title
{
    self.navigationItem.title = title;
}

- (void)setNaviImageTitle:(NSString *)imageName
{
}

#pragma mark - UIViewController methods

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setLeftNaviItemWithTitle:nil imageName:@"icon_header_back_blur.png"];
}
@end

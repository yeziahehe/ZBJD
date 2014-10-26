//
//  InputInfoViewController.m
//  ZBJD
//
//  Created by 叶帆 on 14-10-26.
//  Copyright (c) 2014年 Ye Fan. All rights reserved.
//

#import "InputInfoViewController.h"

@interface InputInfoViewController ()

@end

@implementation InputInfoViewController

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
    [self setNaviTitle:@"当月各省录单情况跟踪"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

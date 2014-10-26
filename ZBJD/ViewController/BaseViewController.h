//
//  BaseViewController.h
//  RootDirectory
//
//  Created by 叶帆 on 14-9-2.
//  Copyright (c) 2014年 yefan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)leftItemTapped;
- (void)rightItemTapped;
/**
 设置基类的NavigationBar的leftItem/rightItem, item的title和image不可同时为nil。
 当title存在的时候用title设置，title不存在的时候用image设置
 @param title leftItem的title
 @param imageName leftItem的imageName
 */
- (void)setLeftNaviItemWithTitle:(NSString *)title imageName:(NSString *)imageName;
- (void)setRightNaviItemWithTitle:(NSString *)title imageName:(NSString *)imageName;

/**
 设置NavigationBar的title
 @param title 需要设置的title
 */
- (void)setNaviTitle:(NSString *)title;

- (void)setNaviImageTitle:(NSString *)imageName;


@end

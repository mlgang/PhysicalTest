//
//  ToolObjc.m
//  PhysicalTest
//
//  Created by jay on 2019/3/27.
//  Copyright © 2019 jay. All rights reserved.
//

#import "ToolObjc.h"
#import "MeView.h"
#import "SubmitView.h"
#import "MainViewController.h"
#import "ViewController.h"


@implementation ToolObjc

+ (void)gotoMainViewControllerWithUser:(UserModel *)user{
    MainViewController *oneVC = [[MainViewController alloc] init];
    oneVC.user = user;
    oneVC.title = @"成绩";
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:oneVC];
    [mainNav.tabBarItem setImage:[[UIImage imageNamed:@"selectShouye"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [mainNav.tabBarItem setSelectedImage:[[UIImage imageNamed:@"shouye"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    SubmitView *twoVC = [[SubmitView alloc] init];
    twoVC.title = @"测评";
    UINavigationController *subNav = [[UINavigationController alloc] initWithRootViewController:twoVC];
    [subNav.tabBarItem setImage:[[UIImage imageNamed:@"selectCeshi-"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [subNav.tabBarItem setSelectedImage:[[UIImage imageNamed:@"ceshi-"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    MeView *threeVC = [[MeView alloc] init];
    threeVC.title = @"我的";
    UINavigationController *meNav = [[UINavigationController alloc] initWithRootViewController:threeVC];
    [meNav.tabBarItem setImage:[[UIImage imageNamed:@"me"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [meNav.tabBarItem setSelectedImage:[[UIImage imageNamed:@"selectMe"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    UITabBarController *tabbarCon = [[UITabBarController alloc] init];
    tabbarCon.viewControllers = @[mainNav,subNav,meNav];
    
    [[[UIApplication sharedApplication] delegate] window].rootViewController = tabbarCon;
}
+ (void)gotoLoginViewControlelr{
    ViewController *vc = [[ViewController alloc] init];
    
    [[[UIApplication sharedApplication] delegate] window].rootViewController = vc;
}
@end

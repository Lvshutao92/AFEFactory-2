//
//  MainTabbarViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/17.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "PageHomeViewController.h"
#import "ThreeViewController.h"
@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController
- (instancetype)init {
    if (self = [super init]) {
        PageHomeViewController *oneVc = [[PageHomeViewController alloc]init];
        MainNavigationViewController *mainoneVC = [[MainNavigationViewController alloc]initWithRootViewController:oneVc];
        mainoneVC.title = @"主页";
        oneVc.navigationItem.title = @"迪锐克斯";
        mainoneVC.tabBarItem.image = [UIImage imageNamed:@"sy"];
        mainoneVC.tabBarItem.selectedImage = [UIImage imageNamed:@"sy1"];
        
        
        
        ThreeViewController *threeVc = [[ThreeViewController alloc]init];
        MainNavigationViewController *mainthreeVC = [[MainNavigationViewController alloc]initWithRootViewController:threeVc];
        threeVc.title = @"公告";
        mainthreeVC.tabBarItem.image = [UIImage imageNamed:@"notice"];
        mainthreeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"notice1"];

        self.tabBar.tintColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
        self.viewControllers = @[mainoneVC,mainthreeVC];
    }
    return self;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end

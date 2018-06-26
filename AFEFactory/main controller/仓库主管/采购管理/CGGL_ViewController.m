//
//  CGGL_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/23.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CGGL_ViewController.h"
#import "CKZG_cgjh_ViewController.h"
#import "CKZG_qbcgd_ViewController.h"
#import "CKZG_plcgd_ViewController.h"
#import "CKZG_xhcgd_ViewController.h"
#import "CKZG_shcgd_ViewController.h"

#import "XHKCL_search_ViewController.h"

#import "CKZG_CGD_search_ViewController.h"

@interface CGGL_ViewController ()<SGTopScrollMenuDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) SGTopScrollMenu *topScrollMenu;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation CGGL_ViewController


- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"采购管理";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    self.titles = @[@"采购计划",@"全部采购单", @"批量采购单",@"现货采购单",@"售后采购单"];
    self.topScrollMenu = [SGTopScrollMenu topScrollMenuWithFrame:CGRectMake(0, height, self.view.frame.size.width, 44)];
    _topScrollMenu.titlesArr = [NSArray arrayWithArray:_titles];
    _topScrollMenu.topScrollMenuDelegate = self;
    [self.view addSubview:_topScrollMenu];
    
    // 创建底部滚动视图
    self.mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _mainScrollView.contentSize = CGSizeMake(self.view.frame.size.width * _titles.count, 0);
    _mainScrollView.backgroundColor = [UIColor clearColor];
    //开启分页
    _mainScrollView.pagingEnabled = YES;
    //没有弹簧效果
    _mainScrollView.bounces = NO;
    //隐藏水平滚动条
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    //设置代理
    _mainScrollView.delegate = self;
    
    _mainScrollView.scrollEnabled = NO;
    [self.view addSubview:_mainScrollView];
    
    
    NSDictionary *dict = [[NSDictionary alloc]init];
    NSNotification *notification =[NSNotification notificationWithName:@"CKZG_cgjh_appear" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    CKZG_cgjh_ViewController *oneVC = [[CKZG_cgjh_ViewController alloc] init];
    [self.mainScrollView addSubview:oneVC.view];
    
    [self.view insertSubview:_mainScrollView belowSubview:_topScrollMenu];
    
    
    
    UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bars;
    
}

- (void)clicksearch{
    if ([Manager sharedManager].index_caigou == 0) {
        XHKCL_search_ViewController *search = [[XHKCL_search_ViewController alloc]init];
        search.str = @"caigou";
        [self.navigationController pushViewController:search animated:YES];
    }
    else if ([Manager sharedManager].index_caigou == 1) {
        CKZG_CGD_search_ViewController *search = [[CKZG_CGD_search_ViewController alloc]init];
        search.purchaseOrderType = @"";
        [self.navigationController pushViewController:search animated:YES];
    }
    else if ([Manager sharedManager].index_caigou == 2) {
        CKZG_CGD_search_ViewController *search = [[CKZG_CGD_search_ViewController alloc]init];
        search.purchaseOrderType = @"PIA";
        [self.navigationController pushViewController:search animated:YES];
    }
    else if ([Manager sharedManager].index_caigou == 3) {
        CKZG_CGD_search_ViewController *search = [[CKZG_CGD_search_ViewController alloc]init];
        search.purchaseOrderType = @"PIC";
        [self.navigationController pushViewController:search animated:YES];
    }
    else if ([Manager sharedManager].index_caigou == 4) {
        CKZG_CGD_search_ViewController *search = [[CKZG_CGD_search_ViewController alloc]init];
        search.purchaseOrderType = @"PID";
        [self.navigationController pushViewController:search animated:YES];
    }
}

- (void)SGTopScrollMenu:(SGTopScrollMenu *)topScrollMenu didSelectTitleAtIndex:(NSInteger)index{
    
    
    [Manager sharedManager].index_caigou = index;
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    //2.给对应位置添加对应子控制器
    [self showVc:index];
    
    
}

// 添加所有子控制器
- (void)setupChildViewController {
    CKZG_cgjh_ViewController *oneVC = [[CKZG_cgjh_ViewController alloc] init];
    [self addChildViewController:oneVC];
    
    CKZG_qbcgd_ViewController *twoVC = [[CKZG_qbcgd_ViewController alloc] init];
    [self addChildViewController:twoVC];
    
    CKZG_plcgd_ViewController *threeVC = [[CKZG_plcgd_ViewController alloc] init];
    [self addChildViewController:threeVC];
    
    CKZG_xhcgd_ViewController *fourVC = [[CKZG_xhcgd_ViewController alloc] init];
    [self addChildViewController:fourVC];
    
    CKZG_shcgd_ViewController *fiveVC = [[CKZG_shcgd_ViewController alloc] init];
    [self addChildViewController:fiveVC];
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    [Manager sharedManager].index_caigou = index;
    
    
    
    CGFloat offsetX = index * self.view.frame.size.width;
    
    UIViewController *vc = self.childViewControllers[index];
    
    // 判断控制器的view有没有加载过,如果已经加载过,就不需要加载
    if (vc.isViewLoaded) return;
    
    [self.mainScrollView addSubview:vc.view];
    vc.view.frame = CGRectMake(offsetX, 0, self.view.frame.size.width, self.view.frame.size.height);
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    // 计算滚动到哪一页
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    [self showVc:index];
    
    // 2.把对应的标题选中
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:@(index) userInfo:nil];
    
    // 2.把对应的标题选中
    UILabel *selLabel = self.topScrollMenu.allTitleLabel[index];
    
    [self.topScrollMenu selectLabel:selLabel];
    
    // 3.让选中的标题居中
    [self.topScrollMenu setupTitleCenter:selLabel];
    
}

@end

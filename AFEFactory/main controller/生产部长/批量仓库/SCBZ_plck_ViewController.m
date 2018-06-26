//
//  SCBZ_plck_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/6.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SCBZ_plck_ViewController.h"

#import "SCBZ_CPDRK_ViewController.h"
#import "SCBZ_CPRKD_ViewController.h"
#import "SCBZ_CPKCL_ViewController.h"
@interface SCBZ_plck_ViewController ()<SGTopScrollMenuDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) SGTopScrollMenu *topScrollMenu;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation SCBZ_plck_ViewController


- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"批量仓库";
    
    //    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    self.titles = @[@"成品待入库",@"成品入库单", @"成品库存量"];
    //    self.titles = @[@"排单计划",@"待生产单", @"待完成单",@"所有单据"];
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
    NSNotification *notification =[NSNotification notificationWithName:@"SCBZ_PLCK_appear" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    SCBZ_CPDRK_ViewController *oneVC = [[SCBZ_CPDRK_ViewController alloc] init];
    [self.mainScrollView addSubview:oneVC.view];
    
    [self.view insertSubview:_mainScrollView belowSubview:_topScrollMenu];
    
    
//    if ([Manager sharedManager].searchIndex != 0) {
//        UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
//        self.navigationItem.rightBarButtonItem = bars;
//    }else{
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithCustomView:btn];
//        self.navigationItem.rightBarButtonItem = bars;
//    }
}

- (void)clicksearch{
    
//    if ([Manager sharedManager].searchIndex == 0) {
//        SYLLD_search_ViewController *search = [[SYLLD_search_ViewController alloc]init];
//        search.str = @"zzpldd";
//        [self.navigationController pushViewController:search animated:YES];
//    }else if ([Manager sharedManager].searchIndex == 2) {
//        JRSZ_search_ViewController *search = [[JRSZ_search_ViewController alloc]init];
//        [self.navigationController pushViewController:search animated:YES];
//    }else if ([Manager sharedManager].searchIndex == 3) {
//        PaidanjihuaSearch_ViewController *search = [[PaidanjihuaSearch_ViewController alloc]init];
//        [self.navigationController pushViewController:search animated:YES];
//    }
//    else if ([Manager sharedManager].searchIndex == 5) {
//        SYDJ_search_ViewController *search = [[SYDJ_search_ViewController alloc]init];
//        search.str = @"xzsydj";
//        [self.navigationController pushViewController:search animated:YES];
//    }
    
}

- (void)SGTopScrollMenu:(SGTopScrollMenu *)topScrollMenu didSelectTitleAtIndex:(NSInteger)index{
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    //2.给对应位置添加对应子控制器
    [self showVc:index];
    
//    if (index != 0) {
//        UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
//        self.navigationItem.rightBarButtonItem = bars;
//    }else{
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithCustomView:btn];
//        self.navigationItem.rightBarButtonItem = bars;
//    }
}

// 添加所有子控制器
- (void)setupChildViewController {
    
    
    SCBZ_CPDRK_ViewController *oneVC = [[SCBZ_CPDRK_ViewController alloc] init];
    [self addChildViewController:oneVC];
    
    SCBZ_CPRKD_ViewController *twoVC = [[SCBZ_CPRKD_ViewController alloc] init];
    [self addChildViewController:twoVC];
    
    SCBZ_CPKCL_ViewController *threeVC = [[SCBZ_CPKCL_ViewController alloc] init];
    [self addChildViewController:threeVC];
    
   
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    [Manager sharedManager].searchIndex = index;
    
//    if (index != 0) {
//        UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
//        self.navigationItem.rightBarButtonItem = bars;
//    }else{
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithCustomView:btn];
//        self.navigationItem.rightBarButtonItem = bars;
//    }
    
    
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
    
    
//    if (index != 0) {
//        UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
//        self.navigationItem.rightBarButtonItem = bars;
//    }else{
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithCustomView:btn];
//        self.navigationItem.rightBarButtonItem = bars;
//    }
    
    
    // 1.添加子控制器view
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

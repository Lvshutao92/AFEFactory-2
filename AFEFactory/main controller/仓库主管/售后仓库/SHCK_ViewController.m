//
//  SHCK_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/23.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SHCK_ViewController.h"
#import "SHDD_ViewController.h"
#import "SHDSH_ViewController.h"
#import "SHYJD_ViewController.h"
#import "SHRKD_ViewController.h"
#import "SHKCL_ViewController.h"


#import "SYLLD_search_ViewController.h"
#import "HCDSH_search_ViewController.h"
#import "BJRKD_search_ViewController.h"
#import "HCKCL_search_ViewController.h"
@interface SHCK_ViewController ()<SGTopScrollMenuDelegate, UIScrollViewDelegate>
@property (nonatomic, strong) SGTopScrollMenu *topScrollMenu;
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation SHCK_ViewController
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"售后仓库";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 1.添加所有子控制器
    [self setupChildViewController];
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    self.titles = @[@"售后订单",@"售后待收货", @"售后已接单",@"售后入库单",@"售后库存量"];
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
    NSNotification *notification =[NSNotification notificationWithName:@"SHDD_appear" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    SHDD_ViewController *oneVC = [[SHDD_ViewController alloc] init];
    [self.mainScrollView addSubview:oneVC.view];
    
    [self.view insertSubview:_mainScrollView belowSubview:_topScrollMenu];
    
    
    
    UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bars;
    
}

- (void)clicksearch{
    if ([Manager sharedManager].index_sh == 0) {
        SYLLD_search_ViewController *search = [[SYLLD_search_ViewController alloc]init];
        search.str = @"shdd";
        [self.navigationController pushViewController:search animated:YES];
    }
    else if ([Manager sharedManager].index_sh == 1) {
        HCDSH_search_ViewController *search = [[HCDSH_search_ViewController alloc]init];
        search.str = @"SHDSH";
        [self.navigationController pushViewController:search animated:YES];
    }
    else if ([Manager sharedManager].index_sh == 2) {
        HCDSH_search_ViewController *search = [[HCDSH_search_ViewController alloc]init];
        search.str = @"SHYJD";
        [self.navigationController pushViewController:search animated:YES];
    }
    else if ([Manager sharedManager].index_sh == 3) {
        BJRKD_search_ViewController *search = [[BJRKD_search_ViewController alloc]init];
        search.str = @"SHRKD";
        [self.navigationController pushViewController:search animated:YES];
    }
    else if ([Manager sharedManager].index_sh == 4) {
        HCKCL_search_ViewController *search = [[HCKCL_search_ViewController alloc]init];
        search.str = @"SHKCL";
        [self.navigationController pushViewController:search animated:YES];
    }
    
}

- (void)SGTopScrollMenu:(SGTopScrollMenu *)topScrollMenu didSelectTitleAtIndex:(NSInteger)index{
    // 1 计算滚动的位置
    CGFloat offsetX = index * self.view.frame.size.width;
    self.mainScrollView.contentOffset = CGPointMake(offsetX, 0);
    //2.给对应位置添加对应子控制器
    [self showVc:index];
}

// 添加所有子控制器
- (void)setupChildViewController {
    SHDD_ViewController *oneVC = [[SHDD_ViewController alloc] init];
    [self addChildViewController:oneVC];
    
    SHDSH_ViewController *twoVC = [[SHDSH_ViewController alloc] init];
    [self addChildViewController:twoVC];
    
    SHYJD_ViewController  *threeVC = [[SHYJD_ViewController alloc] init];
    [self addChildViewController:threeVC];
    
    SHRKD_ViewController *fourVC = [[SHRKD_ViewController alloc] init];
    [self addChildViewController:fourVC];
    
    SHKCL_ViewController *fiveVC = [[SHKCL_ViewController alloc] init];
    [self addChildViewController:fiveVC];
    
   
    
}

// 显示控制器的view
- (void)showVc:(NSInteger)index {
    [Manager sharedManager].index_sh = index;
   
    
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

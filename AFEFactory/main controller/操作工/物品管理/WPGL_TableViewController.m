//
//  WPGL_TableViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WPGL_TableViewController.h"
#import "WPLY_ViewController.h"
#import "WDWP_ViewController.h"
#import "YLWp_ViewController.h"
#import "YHPLB_ViewController.h"
#import "NYPLB_ViewController.h"
#import "YHPBB_ViewController.h"
#import "NYPBB_ViewController.h"
#import "WaicengTableViewCell.h"

#import "WDWP_A_ViewController.h"
#import "WDWP_B_ViewController.h"
@interface WPGL_TableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@property(nonatomic, strong)NSMutableArray *arr1;
@end

@implementation WPGL_TableViewController

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (NSMutableArray *)arr {
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (NSMutableArray *)arr1 {
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.arr = [@[@"物品领用",@"我的物品",@"已领物品",@"易耗品列表",@"耐用品列表",@"易耗品报表",@"耐用品报表"]mutableCopy];
    self.arr1 = [@[@"物品领用",@"我的物品",@"已领物品",@"易耗品列表",@"耐用品列表",@"易耗品报表",@"耐用品报表"]mutableCopy];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WaicengTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = view;
}








- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WaicengTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.lab.text = self.arr[indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *str = self.arr1[indexPath.row];
    cell.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",str]];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WaicengTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.lab.text isEqualToString:@"物品领用"]) {
        WPLY_ViewController *vc = [[WPLY_ViewController alloc]init];
        vc.navigationItem.title = @"物品领用";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"我的物品"]) {

        
        WDWP_ViewController *vc = [[WDWP_ViewController alloc] initWithAddVCARY:@[[WDWP_A_ViewController new],[WDWP_B_ViewController new]] TitleS:@[@"易耗品列表",@"耐用品列表"]];
        [Manager sharedManager].index_renshi = 1000;
        vc.navigationItem.title = @"我的物品";
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    else if ([cell.lab.text isEqualToString:@"已领物品"]) {
        YLWp_ViewController *vc = [[YLWp_ViewController alloc]init];
        vc.navigationItem.title = @"已领物品";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"易耗品列表"]) {
        YHPLB_ViewController *vc = [[YHPLB_ViewController alloc]init];
        vc.navigationItem.title = @"易耗品列表";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"耐用品列表"]) {
        NYPLB_ViewController *vc = [[NYPLB_ViewController alloc]init];
        vc.navigationItem.title = @"耐用品列表";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"易耗品报表"]) {
        YHPBB_ViewController *vc = [[YHPBB_ViewController alloc]init];
        vc.navigationItem.title = @"易耗品报表";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"耐用品报表"]) {
        NYPBB_ViewController *vc = [[NYPBB_ViewController alloc]init];
        vc.navigationItem.title = @"耐用品报表";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
   
    
    
}

@end

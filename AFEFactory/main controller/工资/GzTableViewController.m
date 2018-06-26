//
//  GzTableViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/2/2.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "GzTableViewController.h"
#import "WaicengTableViewCell.h"

#import "GZ1_TableViewController.h"
#import "MoneyViewController.h"
#import "YueGongZiTiao_ViewController.h"



@interface GzTableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@property(nonatomic, strong)NSMutableArray *arr1;
@end

@implementation GzTableViewController


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
    self.navigationItem.title = @"我的工资";
    self.arr = [@[@"工资结构",@"每日汇总",@"月工资条"]mutableCopy];
    self.arr1 = [@[@"工资结构",@"每日汇总",@"月工资条"]mutableCopy];
    
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
    if ([cell.lab.text isEqualToString:@"工资结构"]) {
        GZ1_TableViewController *vc = [[GZ1_TableViewController alloc]init];
        vc.navigationItem.title = @"工资结构";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"每日汇总"]) {
        MoneyViewController *vc = [[MoneyViewController alloc]init];
        vc.navigationItem.title = @"每日汇总";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"月工资条"]) {
        YueGongZiTiao_ViewController *vc = [[YueGongZiTiao_ViewController alloc]init];
        vc.navigationItem.title = @"月工资条";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end

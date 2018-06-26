//
//  GCCPCGLY_PiLiang_TableViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/3.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "GCCPCGLY_PiLiang_TableViewController.h"
#import "PiLiang_A_ViewController.h"
#import "PiLiang_B_ViewController.h"
#import "PiLiang_C_ViewController.h"
#import "PiLiang_D_ViewController.h"

#import "WaicengTableViewCell.h"
@interface GCCPCGLY_PiLiang_TableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@property(nonatomic, strong)NSMutableArray *arr1;
@end

@implementation GCCPCGLY_PiLiang_TableViewController

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
    
    self.arr = [@[@"成品待入库",@"成品已接单",@"成品入库单",@"成品库存量"]mutableCopy];
    self.arr1 = [@[@"物品领用",@"我的物品",@"已领物品",@"易耗品列表"]mutableCopy];
    
    
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
    if ([cell.lab.text isEqualToString:@"成品待入库"]) {
        PiLiang_A_ViewController *vc = [[PiLiang_A_ViewController alloc]init];
        vc.navigationItem.title = @"成品待入库";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"成品已接单"]) {
        PiLiang_B_ViewController *vc = [[PiLiang_B_ViewController alloc]init];
        vc.navigationItem.title = @"成品已接单";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"成品入库单"]) {
        PiLiang_C_ViewController *vc = [[PiLiang_C_ViewController alloc]init];
        vc.navigationItem.title = @"成品入库单";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"成品库存量"]) {
        PiLiang_D_ViewController *vc = [[PiLiang_D_ViewController alloc]init];
        vc.navigationItem.title = @"成品库存量";
        [self.navigationController pushViewController:vc animated:YES];
    }
   
  
}
@end

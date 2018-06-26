//
//  SheBeiTableViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/10.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "SheBeiTableViewController.h"
#import "WaicengTableViewCell.h"

#import "SBWXS_TableViewController.h"
#import "LBGL_TableViewController.h"
#import "PJGL_ViewController.h"
#import "WDSB_ViewController.h"
#import "SYSB_ViewController.h"

#import "WodeWeiXiu_ViewController.h"
#import "SuoyouWeixiu_ViewController.h"

#import "WodeBaoyang_ViewController.h"
#import "SuoyouBaoyang_ViewController.h"
@interface SheBeiTableViewController ()
@property(nonatomic, strong)NSMutableArray *arr;
@property(nonatomic, strong)NSMutableArray *arr1;

@property(nonatomic, strong)NSMutableArray *namearr;
@end

@implementation SheBeiTableViewController
- (NSMutableArray *)namearr{
    if (_namearr ==nil) {
        self.namearr = [NSMutableArray arrayWithCapacity:1];
    }
    return _namearr;
}
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
    
    self.arr = [@[@"设备维修商",@"类别管理",@"配件管理",@"我的设备",@"所有设备",@"我的维修申请",@"所有维修申请",@"我的保养申请",@"所有保养申请"]mutableCopy];
    self.arr1 = [@[@"设备维修商",@"类别管理",@"配件管理",@"我的设备",@"所有设备",@"我的维修申请",@"所有维修申请",@"我的保养申请",@"所有保养申请"]mutableCopy];
    
    
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
    if ([cell.lab.text isEqualToString:@"设备维修商"]) {
        SBWXS_TableViewController *vc = [[SBWXS_TableViewController alloc]init];
        vc.navigationItem.title = @"设备维修商";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"类别管理"]) {
        LBGL_TableViewController *vc = [[LBGL_TableViewController alloc]init];
        vc.navigationItem.title = @"类别管理";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"配件管理"]) {
        PJGL_ViewController *vc = [[PJGL_ViewController alloc]init];
        vc.navigationItem.title = @"配件管理";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"我的设备"]) {
        WDSB_ViewController *vc = [[WDSB_ViewController alloc]init];
        vc.navigationItem.title = @"我的设备";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"所有设备"]) {
        SYSB_ViewController *vc = [[SYSB_ViewController alloc]init];
        vc.navigationItem.title = @"所有设备";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"我的维修申请"]) {
        WodeWeiXiu_ViewController *vc = [[WodeWeiXiu_ViewController alloc]init];
        vc.navigationItem.title = @"我的维修申请";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"所有维修申请"]) {
        SuoyouWeixiu_ViewController *vc = [[SuoyouWeixiu_ViewController alloc]init];
        vc.navigationItem.title = @"所有维修申请";
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if ([cell.lab.text isEqualToString:@"我的保养申请"]) {
        WodeBaoyang_ViewController *vc = [[WodeBaoyang_ViewController alloc]init];
        vc.navigationItem.title = @"我的保养申请";
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if ([cell.lab.text isEqualToString:@"所有保养申请"]) {
        SuoyouBaoyang_ViewController *vc = [[SuoyouBaoyang_ViewController alloc]init];
        vc.navigationItem.title = @"所有保养申请";
        [self.navigationController pushViewController:vc animated:YES];
    }
//
//
    
    
}

@end

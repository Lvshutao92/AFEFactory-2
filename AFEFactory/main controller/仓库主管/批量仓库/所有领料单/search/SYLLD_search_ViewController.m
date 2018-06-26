//
//  SYLLD_search_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/27.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SYLLD_search_ViewController.h"
#import "SYLLD_search_list_ViewController.h"
#import "XHDD_search_list_ViewController.h"
#import "SHDD_search_list_ViewController.h"


#import "PaiDan_pldd_search_list_ViewController.h"
@interface SYLLD_search_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *status;
}
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)NSMutableArray *dataArrayid;

@end

@implementation SYLLD_search_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"检索";
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    
    if ([self.str isEqualToString:@"xhdd"]) {
        self.dataArray   = [@[@"已确认订单",@"待发货订单",@"已发货订单"]mutableCopy];
        self.dataArrayid = [@[@"confirmed",@"undelivery",@"delivery"]mutableCopy];
        
        self.lab1.text = @"订单编号";
        self.lab2.text = @"客户简称";
        self.lab3.text = @"出货单号";
        self.lab4.text = @"订单状态";
    }else if ([self.str isEqualToString:@"shdd"]) {
        self.dataArray   = [@[@"已确认订单",@"待发货订单",@"已发货订单"]mutableCopy];
        self.dataArrayid = [@[@"confirmed",@"undelivery",@"delivery"]mutableCopy];
        
        self.lab1.text = @"订单编号";
        self.lab2.text = @"客户简称";
        self.lab3.text = @"出货单号";
        self.lab4.text = @"订单状态";
    }else if ([self.str isEqualToString:@"zzpldd"]) {
        self.dataArray   = [@[@"已确认订单",@"生产中订单",@"待发货订单",@"已发货订单",@"已取消订单"]mutableCopy];
        self.dataArrayid = [@[@"confirmed",@"production",@"undelivery",@"delivery",@"cancel"]mutableCopy];
        
        self.lab1.text = @"订单编号";
        self.lab2.text = @"客户简称";
        self.lab3.text = @"出货单号";
        self.lab4.text = @"订单状态";
    }else{
        self.dataArray   = [@[@"待领料",@"领料中",@"已领料",@"已出库"]mutableCopy];
        self.dataArrayid = [@[@"create",@"picking",@"picked",@"delivery"]mutableCopy];
        
        self.lab1.text = @"领料单号";
        self.lab2.text = @"订单编号";
        self.lab3.text = @"生产单号";
        self.lab4.text = @"单据状态";
    }
    
    
    
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(95, 265, SCREEN_WIDTH-105, 200)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableview1.hidden = YES;
    self.text4.text = self.dataArray[indexPath.row];
    status = self.dataArrayid[indexPath.row];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.tableview1.hidden = YES;
    [self.text1 resignFirstResponder];
    [self.text2 resignFirstResponder];
    [self.text3 resignFirstResponder];
}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text4]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    self.tableview1.hidden = YES;
    return YES;
}







- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (NSMutableArray *)dataArrayid {
    if (_dataArrayid == nil) {
        self.dataArrayid = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArrayid;
}

- (IBAction)clicksearch:(id)sender {
    if (self.text1.text.length == 0) {
        self.text1.text = @"";
    }
    if (self.text2.text.length == 0) {
        self.text2.text = @"";
    }
    if (self.text3.text.length == 0) {
        self.text3.text = @"";
    }
    if (status.length == 0) {
        status = @"";
    }
    
    
    if ([self.str isEqualToString:@"xhdd"]){
        XHDD_search_list_ViewController *list = [[XHDD_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = status;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }else if ([self.str isEqualToString:@"shdd"]) {
        
        
        SHDD_search_list_ViewController *list = [[SHDD_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = status;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
        
        
    }else if ([self.str isEqualToString:@"zzpldd"]) {
        
        
        PaiDan_pldd_search_list_ViewController *list = [[PaiDan_pldd_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = status;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
        
        
    }else{
        SYLLD_search_list_ViewController *list = [[SYLLD_search_list_ViewController alloc]init];
        list.str1 = self.text1.text;
        list.str2 = self.text2.text;
        list.str3 = self.text3.text;
        list.str4 = status;
        list.navigationItem.title = @"检索信息";
        [self.navigationController pushViewController:list animated:YES];
    }
    
    
    
}

@end

//
//  SYLLD_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/24.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SYLLD_ViewController.h"
#import "SYLLD_8_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
#import "SYLLD_details_TableViewController.h"
@interface SYLLD_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation SYLLD_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 108.3, SCREEN_WIDTH, 5)];
    lab.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [self.view addSubview:lab];
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, height+50, SCREEN_WIDTH, SCREEN_HEIGHT-110)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"SYLLD_8_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 330;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    SYLLD_8_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[SYLLD_8_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"领料单号：%@",model.materialNo];
    cell.lab2.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    cell.lab3.text = [NSString stringWithFormat:@"生产单号：%@",model.productionOrderNo];


    if ([model.status isEqualToString:@"create"]) {
        cell.lab4.textColor = [UIColor blackColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"单据状态：待领料"];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab4 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"picking"]) {
        cell.lab4.textColor = [UIColor blackColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"单据状态：领料中"];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab4 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"picked"]) {
        cell.lab4.textColor = [UIColor blackColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"单据状态：已领料"];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab4 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"delivery"]) {
        cell.lab4.textColor = [UIColor blackColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"单据状态：已出库"];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab4 setAttributedText:noteStr2];
    }
    cell.lab5.text = [NSString stringWithFormat:@"领料人：%@",model.personName];
    
    if (model.materialTime == nil) {
        cell.lab6.text = [NSString stringWithFormat:@"领料接单时间：%@",@"-"];
    }else{

        cell.lab6.text = [NSString stringWithFormat:@"领料接单时间：%@",[Manager TimeCuoToTimes:model.materialTime] ];
    }

    if (model.outputTime == nil) {
        cell.lab7.text = [NSString stringWithFormat:@"领料评分：%@",@"-"];
    }else{
        cell.lab7.text = [NSString stringWithFormat:@"领料评分：%@",model.score];
    }
    
    
    if (model.outputTime == nil) {
        cell.lab8.text = [NSString stringWithFormat:@"出库时间：%@",@"-"];
    }else{
        cell.lab8.text = [NSString stringWithFormat:@"出库时间：%@",[Manager TimeCuoToTimes: model.outputTime]];
    }
    
  
    return cell;
}








- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    SYLLD_details_TableViewController *order = [[SYLLD_details_TableViewController alloc]init];
    order.purchaseOrderId = model.id;
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:order animated:YES];
}

//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableview.mj_header beginRefreshing];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableview.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}
- (void)loddeList{
    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    page = 1;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"desc",
            @"sort":@"materialNo",
            
            @"materialNo":@"",
            @"orderNo":@"",
            @"productionOrderNo":@"",
            @"status":@"",
            };

    [session POST:KURLNSString(@"servlet/material/materialorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
        page = 2;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_header endRefreshing];
    }];
}
- (void)loddeSLList{
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"desc",
            @"sort":@"materialNo",
            
            @"materialNo":@"",
            @"orderNo":@"",
            @"productionOrderNo":@"",
            @"status":@"",
            };
    [session POST:KURLNSString(@"servlet/material/materialorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[diction objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}








- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end

//
//  PaiDan_pldd_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PaiDan_pldd_ViewController.h"
#import "HCDSH_7_Cell.h"
#import "PaiDanModel.h"
#import "PLDD_details_ViewController.h"

#import "PLDD_one_details_ViewController.h"
#import "PLDD_two_details_ViewController.h"
#import "PLDD_three_details_ViewController.h"
#import "PLDD_four_details_ViewController.h"
@interface PaiDan_pldd_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation PaiDan_pldd_ViewController

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
    [self.tableview registerNib:[UINib nibWithNibName:@"HCDSH_7_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewappear:) name:@"SCBZ_PLDD_appear" object:nil];
}
- (void)viewappear:(NSNotification *)text {
    [self setUpReflash];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 290;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    HCDSH_7_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[HCDSH_7_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.line.hidden = YES;
    cell.btn.hidden = YES;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (model.orderNo == nil) {
        cell.lab1.text = [NSString stringWithFormat:@"订单编号：%@",@"-"];
    }else{
        cell.lab1.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    }

    cell.lab2.text = [NSString stringWithFormat:@"客户简称：%@",model.dealerName];
    
    
    

    if ([model.orderStatus isEqualToString:@"confirm"]) {
        cell.lab3.textColor = [UIColor blackColor];
        cell.lab3.text =@"订单状态：待确认订单";
    }else  if ([model.orderStatus isEqualToString:@"confirmed"]) {
        cell.lab3.textColor = [UIColor blackColor];
        cell.lab3.text =@"订单状态：已确认订单";
    }else  if ([model.orderStatus isEqualToString:@"production"]) {
        cell.lab3.textColor = RGBACOLOR(32, 157, 149, 1.0);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"订单状态：生产中订单"];
        NSRange range = NSMakeRange(0, 5);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab3 setAttributedText:noteStr];
    }else  if ([model.orderStatus isEqualToString:@"delivery"]) {
        cell.lab3.textColor = [UIColor blackColor];
        cell.lab3.text =@"订单状态：已发货订单";
    }else  if ([model.orderStatus isEqualToString:@"cancel"]) {
        cell.lab3.textColor = [UIColor blackColor];
        cell.lab3.text =@"订单状态：已取消订单";
    }else  if ([model.orderStatus isEqualToString:@"undelivery"]) {
        cell.lab3.textColor = [UIColor blackColor];
        cell.lab3.text =@"订单状态：待发货订单";
    }
    
    
    if (model.container == nil) {
        cell.lab4.text = [NSString stringWithFormat:@"集装箱：%@",@"-"];
    }else{
        cell.lab4.text = [NSString stringWithFormat:@"集装箱：%@",model.container];
    }
    if (model.planDeliveryDate == nil) {
        cell.lab5.text = [NSString stringWithFormat:@"计划生产日期：%@",@"-"];
    }else{
        cell.lab5.text = [NSString stringWithFormat:@"计划生产日期：%@",[Manager TimeCuoToTimes:model.planDeliveryDate]];
    }
    if (model.actualDeliveryDate == nil) {
        cell.lab6.text = [NSString stringWithFormat:@"实际生产日期：%@",@"-"];
    }else{
        cell.lab6.text = [NSString stringWithFormat:@"实际生产日期：%@",[Manager TimeCuoToTimes:model.actualDeliveryDate]];
    }
    
    if (model.field7 == nil) {
        cell.lab7.text = [NSString stringWithFormat:@"集装箱：%@",@"-"];
    }else{
        cell.lab7.text = [NSString stringWithFormat:@"集装箱：%@",model.field7];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];

    
    PLDD_details_ViewController *vc = [[PLDD_details_ViewController alloc] initWithAddVCARY:@[[PLDD_one_details_ViewController new],[PLDD_two_details_ViewController new],[PLDD_three_details_ViewController new],[PLDD_four_details_ViewController new]] TitleS:@[@"订单明细",@"部件清单",@"排单日志",@"操作日志"]];
    
    
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"orderNo":model.orderNo,@"orderId":model.id};
    NSNotification *notification =[NSNotification notificationWithName:@"zzpldd" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    
    
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:vc animated:YES];
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
            @"sort":@"createTime",
            
            @"orderNo":@"",
            @"dealerName":@"",
            @"field7":@"",
            @"orderStatus":@"",
            };
    [session POST:KURLNSString(@"servlet/order/batch/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
            @"sort":@"createTime",
            
            @"orderNo":@"",
            @"dealerName":@"",
            @"field7":@"",
            @"orderStatus":@"",
            };
    [session POST:KURLNSString(@"servlet/order/batch/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
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

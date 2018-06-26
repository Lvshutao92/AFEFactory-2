//
//  CKZG_plcgd_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/6.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CKZG_plcgd_ViewController.h"
#import "BJRKD_12_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel2.h"
#import "PaidanModel1.h"
#import "CGD_detaisl_TableViewController.h"
@interface CKZG_plcgd_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation CKZG_plcgd_ViewController


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
    [self.tableview registerNib:[UINib nibWithNibName:@"BJRKD_12_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewappear:) name:@"CKZG_cgjh_appear" object:nil];
}
- (void)viewappear:(NSNotification *)text {
    [self setUpReflash];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 350;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    BJRKD_12_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[BJRKD_12_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab12.hidden = YES;
    cell.line.hidden = YES;
    cell.btn.hidden = YES;
    cell.btn1.hidden = YES;
    cell.btn2.hidden = YES;
    
    
    cell.lab1.text = [NSString stringWithFormat:@"采购单编号：%@",model.purchaseOrderNo];
    
    if (model.orderNo == nil) {
        cell.lab2.text = [NSString stringWithFormat:@"订单编号：%@",@"-"];
    }else{
        cell.lab2.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    }
    cell.lab3.text = [NSString stringWithFormat:@"供应商：%@",model.supplierNo];
    
    
    if ([model.purchaseOrderType isEqualToString:@"PIA"]) {
        cell.lab4.text = @"采购单类型：批量订单采购单";
    }else  if ([model.purchaseOrderType isEqualToString:@"PIC"]) {
        cell.lab4.text = @"采购单类型：现货商品采购单";
    }else  if ([model.purchaseOrderType isEqualToString:@"PID"]) {
        cell.lab4.text = @"采购单类型：售后部件采购单";
    }
    
    if ([model.manual isEqualToString:@"Y"]) {
        cell.lab5.text = @"是否是手工采购单：✔";
    }else{
        cell.lab5.text = @"是否是手工采购单：✖";
    }
    
    if (model.planProductionDate == nil) {
        cell.lab6.text = [NSString stringWithFormat:@"最晚交货日期：%@",@"-"];
    }else{
        cell.lab6.text = [NSString stringWithFormat:@"最晚交货日期：%@",model.planProductionDate];
    }
    
    if (model.plateNumber == nil) {
        cell.lab7.text = [NSString stringWithFormat:@"送货车辆车牌号：%@",@"-"];
    }else{
        cell.lab7.text = [NSString stringWithFormat:@"送货车辆车牌号：%@",model.plateNumber];
    }
    
    if (model.sendTime == nil) {
        cell.lab8.text = [NSString stringWithFormat:@"预约送货时间：%@",@"-"];
    }else{
        cell.lab8.text = [NSString stringWithFormat:@"预约送货时间：%@",model.sendTime];
    }
    
    if (model.receivePerson_model.personCode == nil) {
        cell.lab9.text = [NSString stringWithFormat:@"接货人：%@",@"-"];
    }else{
        cell.lab9.text = [NSString stringWithFormat:@"接货人：%@ %@",model.receivePerson_model.personCode,model.receivePerson_model.realName];
    }
    
    if (model.forkliftPerson_model.personCode == nil) {
        cell.lab10.text = [NSString stringWithFormat:@"叉车工：%@",@"-"];
    }else{
        cell.lab10.text = [NSString stringWithFormat:@"叉车工：%@ %@",model.forkliftPerson_model.personCode,model.forkliftPerson_model.realName];
    }
    
    
    if ([model.status isEqualToString:@"created"]) {
        cell.lab11.textColor = [UIColor redColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"状态：待确认"];
        NSRange range2 = NSMakeRange(0, 3);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab11 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"confirmed"]) {
        cell.lab11.textColor = [UIColor greenColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"状态：已确认"];
        NSRange range2 = NSMakeRange(0, 3);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab11 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"returned"]) {
        cell.lab11.textColor = [UIColor blueColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"状态：已退货"];
        NSRange range2 = NSMakeRange(0, 3);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab11 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"finished"]) {
        cell.lab11.textColor = RGBACOLOR(32, 157, 149, 1.0);
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"状态：已入库"];
        NSRange range2 = NSMakeRange(0, 3);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab11 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"canceled"]) {
        cell.lab11.textColor = [UIColor blackColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"状态：已取消"];
        NSRange range2 = NSMakeRange(0, 3);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab11 setAttributedText:noteStr2];
    }
    
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    CGD_detaisl_TableViewController *order = [[CGD_detaisl_TableViewController alloc]init];
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
            @"stockInPersonId":[Manager redingwenjianming:@"user_cert_id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"desc",
            @"sort":@"createTime",
            
            @"orderNo":@"",
            @"purchaseOrderNo":@"",
            @"originalPurchaseOrderNo":@"",
            @"purchasePlanNo":@"",
            @"supplierNo":@"",
            @"status":@"",
            @"purchaseOrderType":@"PIA",
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [dic objectForKey:@"rows"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel2 *model1 = [PaidanModel2 mj_objectWithKeyValues:model.purchasePlan];
            model.purchasePlan_model = model1;
            
            PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.receivePerson_ed];
            model.receivePerson_model = model2;
            PaidanModel1 *model3 = [PaidanModel1 mj_objectWithKeyValues:model.forkliftPerson_ed];
            model.forkliftPerson_model = model3;
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
            @"stockInPersonId":[Manager redingwenjianming:@"user_cert_id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"desc",
            @"sort":@"createTime",
            
            @"orderNo":@"",
            @"purchaseOrderNo":@"",
            @"originalPurchaseOrderNo":@"",
            @"purchasePlanNo":@"",
            @"supplierNo":@"",
            @"status":@"",
            @"purchaseOrderType":@"PIA",
            
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [dic objectForKey:@"rows"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel2 *model1 = [PaidanModel2 mj_objectWithKeyValues:model.purchasePlan];
            model.purchasePlan_model = model1;
            
            PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.receivePerson_ed];
            model.receivePerson_model = model2;
            
            PaidanModel1 *model3 = [PaidanModel1 mj_objectWithKeyValues:model.forkliftPerson_ed];
            model.forkliftPerson_model = model3;
            
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

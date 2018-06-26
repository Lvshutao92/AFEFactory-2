//
//  CGJH_2_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/7.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CGJH_2_ViewController.h"
#import "SYLLD_8_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel2.h"
@interface CGJH_2_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation CGJH_2_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"SYLLD_8_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(details:) name:@"CGJH_details" object:nil];
}
- (void)details:(NSNotification *)text{
    NSDictionary *dic = text.userInfo;
    [Manager sharedManager].ids = [dic objectForKey:@"purchasePlanId"];
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
    cell.lab1.text = [NSString stringWithFormat:@"采购单编号：%@",model.purchaseOrderNo];
    
    
    
    if (model.originalPurchaseOrderNo == nil) {
        cell.lab2.text = [NSString stringWithFormat:@"原采购单编号：%@",@"-"];
    }else{
        cell.lab2.text = [NSString stringWithFormat:@"原采购单编号：%@",model.originalPurchaseOrderNo];
    }
    
    if (model.purchasePaymentOrder == nil) {
        cell.lab3.text = [NSString stringWithFormat:@"发票号：%@",@"-"];
    }else{
         cell.lab3.text = [NSString stringWithFormat:@"发票号：%@",model.purchasePaymentOrder];
    }
   
    
    cell.lab4.text = [NSString stringWithFormat:@"供应商：%@",model.supplierNo];
    
    
    if (model.planProductionDate == nil) {
        cell.lab5.text = [NSString stringWithFormat:@"最晚交货日期：%@",@"-"];
    }else{
        cell.lab5.text = [NSString stringWithFormat:@"最晚交货日期：%@", model.planProductionDate];
    }
    
    if (model.sendTime == nil) {
        cell.lab6.text = [NSString stringWithFormat:@"预约送货时间：%@",@"-"];
    }else{
        cell.lab6.text = [NSString stringWithFormat:@"预约送货时间：%@", model.sendTime];
    }
    
    if (model.plateNumber == nil) {
        cell.lab7.text = [NSString stringWithFormat:@"送货车辆车牌号：%@",@"-"];
    }else{
        cell.lab7.text = [NSString stringWithFormat:@"送货车辆车牌号：%@", model.plateNumber];
    }
 
    
    if ([model.status isEqualToString:@"created"]) {
        cell.lab8.textColor = [UIColor redColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"状态：待确认"];
        NSRange range2 = NSMakeRange(0, 3);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab8 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"confirmed"]) {
        cell.lab8.textColor = [UIColor greenColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"状态：已确认"];
        NSRange range2 = NSMakeRange(0, 3);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab8 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"returned"]) {
        cell.lab8.textColor = [UIColor blueColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"状态：已退货"];
        NSRange range2 = NSMakeRange(0, 3);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab8 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"finished"]) {
        cell.lab8.textColor = RGBACOLOR(32, 157, 149, 1.0);
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"状态：已入库"];
        NSRange range2 = NSMakeRange(0, 3);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab8 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"canceled"]) {
        cell.lab8.textColor = [UIColor blackColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"状态：已取消"];
        NSRange range2 = NSMakeRange(0, 3);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab8 setAttributedText:noteStr2];
    }

    
    return cell;
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
    if ([Manager sharedManager].ids == nil) {
        [Manager sharedManager].ids = @"";
    }
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"purchasePlanId":[Manager sharedManager].ids,
            @"page":[NSString stringWithFormat:@"%ld",page],
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/forplanlist") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
//        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = (NSMutableArray *)dic;
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];

            PaidanModel2 *model1 = [PaidanModel2 mj_objectWithKeyValues:model.purchasePlan];
            model.purchasePlan_model = model1;


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
            @"purchasePlanId":[Manager sharedManager].ids,
            @"page":[NSString stringWithFormat:@"%ld",page],
            };
    
    [session POST:KURLNSString(@"servlet/purchase/purchaseorder/forplanlist") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = (NSMutableArray *)dic;
        
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel2 *model1 = [PaidanModel2 mj_objectWithKeyValues:model.purchasePlan];
            model.purchasePlan_model = model1;
            
            
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

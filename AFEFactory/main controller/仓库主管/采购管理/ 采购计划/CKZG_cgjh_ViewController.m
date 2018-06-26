//
//  CKZG_cgjh_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/6.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CKZG_cgjh_ViewController.h"
#import "HCCKD_6_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
#import "ShuZuListModel.h"

#import "CKZG_cgjh_details_ViewController.h"
#import "CGJH_1_ViewController.h"
#import "CGJH_2_ViewController.h"
#import "CGJH_3_ViewController.h"

@interface CKZG_cgjh_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    CGFloat totalCount;
    CGFloat finishedCount;
    CGFloat canceledCount;
    CGFloat recreateCount;
    CGFloat res;
    
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)NSMutableArray *imgdataArray;
@end

@implementation CKZG_cgjh_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 108.3, SCREEN_WIDTH, 5)];
    lab.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [self.view addSubview:lab];
    
    
    totalCount=0;
    finishedCount=0;
    canceledCount=0;
    recreateCount=0;
    res = 0;
    
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
    [self.tableview registerNib:[UINib nibWithNibName:@"HCCKD_6_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewappear:) name:@"CKZG_cgjh_appear" object:nil];
}
- (void)viewappear:(NSNotification *)text {
    [self setUpReflash];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 215;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    HCCKD_6_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[HCCKD_6_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.line.hidden = YES;
    cell.btn.hidden = YES;
    cell.btn1.hidden = YES;
    cell.lab6.hidden = YES;
    
    
    totalCount=0;
    finishedCount=0;
    canceledCount=0;
    recreateCount=0;
    res = 0;
    
    
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"采购计划编号：%@",model.purchasePlanNo];
    if (model.oeder_model.orderNo == nil) {
        cell.lab2.text = [NSString stringWithFormat:@"批量订单编号：%@",@"-"];
    }else{
        cell.lab2.text = [NSString stringWithFormat:@"批量订单编号：%@",model.oeder_model.orderNo];
    }
    
    
    if (model.createTime == nil) {
        cell.lab3.text = [NSString stringWithFormat:@"计划生产日期：%@",@"-"];
    }else{
        
        cell.lab3.text = [NSString stringWithFormat:@"计划生产日期：%@",[Manager TimeCuoToTime:model.createTime]];
    }

    if ([model.orderStatus isEqualToString:@"created"]) {
       cell.lab4.text = @"采购计划状态：已创建";
    }else if ([model.orderStatus isEqualToString:@"createPurchaseOrder"]) {
        cell.lab4.text = @"采购计划状态：未完成";
    }else if ([model.orderStatus isEqualToString:@"supplierCheckPurchaseOrder"]) {
       cell.lab4.text = @"采购计划状态：未完成";
    }else if ([model.orderStatus isEqualToString:@"supplierConfirmed"]) {
        cell.lab4.text = @"采购计划状态：未完成";
    }else if ([model.orderStatus isEqualToString:@"createPurchaseWarehouseReceipt"]) {
        cell.lab4.text = @"采购计划状态：未完成";
    }else if ([model.orderStatus isEqualToString:@"finished"]) {
        cell.lab4.text = @"采购计划状态：已完成";
    }

    
    if (model.purchaseOrderList != nil) {
        for (ShuZuListModel *dic in model.purchaseOrderList) {
            if ([dic.status isEqualToString:@"finished"]) {
                finishedCount++;
            }
            if ([dic.status isEqualToString:@"canceled"]||[dic.status isEqualToString:@"returned"]) {
                canceledCount++;
                continue;
            }
            if ([dic.needRecreate isEqualToString:@"Y"]) {
                recreateCount++;
                continue;
            }
            totalCount++;
        }
    }else{
        cell.lab5.text = @"采购计划进度：-";
    }
    if (finishedCount > 0) {
        res = 100 * finishedCount / totalCount;
    }
  
//    cell.lab5.text = [NSString stringWithFormat:@"采购计划进度：%.2f%%   %.0f/%.0f",res,finishedCount,totalCount];
    cell.lab5.textColor = [UIColor redColor];
    
    NSMutableAttributedString *noteStr4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"采购计划进度：%.2f%%   %.0f/%.0f",res,finishedCount,totalCount]];
    NSRange range4 = NSMakeRange(0, 7);
    [noteStr4 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range4];
    [cell.lab5 setAttributedText:noteStr4];
    
    return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    CKZG_cgjh_details_ViewController *vc = [[CKZG_cgjh_details_ViewController alloc] initWithAddVCARY:@[[CGJH_1_ViewController new],[CGJH_2_ViewController new],[CGJH_3_ViewController new]] TitleS:@[@"部件清单",@"采购单清单",@"操作日志"]];
    
    
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"purchasePlanId":model.id};
    NSNotification *notification =[NSNotification notificationWithName:@"CGJH_details" object:nil userInfo:dict];
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
            
            @"purchasePlanNo":@"",
            @"order.orderNo":@"",
            @"orderStatus":@"",
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseplan/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//             NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.imgdataArray removeAllObjects];
        
        [PaiDanModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"purchaseOrderList" : [ShuZuListModel class],
                     };
        }];
        
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.order];
            model.oeder_model = model1;
            
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
            
            @"purchasePlanNo":@"",
            @"order.orderNo":@"",
            @"orderStatus":@"",
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseplan/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[diction objectForKey:@"rows"] objectForKey:@"resultList"];
        
        [PaiDanModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                     @"purchaseOrderList" : [ShuZuListModel class],
                     };
        }];
        
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.order];
            model.oeder_model = model1;
            
            [weakSelf.dataArray addObject:model];
        }
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}





- (NSMutableArray *)imgdataArray {
    if (_imgdataArray == nil) {
        self.imgdataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _imgdataArray;
}


- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end

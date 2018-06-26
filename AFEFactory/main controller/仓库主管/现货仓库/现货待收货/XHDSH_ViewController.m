//
//  XHDSH_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/30.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XHDSH_ViewController.h"
#import "HCDSH_7_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
#import "XHDSH_details_TableViewController.h"
@interface XHDSH_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation XHDSH_ViewController


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
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewappear:) name:@"XHDD_appear" object:nil];
}
- (void)viewappear:(NSNotification *)text {
    [self setUpReflash];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 280;
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
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"入库单编号：%@",model.stockInOrderNo];
    if (model.orderNo == nil) {
        cell.lab2.text = [NSString stringWithFormat:@"订单编号：%@",@"-"];
    }else{
        cell.lab2.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    }
    cell.lab3.text = [NSString stringWithFormat:@"采购单编号：%@",model.purchaseOrderNo];
    
    
    if (model.purchaseOrder_model.plateNumber == nil) {
        cell.lab4.text = [NSString stringWithFormat:@"车牌号：%@",@"-"];
    }else{
        cell.lab4.text = [NSString stringWithFormat:@"车牌号：%@",model.purchaseOrder_model.plateNumber];
    }
    if (model.purchaseOrder_model.sendTime == nil) {
        cell.lab5.text = [NSString stringWithFormat:@"预约到货日期：%@",@"-"];
    }else{
        cell.lab5.text = [NSString stringWithFormat:@"预约到货日期：%@",model.purchaseOrder_model.sendTime];
    }
    cell.lab6.text = [NSString stringWithFormat:@"计划最晚入库日期：%@",model.purchaseOrder_model.planProductionDate];
    
    
    if ([model.stockInStatus isEqualToString:@"created"]) {
        cell.lab7.textColor = [UIColor blackColor];
        cell.lab7.text =@"入库情况：待收货";
    }else  if ([model.stockInStatus isEqualToString:@"working"]) {
         cell.lab7.textColor = [UIColor blackColor];
        cell.lab7.text =@"入库情况：待入库";
    }else  if ([model.stockInStatus isEqualToString:@"finished"]) {
        cell.lab7.textColor = RGBACOLOR(32, 157, 149, 1.0);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"入库情况：已入库"];
        NSRange range = NSMakeRange(0, 5);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab7 setAttributedText:noteStr];
    }else  if ([model.stockInStatus isEqualToString:@"canceled"]) {
         cell.lab7.textColor = [UIColor blackColor];
        cell.lab7.text =@"入库情况：已取消";
    }else  if ([model.stockInStatus isEqualToString:@"returned"]) {
         cell.lab7.textColor = [UIColor blackColor];
        cell.lab7.text =@"入库情况：已退货";
    }
    
    cell.btn.hidden = YES;
    cell.line.hidden = YES;
    return cell;
}
- (void)clickbtn:(UIButton *)sender{
//    XHDD_Cell *cell = (XHDD_Cell *)[[sender superview] superview];
//    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
//    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
//
//    AFHTTPSessionManager *session = [Manager returnsession];
//    __weak typeof(self) weakSelf = self;
//    NSDictionary *dic = [[NSDictionary alloc]init];
//    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
//            @"id":model.id,
//            };
//    [session POST:KURLNSString(@"servlet/order/order/undelivery") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        //                NSLog(@"+++%@",[dic objectForKey:@"message"]);
//        if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[dic objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                [weakSelf setUpReflash];
//            }];
//            [alert addAction:cancel];
//            [weakSelf presentViewController:alert animated:YES completion:nil];
//        }else{
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[dic objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
//            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            }];
//            [alert addAction:cancel];
//            [weakSelf presentViewController:alert animated:YES completion:nil];
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
        XHDSH_details_TableViewController *order = [[XHDSH_details_TableViewController alloc]init];
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
            @"sort":@"stockInOrderNo",
            @"purchaseOrder.purchaseOrderType":@"PIC",
            @"stockInStatus":@"created",
            
            
            @"stockInOrderNo":@"",
            @"orderNo":@"",
            @"purchaseOrderNo":@"",
            @"planProductionBeginTime":@"",
            @"planProductionEndTime":@"",
            @"purchaseOrder.supplierNo":@"",
            };

    [session POST:KURLNSString(@"servlet/stock/stockinorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        
        
        if ([dic objectForKey:@"rows"] != nil && ![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.purchaseOrder];
                model.purchaseOrder_model = model1;
                
                PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.receivePerson_ed];
                model.receivePerson_model = model2;
                
                PaidanModel1 *model3 = [PaidanModel1 mj_objectWithKeyValues:model.forkliftPerson_ed];
                model.forkliftPerson_model = model3;
                
                PaidanModel1 *model4 = [PaidanModel1 mj_objectWithKeyValues:model.purchasePaymentOrder];
                model.purchasePaymentOrder_model = model4;
                [weakSelf.dataArray addObject:model];
            }
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
            @"sort":@"stockInOrderNo",
            @"purchaseOrder.purchaseOrderType":@"PIC",
            @"stockInStatus":@"created",
            
            
            @"stockInOrderNo":@"",
            @"orderNo":@"",
            @"purchaseOrderNo":@"",
            @"planProductionBeginTime":@"",
            @"planProductionEndTime":@"",
            @"purchaseOrder.supplierNo":@"",
            };
    
    
    [session POST:KURLNSString(@"servlet/stock/stockinorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([dic objectForKey:@"rows"] != nil && ![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.purchaseOrder];
                model.purchaseOrder_model = model1;
                
                PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.receivePerson_ed];
                model.receivePerson_model = model2;
                
                PaidanModel1 *model3 = [PaidanModel1 mj_objectWithKeyValues:model.forkliftPerson_ed];
                model.forkliftPerson_model = model3;
                
                PaidanModel1 *model4 = [PaidanModel1 mj_objectWithKeyValues:model.purchasePaymentOrder];
                model.purchasePaymentOrder_model = model4;
                [weakSelf.dataArray addObject:model];
            }
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

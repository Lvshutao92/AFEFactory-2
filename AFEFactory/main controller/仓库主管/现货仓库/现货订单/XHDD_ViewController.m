//
//  XHDD_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/30.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XHDD_ViewController.h"
#import "XHDD_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
#import "XHDD_details_TableViewController.h"
@interface XHDD_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation XHDD_ViewController

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
    [self.tableview registerNib:[UINib nibWithNibName:@"XHDD_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewappear:) name:@"XHDD_appear" object:nil];
}
- (void)viewappear:(NSNotification *)text {
    [self setUpReflash];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model.orderStatus isEqualToString:@"confirmed"]){
        return 250;
    }
    return 210;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    XHDD_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[XHDD_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    cell.lab2.text = [NSString stringWithFormat:@"客户简称：%@",model.dealerName];
    
    
    if ([model.orderStatus isEqualToString:@"confirm"]) {
         cell.lab3.text = @"订单状态：待确认订单";
    }else  if ([model.orderStatus isEqualToString:@"confirmed"]) {
        cell.lab3.text = @"订单状态：已确认订单";
    }else  if ([model.orderStatus isEqualToString:@"production"]) {
        cell.lab3.text = @"订单状态：生产中订单";
    }else  if ([model.orderStatus isEqualToString:@"delivery"]) {
        cell.lab3.text = @"订单状态：已发货订单";
    }else  if ([model.orderStatus isEqualToString:@"cancel"]) {
        cell.lab3.text = @"订单状态：已取消订单";
    }else  if ([model.orderStatus isEqualToString:@"undelivery"]) {
        cell.lab3.text = @"订单状态：待发货订单";
    }
    
    
    
    
    if (model.container == nil) {
        cell.lab4.text = [NSString stringWithFormat:@"集装箱：%@",@"-"];
    }else{
        cell.lab4.text = [NSString stringWithFormat:@"集装箱：%@",model.container];
    }
    
    
    if (model.field7 == nil) {
         cell.lab5.text = [NSString stringWithFormat:@"出货单号：%@",@"-"];
    }else{
         cell.lab5.text = [NSString stringWithFormat:@"出货单号：%@",model.field7];
    }
   
    
    if ([model.orderStatus isEqualToString:@"confirmed"]){
        cell.btn.hidden = NO;
        cell.line.hidden = NO;
    }else{
        cell.btn.hidden = YES;
        cell.line.hidden = YES;
    }
    
    LRViewBorderRadius(cell.btn, 10, 1, [UIColor blackColor]);
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)clickbtn:(UIButton *)sender{
    XHDD_Cell *cell = (XHDD_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];

    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":model.id,
            };
    [session POST:KURLNSString(@"servlet/order/order/undelivery") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //                NSLog(@"+++%@",[dic objectForKey:@"message"]);
        if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[dic objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf setUpReflash];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:[dic objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    XHDD_details_TableViewController *order = [[XHDD_details_TableViewController alloc]init];
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
            @"sort":@"createTime",
            @"orderNo":@"",
            @"dealerName":@"",
            @"field7":@"",
            @"orderStatus":@"",
            };

    [session POST:KURLNSString(@"servlet/order/trade/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//          NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        if ([dic objectForKey:@"rows"] != nil && ![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
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
            @"sort":@"createTime",
            @"orderNo":@"",
            @"dealerName":@"",
            @"field7":@"",
            @"orderStatus":@"",
            };
    
    [session POST:KURLNSString(@"servlet/order/trade/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([dic objectForKey:@"rows"] != nil && ![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
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

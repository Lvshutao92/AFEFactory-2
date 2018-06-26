//
//  PiLiang_B_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/3.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "PiLiang_B_ViewController.h"
#import "SY_11_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"

#import "Edit_ChaCheGong_ViewController.h"
@interface PiLiang_B_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation PiLiang_B_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-0)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"SY_11_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    [self setUpReflash];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    SY_11_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[SY_11_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LRViewBorderRadius(cell.btn, 10, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn1, 10, 1, [UIColor blackColor]);
    cell.btn2.hidden  = YES;
    cell.lab8.hidden  = YES;
    cell.lab9.hidden  = YES;
    cell.lab10.hidden = YES;
    cell.lab11.hidden = YES;
    [cell.btn setTitle:@"选择叉车工" forState:UIControlStateNormal];
    [cell.btn1 setTitle:@"确认入库" forState:UIControlStateNormal];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = [NSString stringWithFormat:@"入库单号：%@",model.storageNo];
    cell.lab2.text = [NSString stringWithFormat:@"FCNO：%@",model.fcno];
    cell.lab3.text = [NSString stringWithFormat:@"产品数量：%@",model.quantity];
    cell.lab4.text = [NSString stringWithFormat:@"生产单号：%@",model.productionOrderNo];
    cell.lab5.text = [NSString stringWithFormat:@"领料单号：%@",model.pickOrderNo];
    cell.lab6.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    cell.lab7.text = [NSString stringWithFormat:@"叉车工：%@",model.forkliftPersonId];
    
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)clickbtn:(UIButton *)sender{
    SY_11_Cell *cell = (SY_11_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
//    Edit_ChaCheGong_ViewController *chachegong = [[Edit_ChaCheGong_ViewController alloc]init];
//    chachegong.idstr = model.id;
//    if (model.orderNo == nil) {
//        chachegong.lab1str = @"";
//    }else{
//        chachegong.lab1str = model.orderNo;
//    }
//    if (model.stockInOrderNo == nil) {
//        chachegong.lab2str = @"";
//    }else{
//        chachegong.lab2str = model.stockInOrderNo;
//    }
//    if (model.purchaseOrderNo == nil) {
//        chachegong.lab3str = @"";
//    }else{
//        chachegong.lab3str = model.purchaseOrderNo;
//    }
//    if (model.purchaseOrder_model.supplierNo == nil) {
//        chachegong.lab4str = @"";
//    }else{
//        chachegong.lab4str = model.purchaseOrder_model.supplierNo;
//    }
//    if (model.forkliftPerson_model.personCode == nil) {
//        chachegong.textstr   = @"";
//        chachegong.textidstr = @"";
//    }else{
//        chachegong.textstr   = [NSString stringWithFormat:@"%@ %@",model.forkliftPerson_model.personCode,model.forkliftPerson_model.realName];;
//        chachegong.textidstr = model.purchaseOrder_model.forkliftPersonId;
//    }
//    [self.navigationController pushViewController:chachegong animated:YES];
}
- (void)clickbtn1:(UIButton *)sender{
    SY_11_Cell *cell = (SY_11_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    //    SYDJ_details_Controller *details = [[SYDJ_details_Controller alloc]init];
    //    details.navigationItem.title = @"工价详情";
    //    details.idstr = model.id;
    //    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    //    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    //    [Nav pushViewController:details animated:YES];
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
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    [session POST:KURLNSString(@"servlet/production/productionorderstorage/work/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
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
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    [session POST:KURLNSString(@"servlet/production/productionorderstorage/work/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        if (![[diction objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [diction objectForKey:@"rows"];
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

//
//  PaiDan_dwcd_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/21.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PaiDan_dwcd_ViewController.h"
#import "DWC_10_Cell.h"
#import "PaiDanModel.h"
#import "SYDJ_details_Controller.h"

#import "XZXZ_ViewController.h"
#import "LLPF_ViewController.h"
@interface PaiDan_dwcd_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation PaiDan_dwcd_ViewController


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
    [self.tableview registerNib:[UINib nibWithNibName:@"DWC_10_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    [self loddeList];
}
- (void)viewWillAppear:(BOOL)animated{
    [self loddeList];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 360;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    DWC_10_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[DWC_10_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LRViewBorderRadius(cell.btn, 10, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn1, 10, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn2, 10, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn3, 10, 1, [UIColor blackColor]);
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];

    cell.lab1.text = [NSString stringWithFormat:@"计划日期：%@",model.productionDate];
    cell.lab2.text = [NSString stringWithFormat:@"FCNO：%@",model.fcno];
    cell.lab3.text = [NSString stringWithFormat:@"数量：%@",model.quantity];
    cell.lab4.text = [NSString stringWithFormat:@"生产单号：%@",model.productionOrderNo];
    cell.lab5.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];

    if ([model.status isEqualToString:@"create"]) {
        cell.lab6.textColor = [UIColor blueColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"单据状态：待生产"];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab6 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"producting"]) {
        cell.lab6.textColor = [UIColor greenColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"单据状态：生产中"];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab6 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"producted"]) {
        cell.lab6.textColor = [UIColor redColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"单据状态：已完成"];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab6 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"finished"]) {
        cell.lab6.textColor = RGBACOLOR(32, 157, 149, 1.0);
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"单据状态：已入库"];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab6 setAttributedText:noteStr2];
    }

    if (model.searchMaterialPerson == nil) {
        cell.lab7.text = [NSString stringWithFormat:@"备料人：%@",@"-"];
    }else{
        cell.lab7.text = [NSString stringWithFormat:@"备料人：%@",model.searchMaterialPerson];
    }
    

    if ([model.searchMaterialStatus isEqualToString:@"create"]) {
        cell.lab8.text = @"备料状态：待领料";
    }else if ([model.searchMaterialStatus isEqualToString:@"picking"]) {
        cell.lab8.text = @"备料状态：领料中";
    }else if ([model.searchMaterialStatus isEqualToString:@"picked"]) {
        cell.lab8.text = @"备料状态：已领料";
    }else if ([model.searchMaterialStatus isEqualToString:@"delivery"]) {
        cell.lab8.text = @"备料状态：已出库";
    }

    if ([model.searchMaterialScore isEqualToString:@"正常"]) {
        cell.lab9.textColor = [UIColor greenColor];
    }else if ([model.searchMaterialScore isEqualToString:@"少料"]) {
        cell.lab9.textColor = [UIColor lightGrayColor];
    }else if ([model.searchMaterialScore isEqualToString:@"多料"]) {
        cell.lab9.textColor = [UIColor redColor];
    }
    if (model.searchMaterialScore == nil) {
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"领料评分：%@",@"-"]];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab9 setAttributedText:noteStr2];
    }else{
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"领料评分：%@",model.searchMaterialScore]];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab9 setAttributedText:noteStr2];
    }
    

    
        if (model.field1 == nil || [model.field1 isEqualToString:@"N"]) {
            cell.lab10.textColor = RGBACOLOR(32, 157, 149, 1.0);
            NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"生产情况：正在生产中"];
            NSRange range2 = NSMakeRange(0, 5);
            [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
            [cell.lab10 setAttributedText:noteStr2];
        }else{
            cell.lab10.textColor = [UIColor redColor];
            NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"生产情况：已暂停生产"];
            NSRange range2 = NSMakeRange(0, 5);
            [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
            [cell.lab10 setAttributedText:noteStr2];
        }
    
    
    
    
    

    if ([model.status isEqualToString:@"producting"]) {
        cell.btn1.hidden = NO;
        cell.btn1you.constant = 10;
        cell.btn1width.constant = 70;
    }else{
        cell.btn1.hidden = YES;
        cell.btn1you.constant = 0;
        cell.btn1width.constant = 0;
    }
    
    
    if ([model.status isEqualToString:@"producting"] && [model.searchMaterialStatus isEqualToString:@"delivery"]) {
        cell.btn2.hidden = NO;
        cell.btn1zuo.constant = 10;
        cell.btn2width.constant = 70;
    }else{
        cell.btn2.hidden = YES;
        cell.btn1zuo.constant = 0;
        cell.btn2width.constant = 0;
    }
    
    
    if ([model.status isEqualToString:@"producting"] && [model.searchMaterialStatus isEqualToString:@"delivery"] && model.searchMaterialScore != nil ) {
        cell.btn3.hidden = NO;
        cell.btn2zuo.constant = 10;
        cell.btn3width.constant = 70;
    }else{
        cell.btn3.hidden = YES;
        cell.btn2zuo.constant = 0;
        cell.btn3width.constant = 0;
    }
    
    
    
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 addTarget:self action:@selector(clickbtn2:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn3 addTarget:self action:@selector(clickbtn3:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)clickbtn:(UIButton *)sender{
    DWC_10_Cell *cell = (DWC_10_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];

    SYDJ_details_Controller *details = [[SYDJ_details_Controller alloc]init];
    details.navigationItem.title = @"工价详情";
    details.idstr = model.id;
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:details animated:YES];
}
- (void)clickbtn1:(UIButton *)sender{
    DWC_10_Cell *cell = (DWC_10_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    XZXZ_ViewController *details = [[XZXZ_ViewController alloc]init];
    details.navigationItem.title = @"选择小组";
    details.idstr = model.id;
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:details animated:YES];
}
- (void)clickbtn2:(UIButton *)sender{
    DWC_10_Cell *cell = (DWC_10_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];

    LLPF_ViewController *details = [[LLPF_ViewController alloc]init];
    details.navigationItem.title = @"领料评分";
    details.idstr = model.id;
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:details animated:YES];
}
- (void)clickbtn3:(UIButton *)sender{
    
    
    
    
    DWC_10_Cell *cell = (DWC_10_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"userId":[Manager redingwenjianming:@"userid.text"],
            @"id":model.id,
            };
//    NSLog(@"+++%@",dic);
    [session POST:KURLNSString(@"servlet/production/productionorder/myorder/producted") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"+++%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf loddeList];
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
//    [self.tableview.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
//    page = 1;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"userId":[Manager redingwenjianming:@"userid.text"],
            @"order":@"asc",
            @"sort":@"grabDate",
            };
    [session POST:KURLNSString(@"servlet/production/productionorder/myorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
//        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"list"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
//        page = 2;
        [weakSelf.tableview reloadData];
//        [weakSelf.tableview.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [weakSelf.tableview.mj_header endRefreshing];
    }];
}
- (void)loddeSLList{
    [self.tableview.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"order":@"asc",
            @"sort":@"grabDate",
            };
    [session POST:KURLNSString(@"servlet/production/productionorder/myorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[diction objectForKey:@"rows"] objectForKey:@"list"];
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

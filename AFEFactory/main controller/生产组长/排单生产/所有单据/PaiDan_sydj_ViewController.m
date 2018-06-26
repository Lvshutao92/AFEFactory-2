//
//  PaiDan_sydj_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PaiDan_sydj_ViewController.h"
#import "SY_11_Cell.h"
#import "PaiDanModel.h"
#import "SYDJ_details_Controller.h"
@interface PaiDan_sydj_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation PaiDan_sydj_ViewController

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
    [self.tableview registerNib:[UINib nibWithNibName:@"SY_11_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    [self setUpReflash];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 390;
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
    
    
    
    if (model.field4==nil) {
        cell.lab7.text = [NSString stringWithFormat:@"接单人：%@",@"-"];
    }else{
        cell.lab7.text = [NSString stringWithFormat:@"接单人：%@",model.field4];
    }
    
    
    
    cell.lab8.text = [NSString stringWithFormat:@"备料人：%@",model.searchMaterialPerson];
    
    
    if ([model.searchMaterialStatus isEqualToString:@"create"]) {
        cell.lab9.text = @"备料状态：待领料";
    }else if ([model.searchMaterialStatus isEqualToString:@"picking"]) {
        cell.lab9.text = @"备料状态：领料中";
    }else if ([model.searchMaterialStatus isEqualToString:@"picked"]) {
        cell.lab9.text = @"备料状态：已领料";
    }else if ([model.searchMaterialStatus isEqualToString:@"delivery"]) {
        cell.lab9.text = @"备料状态：已出库";
    }
    
    
    
    if ([model.searchMaterialScore isEqualToString:@"正常"]) {
        cell.lab10.textColor = [UIColor greenColor];
    }else if ([model.searchMaterialScore isEqualToString:@"少料"]) {
        cell.lab10.textColor = [UIColor lightGrayColor];
    }else if ([model.searchMaterialScore isEqualToString:@"多料"]) {
        cell.lab10.textColor = [UIColor redColor];
    }else if (model.searchMaterialScore == nil) {
        cell.lab10.textColor = [UIColor blackColor];
        model.searchMaterialScore = @"-";
    }
    NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"领料评分：%@",model.searchMaterialScore]];
    NSRange range2 = NSMakeRange(0, 5);
    [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
    [cell.lab10 setAttributedText:noteStr2];
    
    
    
    if (model.remark == nil) {
        cell.lab11.text = [NSString stringWithFormat:@"生产情况：%@",@"-"];
    }else{
        cell.lab11.text = [NSString stringWithFormat:@"生产情况：%@",model.remark];
    }
    
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

- (void)clickbtn:(UIButton *)sender{
    SY_11_Cell *cell = (SY_11_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    SYDJ_details_Controller *details = [[SYDJ_details_Controller alloc]init];
    details.navigationItem.title = @"工价详情";
    details.idstr = model.id;
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:details animated:YES];
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
            @"sort":@"productionDate",
            
            @"productionOrderNo":@"",
            @"orderNo":@"",
            @"productionDate":@"",
            @"fcno":@"",
            @"status":@"",
            };
    [session POST:KURLNSString(@"servlet/production/productionorder/all/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"list"];
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
            @"sort":@"productionDate",
            
            @"productionOrderNo":@"",
            @"orderNo":@"",
            @"productionDate":@"",
            @"fcno":@"",
            @"status":@"",
            };
    [session POST:KURLNSString(@"servlet/production/productionorder/all/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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

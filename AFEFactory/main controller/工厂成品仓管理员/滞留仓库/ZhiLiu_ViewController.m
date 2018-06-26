//
//  ZhiLiu_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/2.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "ZhiLiu_ViewController.h"
#import "SYLLD_8_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
#import "ZhiLiu_details_TableViewController.h"
@interface ZhiLiu_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    CGFloat hei;
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UIView *window;
    UIScrollView *bgview;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation ZhiLiu_ViewController

- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"退库订单";
    UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bars;
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-0)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"SYLLD_8_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    [self setupview1];
}
- (void)clicksearch{
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text1 resignFirstResponder];
    [text4 resignFirstResponder];
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    if ( window.hidden == YES) {
        window.hidden = NO;
    }else{
        window.hidden = YES;
    }
}
- (void)setupview1{
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    window = [[UIView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT-height)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    bgview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    bgview.backgroundColor = [UIColor whiteColor];
    bgview.userInteractionEnabled = YES;
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 40)];
    lab1.text = @"订单编号";
    [bgview addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入订单编号";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [bgview addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"客户简称";
    [bgview addSubview:lab2];
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"请输入客户简称";
    [bgview addSubview: text2];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    lab3.text = @"出货单号";
    [bgview addSubview:lab3];
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.placeholder = @"请输入出货单号";
    [bgview addSubview: text3];
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 290, SCREEN_WIDTH-20, 40)];
    lab4.text = @"批量订单号";
    [bgview addSubview:lab4];
    text4 = [[UITextField alloc] initWithFrame:CGRectMake(10, 335, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    text4.placeholder = @"请输入批量订单号";
    [bgview addSubview: text4];
    
    
    
    
    bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-249);
    //    bgview.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
    [window addSubview:bgview];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-250, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-249.5, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-250,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    [self setUpReflash];
}
- (void)cancle{
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text1 resignFirstResponder];
    [text4 resignFirstResponder];
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    
    window.hidden = YES;
}
- (void)sure{
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text1 resignFirstResponder];
    [text4 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    window.hidden = YES;
    [self setUpReflash];
}


















- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250+hei;
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
    cell.lab7.hidden = YES;
    cell.lab8.hidden = YES;
    
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    cell.lab2.text = [NSString stringWithFormat:@"客户简称：%@",model.dealerName];
    cell.lab3.text = [NSString stringWithFormat:@"创建日期：%@",model.createTime];
    
    

    if ([model.orderStatus isEqualToString:@"confirm"]) {
        cell.lab4.text = @"订单状态：待确认订单";
    }
    else  if ([model.orderStatus isEqualToString:@"confirmed"]) {
        cell.lab4.text = @"订单状态：已确认订单";
    }
    else  if ([model.orderStatus isEqualToString:@"production"]) {
        cell.lab4.text = @"订单状态：生产中订单";
    }
    else  if ([model.orderStatus isEqualToString:@"delivery"]) {
        cell.lab4.text = @"订单状态：已发货订单";
    }
    else  if ([model.orderStatus isEqualToString:@"cancel"]) {
        cell.lab4.text = @"订单状态：已取消订单";
    }
    else  if ([model.orderStatus isEqualToString:@"undelivery"]) {
        cell.lab4.text = @"订单状态：待发货订单";
    }
    
    
    
    cell.lab5.text = [NSString stringWithFormat:@"批量订单号：%@",model.field11];
    
    if (model.field7 == nil) {
        cell.lab6.text = [NSString stringWithFormat:@"出货单号：%@",@"-"];
    }else{
        cell.lab6.text = [NSString stringWithFormat:@"出货单号：%@",model.field7];
    }
    
 
    
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    ZhiLiu_details_TableViewController *order = [[ZhiLiu_details_TableViewController alloc]init];
    order.idstr = model.id;
    order.navigationItem.title = @"详情";
    [self.navigationController pushViewController:order animated:YES];
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
            
            @"orderNo":text1.text,
            @"dealerName":text2.text,
            @"field7":text3.text,
            @"field11":text4.text,
            };
    [session POST:KURLNSString(@"servlet/order/back/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//          NSLog(@"guowai----%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
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
            @"sorttype":@"desc",
            @"sort":@"createTime",
            
            @"orderNo":text1.text,
            @"dealerName":text2.text,
            @"field7":text3.text,
            @"field11":text4.text,
            };
    [session POST:KURLNSString(@"servlet/order/back/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
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

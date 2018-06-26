//
//  PaiDan_pdjh_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PaiDan_pdjh_ViewController.h"
#import "Paidan_5_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
#import "PaidanModel2.h"

#import "PDJH_details_ViewController.h"
#import "Details_1_ViewController.h"
#import "Details_2_ViewController.h"
#import "Details_3_ViewController.h"


@interface PaiDan_pdjh_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    UIView *vie;
    
    BOOL isorno;
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
    UILabel *lab4;
    UILabel *lab5;
    NSString *string1;
    NSString *string2;
    NSString *string3;
    NSString *string4;
    NSString *string5;
    
    UILabel *lines;
    UIImageView *img;
    
    CGFloat hei;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation PaiDan_pdjh_ViewController

- (void)lodd{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/production/productionplan") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        NSDictionary *dict = [dic objectForKey:@"rows"];
       
        NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"每日正常产量：%@",[[dict objectForKey:@"productionConfig"]objectForKey:@"normalOutput"]]];
        NSRange range1 = NSMakeRange(0, 7);
        [noteStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        [lab1 setAttributedText:noteStr1];
        
        
       
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"每日加班产量：%@",[[dict objectForKey:@"productionConfig"]objectForKey:@"overtimeOutput"]]];
        NSRange range2 = NSMakeRange(0, 7);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [lab2 setAttributedText:noteStr2];
        
        
        NSMutableAttributedString *noteStr3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"允许插单最早日期：%@，如遇休息日，则顺延",[dict objectForKey:@"productionConfigstartDate"]]];
        NSRange range3 = NSMakeRange(0, 9);
        [noteStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range3];
        [lab3 setAttributedText:noteStr3];
        
        
        
        NSMutableAttributedString *noteStr4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已排计划最晚日期：%@",[dict objectForKey:@"productionConfigendDate"]]];
        NSRange range4 = NSMakeRange(0, 9);
        [noteStr4 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range4];
        [lab4 setAttributedText:noteStr4];
        
        
        NSMutableAttributedString *noteStr5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"最近休息计划：%@",[dict objectForKey:@"holidayStr"]]];
        NSRange range5 = NSMakeRange(0, 7);
        [noteStr5 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range5];
        [lab5 setAttributedText:noteStr5];
        
        lab5.font = [UIFont systemFontOfSize:13];
        lab5.numberOfLines = 0;
        lab5.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [lab5 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
        hei = size.height;

        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 108.3, SCREEN_WIDTH, 5)];
    lab.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [self.view addSubview:lab];
    [self lodd];
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
    [self.tableview registerNib:[UINib nibWithNibName:@"Paidan_5_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    
    [self setuptopview];
    
    [self setUpReflash];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewappear:) name:@"appear" object:nil];
}
- (void)viewappear:(NSNotification *)text {
    [self setUpReflash];
    [self lodd];
}

- (void)setuptopview{
    vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 47)];
    lable.text = @"排单说明";
    lable.font = [UIFont systemFontOfSize:18];
    lable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickinfor:)];
    [lable addGestureRecognizer:tap];
    [vie addSubview:lable];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 47, SCREEN_WIDTH, 3)];
    line.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [vie addSubview:line];
    self.tableview.tableHeaderView = vie;
    
    img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 15, 20, 20)];
    img.image = [UIImage imageNamed:@"jiantou"];
    [vie addSubview:img];
    
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, SCREEN_WIDTH-20, 20)];
    lab1.hidden = YES;
    lab1.font = [UIFont systemFontOfSize:13];
    lab1.textColor = [UIColor redColor];
    [vie addSubview:lab1];
    
    lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH-20, 20)];
    lab2.hidden = YES;
    lab2.font = [UIFont systemFontOfSize:13];
    lab2.textColor = [UIColor redColor];
    [vie addSubview:lab2];
    
    lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 105, SCREEN_WIDTH-20, 20)];
    lab3.hidden = YES;
    lab3.font = [UIFont systemFontOfSize:13];
    lab3.textColor = [UIColor redColor];
    [vie addSubview:lab3];
    
    lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, SCREEN_WIDTH-20, 20)];
    lab4.hidden = YES;
    lab4.font = [UIFont systemFontOfSize:13];
    lab4.textColor = [UIColor redColor];
    [vie addSubview:lab4];
    
    lab5 = [[UILabel alloc]init];
    lab5.hidden = YES;
    lab5.font = [UIFont systemFontOfSize:13];
    lab5.textColor = [UIColor redColor];
    [vie addSubview:lab5];
    
    lines = [[UILabel alloc]init];
    lines.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    lines.hidden = YES;
    [vie addSubview:lines];
    
    
}
- (void)clickinfor:(UITapGestureRecognizer *)sender{
    if (isorno == NO) {
        lab5.frame = CGRectMake(10, 155, SCREEN_WIDTH-40, hei);
        [vie addSubview:lab5];
        
        lines.frame = CGRectMake(0, 160+hei, SCREEN_WIDTH, 3);
        [vie addSubview:lines];
        
        vie.frame = CGRectMake(0, 0, SCREEN_WIDTH, 163+hei);
        self.tableview.tableHeaderView = vie;
       
        lab1.hidden = NO;
        lab2.hidden = NO;
        lab3.hidden = NO;
        lab4.hidden = NO;
        lab5.hidden = NO;
        lines.hidden = NO;
        
        img.image = [UIImage imageNamed:@"jiantou1"];
        [vie addSubview:img];
    }else{
        vie.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        self.tableview.tableHeaderView = vie;
        
        lab1.hidden = YES;
        lab2.hidden = YES;
        lab3.hidden = YES;
        lab4.hidden = YES;
        lab5.hidden = YES;
        lines.hidden = YES;
        img.image = [UIImage imageNamed:@"jiantou"];
        [vie addSubview:img];
    }
    isorno = !isorno;
}







- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 295;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    Paidan_5_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[Paidan_5_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"计划日期：%@",model.planDate];
    cell.lab2.text = [NSString stringWithFormat:@"公司名称：%@",model.oeder_model.dealerName];
    cell.lab3.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    cell.lab4.text = [NSString stringWithFormat:@"订单总量：%@",model.totalQuantity];
    
    
//    if (model.purchasePlan != nil) {
//        if ([model.purchasePlan_model.orderStatus isEqualToString:@"created"]) {
//            LRViewBorderRadius(cell.lab6, 5, 0, RGBACOLOR(46, 165, 204, 0.41));
//            cell.lab6.backgroundColor = RGBACOLOR(46, 165, 204, 0.41);
//        }else{
//            LRViewBorderRadius(cell.lab6, 5, 0, RGBACOLOR(46, 165, 204, 0.41));
//            cell.lab6.backgroundColor = RGBACOLOR(46, 165, 204, 0.41);
//            LRViewBorderRadius(cell.lab7, 5, 0, RGBACOLOR(46, 165, 204, 0.41));
//            cell.lab7.backgroundColor = RGBACOLOR(46, 165, 204, 0.41);
//        }
//    }
    if (model.purchasePlan != nil) {
        if ([model.purchasePlan_model.orderStatus isEqualToString:@"created"]) {
            LRViewBorderRadius(cell.lab6, 5, 0, RGBACOLOR(46, 165, 204, 0.41));
            cell.lab6.backgroundColor = RGBACOLOR(46, 165, 204, 0.41);
            cell.lab6.textColor = [UIColor whiteColor];
            
            cell.lab7.textColor = [UIColor orangeColor];
            LRViewBorderRadius(cell.lab7, 5, 2, [UIColor orangeColor]);
        }else{
            LRViewBorderRadius(cell.lab6, 5, 0, RGBACOLOR(46, 165, 204, 0.41));
            cell.lab6.backgroundColor = RGBACOLOR(46, 165, 204, 0.41);
            LRViewBorderRadius(cell.lab7, 5, 0, [UIColor orangeColor]);
            cell.lab7.backgroundColor = [UIColor orangeColor];
            
            cell.lab6.textColor = [UIColor whiteColor];
            cell.lab7.textColor = [UIColor whiteColor];
        }
    }else {
        cell.lab6.backgroundColor = [UIColor whiteColor];
        cell.lab7.backgroundColor = [UIColor whiteColor];
        cell.lab8.backgroundColor = [UIColor whiteColor];
        
        
        cell.lab6.textColor = RGBACOLOR(46, 165, 204, 0.41);
        LRViewBorderRadius(cell.lab6, 5, 2, RGBACOLOR(46, 165, 204, 0.41));
        
        cell.lab7.textColor = [UIColor orangeColor];
        LRViewBorderRadius(cell.lab7, 5, 2, [UIColor orangeColor]);
    }
    cell.lab8.textColor = [UIColor redColor];
    LRViewBorderRadius(cell.lab8, 5, 2, [UIColor redColor]);
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    PDJH_details_ViewController *vc = [[PDJH_details_ViewController alloc] initWithAddVCARY:@[[Details_1_ViewController new],[Details_2_ViewController new],[Details_3_ViewController new]] TitleS:@[@"订单明细",@"部件列表",@"操作日志"]];
    
    
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"orderNo":model.orderNo,@"orderId":model.orderId};
    NSNotification *notification =[NSNotification notificationWithName:@"details" object:nil userInfo:dict];
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
            @"sorttype":@"asc",
            @"sort":@"planDate,seq",
            @"order.dealerName":@"",
            @"orderNo":@"",
            @"planDate":@"",
            };
    [session POST:KURLNSString(@"servlet/production/productionplan/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
                //NSLog(@"%@",dic);
                totalnum = [[dic objectForKey:@"total"] integerValue];
                [weakSelf.dataArray removeAllObjects];
                NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
                for (NSDictionary *dict in arr) {
                    PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
        
                    PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.order];
                    model.oeder_model = model1;
        
                    PaidanModel2 *model2 = [PaidanModel2 mj_objectWithKeyValues:model.purchasePlan];
                    model.purchasePlan_model = model2;
                    
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
            @"sorttype":@"asc",
            @"sort":@"planDate,seq",
            @"order.dealerName":@"",
            @"orderNo":@"",
            @"planDate":@"",
            };
    [session POST:KURLNSString(@"servlet/production/productionplan/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[diction objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.order];
            model.oeder_model = model1;
            
            PaidanModel2 *model2 = [PaidanModel2 mj_objectWithKeyValues:model.purchasePlan];
            model.purchasePlan_model = model2;
            
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

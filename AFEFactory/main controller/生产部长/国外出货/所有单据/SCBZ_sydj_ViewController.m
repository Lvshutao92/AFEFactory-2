//
//  SCBZ_sydj_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/7.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SCBZ_sydj_ViewController.h"
#import "SYLLD_8_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface SCBZ_sydj_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    CGFloat hei;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation SCBZ_sydj_ViewController

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
    [self.tableview registerNib:[UINib nibWithNibName:@"SYLLD_8_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewappear:) name:@"guowai_appear" object:nil];
}
- (void)viewappear:(NSNotification *)text {
    [self setUpReflash];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 310+hei;
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
    cell.lab1.text = [NSString stringWithFormat:@"出货单号：%@",model.exportNo];
    cell.lab2.text = [NSString stringWithFormat:@"客户名称：%@",model.dealerName];
    cell.lab3.text = [NSString stringWithFormat:@"申请出货日期：%@",model.planShipmentDate];

    if (model.actualDate == nil) {
        cell.lab4.text = [NSString stringWithFormat:@"实际出货日期：%@",@"-"];
    }else{
        cell.lab4.text = [NSString stringWithFormat:@"实际出货日期：%@",model.actualDate];
    }
    
    

    
    
    if (model.field8 == nil) {
        cell.lab5.text = [NSString stringWithFormat:@"提货人信息：%@",@"-"];
    }else{
        NSData *jsonData = [model.field8 dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        if ([dic objectForKey:@"cardNo"] != nil) {
            cell.lab5.text = [NSString stringWithFormat:@"提货人信息：%@ %@ %@",[dic objectForKey:@"cardNo"],[dic objectForKey:@"contact"],[dic objectForKey:@"phone"]];
        }else{
            cell.lab5.text = [NSString stringWithFormat:@"提货人信息：%@",@"-"];
        }
        
    }
    cell.lab5.numberOfLines = 0;
    cell.lab5.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab5 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    cell.lab5height.constant = size.height;
    hei = size.height;
    
    
    
    
    
    if (model.actualDate == nil) {
        cell.lab6.text = [NSString stringWithFormat:@"预计提货日期：%@",@"-"];
    }else{
        cell.lab6.text = [NSString stringWithFormat:@"预计提货日期：%@",model.actualDate];
    }

    
    
    if ([model.status isEqualToString:@"pending"]) {
        cell.lab7.textColor = [UIColor magentaColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"出货状态：待出货"];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab7 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"finish"]) {
        cell.lab7.textColor = [UIColor blueColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"出货状态：已完成"];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab7 setAttributedText:noteStr2];
    }else if ([model.status isEqualToString:@"create"]) {
        cell.lab7.textColor = [UIColor orangeColor];
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:@"出货状态：已申请"];
        NSRange range2 = NSMakeRange(0, 5);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [cell.lab7 setAttributedText:noteStr2];
    }


    
   
    if (model.serviceCompanyName == nil) {
        cell.lab8.text = [NSString stringWithFormat:@"装卸服务商：%@",@"-"];
    }else{
        cell.lab8.text = [NSString stringWithFormat:@"装卸服务商：%@",model.serviceCompanyName];
    }
    return cell;
}







- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
//    SYLLD_details_TableViewController *order = [[SYLLD_details_TableViewController alloc]init];
//    order.purchaseOrderId = model.id;
//    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
//    [Nav pushViewController:order animated:YES];
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
            
            @"exportNo":@"",
            };
    [session POST:KURLNSString(@"servlet/shipment/exportorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"guowai----%@",dic);
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
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"exportNo":@"",
            };
    [session POST:KURLNSString(@"servlet/shipment/exportorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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

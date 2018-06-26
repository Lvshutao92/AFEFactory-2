//
//  SCBZ_YSQ_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/7.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SCBZ_YSQ_ViewController.h"
#import "DSC_5_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"

@interface SCBZ_YSQ_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    CGFloat heis;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation SCBZ_YSQ_ViewController

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
    [self.tableview registerNib:[UINib nibWithNibName:@"DSC_5_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190+heis;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    DSC_5_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[DSC_5_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"出货单号：%@",model.exportNo];
    cell.lab2.text = [NSString stringWithFormat:@"客户名称：%@",model.dealerName];
    cell.lab3.text = [NSString stringWithFormat:@"申请出货日期：%@",model.planShipmentDate];

    
    
    
    if (model.field8 == nil) {
        cell.lab4.text = @"提货人信息：-";
    }else{
        NSData *jsonData = [model.field8 dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        if ([dic objectForKey:@"cardNo"] != nil) {
            cell.lab4.text = [NSString stringWithFormat:@"提货人信息：%@ %@ %@",[dic objectForKey:@"cardNo"],[dic objectForKey:@"contact"],[dic objectForKey:@"phone"]];
        }else{
            cell.lab4.text = @"提货人信息：-";
        }

    }
    cell.lab4.numberOfLines = 0;
    cell.lab4.lineBreakMode = NSLineBreakByWordWrapping;
    cell.lab4.font = [UIFont systemFontOfSize:16];
    CGSize size = [cell.lab4 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    cell.lab4height.constant = size.height;
    heis = size.height;
    
    
    
    

    
    if (model.field8 == nil) {
        cell.lab5.text = [NSString stringWithFormat:@"预计提货日期：%@",@"-"];
    }else{
        NSData *jsonData = [model.field8 dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:nil];
        
        if ([dic objectForKey:@"deliveryDate"] == nil) {
            cell.lab5.text = [NSString stringWithFormat:@"预计提货日期：%@",@"-"];
        }else{
            cell.lab5.text = [NSString stringWithFormat:@"预计提货日期：%@",[dic objectForKey:@"deliveryDate"]];
        }
        
        
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
            @"status":@"create",
            
            
            @"exportNo":@"",
            };
    [session POST:KURLNSString(@"servlet/shipment/exportorder/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"guowai----%@",dic);
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
            @"status":@"create",
            
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

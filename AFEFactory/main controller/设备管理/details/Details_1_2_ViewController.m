//
//  Details_1_2_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/24.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "Details_1_2_ViewController.h"
#import "SY_11_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface Details_1_2_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSString *idstring;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableView;

@end

@implementation Details_1_2_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 108.3, SCREEN_WIDTH, 5)];
    lab.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [self.view addSubview:lab];
    
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SY_11_Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableView];
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(details:) name:@"wdsb" object:nil];
}
- (void)details:(NSNotification *)text{
    NSDictionary *dic = text.userInfo;
    idstring = [dic objectForKey:@"idstring"];
    [self setUpReflash];
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 350;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"cell1";
    SY_11_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[SY_11_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"保养申请编号：%@",model.maintainNo];
    cell.lab2.text = [NSString stringWithFormat:@"设备编号：%@",model.equipment_model.equipmentNo];
    cell.lab3.text = [NSString stringWithFormat:@"保养开始时间：%@",model.startTime];
    
    cell.lab4.text = [NSString stringWithFormat:@"发起人：%@",model.departmentPerson_model.realName];
    cell.lab5.text = [NSString stringWithFormat:@"设备维修商：%@",model.equipmentSupplier_model.supplierName];
    cell.lab6.text = [NSString stringWithFormat:@"保养内容：%@",model.content];
    
    cell.lab7.text = [NSString stringWithFormat:@"保养结束时间：%@",model.endTime];
    
    
    if (model.checkName == nil) {
        cell.lab8.text = @"确认人：-";
    }else {
        cell.lab8.text = [NSString stringWithFormat:@"确认人：%@",model.checkName];
    }
    
    if (model.cost == nil) {
        cell.lab9.text = @"保养成本：-";
    }else{
        cell.lab9.text = [NSString stringWithFormat:@"保养成本：%@",model.cost];
    }
   
    
    
    
    
    cell.lab10.text = [NSString stringWithFormat:@"保养情况描述：%@",model.mainContent];
    
    
    if ([model.status isEqualToString:@"A"]) {
        cell.lab11.text = @"新建";
        cell.lab11.textColor = [UIColor greenColor];
    }else if ([model.status isEqualToString:@"B"]) {
        cell.lab11.text = @"已审核";
        cell.lab11.textColor = [UIColor blackColor];
    }else if ([model.status isEqualToString:@"C"]) {
        cell.lab11.text = @"未通过";
        cell.lab11.textColor = RGBACOLOR(37, 167, 159, 1);
    }else if ([model.status isEqualToString:@"D"]) {
        cell.lab11.text = @"维修成功";
        cell.lab11.textColor = [UIColor blueColor];
    }else if ([model.status isEqualToString:@"E"]) {
        cell.lab11.text = @"维修失败";
        cell.lab11.textColor = [UIColor redColor];
    }else if ([model.status isEqualToString:@"F"]) {
        cell.lab11.text = @"已生成付款单";
        cell.lab11.textColor = RGBACOLOR(0, 229, 238, 1);
    }
    
    
    cell.btn.hidden = YES;
    cell.line.hidden = YES;
    return cell;
}



//刷新数据
-(void)setUpReflash
{
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loddeList];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.dataArray.count == totalnum) {
            [self.tableView.mj_footer setState:MJRefreshStateNoMoreData];
        }else {
            [weakSelf loddeSLList];
        }
    }];
}
- (void)loddeList{
    [self.tableView.mj_footer endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    page = 1;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"equipmentId":idstring,
            @"sorttype":@"asc",
            @"sort":@"undefined",
            @"page":[NSString stringWithFormat:@"%ld",page],

            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentmaintain/mylist") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                    NSLog(@"guowai----%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.equipment];
                model.equipment_model = model1;
                
                PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.departmentPerson];
                model.departmentPerson_model = model2;
                
                PaidanModel1 *model3 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentSupplier];
                model.equipmentSupplier_model = model3;
                
                [weakSelf.dataArray addObject:model];
            }
        }
        page = 2;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
- (void)loddeSLList{
    [self.tableView.mj_header endRefreshing];
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"equipmentId":idstring,
            @"sorttype":@"asc",
            @"sort":@"undefined",
            @"page":[NSString stringWithFormat:@"%ld",page],

            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentmaintain/mylist") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.equipment];
                model.equipment_model = model1;
                
                PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.departmentPerson];
                model.departmentPerson_model = model2;
                
                PaidanModel1 *model3 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentSupplier];
                model.equipmentSupplier_model = model3;
                [weakSelf.dataArray addObject:model];
            }
        }
        page++;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}



- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}


@end

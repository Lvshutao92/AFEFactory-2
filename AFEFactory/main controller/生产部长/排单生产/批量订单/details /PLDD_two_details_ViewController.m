//
//  PLDD_two_details_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PLDD_two_details_ViewController.h"
#import "Paidan_3_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface PLDD_two_details_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)UITableView *tableView;

@end

@implementation PLDD_two_details_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"Paidan_3_Cell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:self.tableView];
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(details:) name:@"zzpldd" object:nil];
}
- (void)details:(NSNotification *)text{
    NSDictionary *dic = text.userInfo;
    [Manager sharedManager].ids = [dic objectForKey:@"orderNo"];
    [Manager sharedManager].orderid = [dic objectForKey:@"orderId"];
    [self setUpReflash];
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
        if (self.dataArray1.count == totalnum) {
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
    if ([Manager sharedManager].orderid == nil) {
        [Manager sharedManager].orderid = @"";
    }
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"orderId":[Manager sharedManager].orderid,
            @"page":[NSString stringWithFormat:@"%ld",page],
            };
    //NSLog(@"--------+++*****%@",dic);
    [session POST:KURLNSString(@"servlet/purchase/purchaseplanitem/item/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray1 removeAllObjects];
        //NSLog(@"+++*****%@",dic);
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.parts];
            model.parts_model = model1;
            
            [weakSelf.dataArray1 addObject:model];
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
            @"orderId":[Manager sharedManager].orderid,
            @"page":[NSString stringWithFormat:@"%ld",page],
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseplanitem/item/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.parts];
            model.parts_model = model1;
            
            [weakSelf.dataArray1 addObject:model];
        }
        page++;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}




#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray1.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"cell2";
    Paidan_3_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[Paidan_3_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PaiDanModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
    
    
    if (model.parts_model.partNo == nil) {
        cell.lab1.text = [NSString stringWithFormat:@"部件编号：%@",@"-"];
    }else{
        cell.lab1.text = [NSString stringWithFormat:@"部件编号：%@",model.parts_model.partNo];
    }
    
    
    
    if (model.parts_model.name == nil) {
        cell.lab2.text = [NSString stringWithFormat:@"部件名称：%@",@"-"];
    }else{
        cell.lab2.text = [NSString stringWithFormat:@"部件名称：%@",model.parts_model.name];
    }
    
    
    cell.lab3.text = [NSString stringWithFormat:@"数量：%@",model.quantity];
    
    
    cell.lab1.textColor = RGBACOLOR(102, 102, 102, 1);
    cell.lab2.textColor = RGBACOLOR(102, 102, 102, 1);
    cell.lab3.textColor = RGBACOLOR(102, 102, 102, 1);
    return cell;
}






- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}
@end

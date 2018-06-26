//
//  SYLLD_details_TableViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/27.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SYLLD_details_TableViewController.h"
#import "HCDSH_3_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface SYLLD_details_TableViewController ()
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SYLLD_details_TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"HCDSH_3_Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
    
    [self setUpReflash];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100+height;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifierCell = @"cell1";
    HCDSH_3_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[HCDSH_3_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = [NSString stringWithFormat:@"部件编号：%@",model.partNo];
    
    cell.lab2.text = [NSString stringWithFormat:@"部件名称：%@",model.partName];
    cell.lab2.numberOfLines = 0;
    cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    cell.lab2height.constant = size.height;
    height = size.height;
    
    cell.lab3.text = [NSString stringWithFormat:@"数量：%@",model.quantity];
    
    cell.lab1.textColor = RGBACOLOR(102, 102, 102, 1);
    cell.lab2.textColor = RGBACOLOR(102, 102, 102, 1);
    cell.lab3.textColor = RGBACOLOR(102, 102, 102, 1);
    
    return cell;
    
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
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"materialOrderId":self.purchaseOrderId,
            };
    [session POST:KURLNSString(@"servlet/material/materialorderitem/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [dic objectForKey:@"rows"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
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
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"materialOrderId":self.purchaseOrderId,
            };
    [session POST:KURLNSString(@"servlet/material/materialorderitem/list")  parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [diction objectForKey:@"rows"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
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

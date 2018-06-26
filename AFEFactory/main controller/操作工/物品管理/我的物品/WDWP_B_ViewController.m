//
//  WDWP_B_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/3.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "WDWP_B_ViewController.h"
#import "YuanGong_Cell.h"

#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface WDWP_B_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation WDWP_B_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"YuanGong_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    
    [self setUpReflash];
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 425;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    YuanGong_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[YuanGong_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.line.hidden  = YES;
    cell.btn.hidden   = YES;
    cell.btn1.hidden   = YES;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.picture)]placeholderImage:[UIImage imageNamed:@"user"]];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    
    cell.lab1.text = [NSString stringWithFormat:@"编号：%@",model.code];
    
    cell.lab2.text = [NSString stringWithFormat:@"名称：%@",model.name];
    
    cell.lab3.text = [NSString stringWithFormat:@"物品类别：%@",model.durableType];
    
    
    cell.lab4.text = [NSString stringWithFormat:@"品牌：%@",model.brand];
    
    cell.lab5.text = [NSString stringWithFormat:@"型号：%@",model.model_s];
    
    cell.lab6.text = [NSString stringWithFormat:@"规格：%@",model.standard];
    

    if ([model.state isEqualToString:@"normal"]) {
        cell.lab7.text = @"状态：正常";
    }else if ([model.state isEqualToString:@"repairing"]) {
        cell.lab7.text = @"状态：维修中";
    }else if ([model.state isEqualToString:@"returning"]) {
        cell.lab7.text = @"状态：归还中";
    }else if ([model.state isEqualToString:@"returned"]) {
        cell.lab7.text = @"状态：已归还";
    }else if ([model.state isEqualToString:@"repair_failed"]) {
        cell.lab7.text = @"状态：维修失败";
    }
    
    
    
    if ([model.needCheck isEqualToString:@"0"] || [model.state isEqualToString:@"repair_failed"] || [model.state isEqualToString:@"returned"]) {
        cell.lab8.text = @"盘点状态：无需盘点";
    }else{
        if ([model.lastCheckTime isEqualToString:@"currentMonth"]) {
            cell.lab8.text = @"盘点状态：正常";
        }else{
            cell.lab8.text = @"盘点状态：待上传盘点照片";
        }
    }
    
    
    
    
    cell.lab9.text = [NSString stringWithFormat:@"价值(元)：%@",model.price];
    
    cell.lab10.text = [NSString stringWithFormat:@"数量：%@",model.num];
    
    cell.lab11.text = [NSString stringWithFormat:@"单位：%@",model.unit];
    
    cell.lab12.text = [NSString stringWithFormat:@"领用时间：%@",[Manager TimeCuoToTimes:model.takeTime]];
    return cell;
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
            @"departmentPersonSessionId":[Manager redingwenjianming:@"id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            @"type":@"NY",
            @"userId":[Manager redingwenjianming:@"userid.text"],
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodsstaff/my/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
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
            @"departmentPersonSessionId":[Manager redingwenjianming:@"id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            @"type":@"NY",
            @"userId":[Manager redingwenjianming:@"userid.text"],
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodsstaff/my/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
                if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
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

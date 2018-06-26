//
//  WPLY_details_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/19.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WPLY_details_ViewController.h"
#import "YuanGong_Cell.h"

#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface WPLY_details_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    
    UIView *yuan;
    UILabel *shang;
    UILabel *xia;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation WPLY_details_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"YuanGong_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    

    
    [self loddeList];
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 290;
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
    cell.lab9.hidden   = YES;
    cell.lab10.hidden  = YES;
    cell.lab11.hidden  = YES;
    cell.lab12.hidden  = YES;
    cell.line.hidden   = YES;
    cell.btn.hidden    = YES;
    cell.btn1.hidden   = YES;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.picture)]placeholderImage:[UIImage imageNamed:@"user"]];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;

    
    if (model.goodsItemCode != nil) {
        cell.lab1.text = [NSString stringWithFormat:@"物品编号：%@",model.goodsItemCode];
    }else{
        cell.lab1.text = [NSString stringWithFormat:@"物品编号：%@",model.code];
    }
    
    
    cell.lab2.text = [NSString stringWithFormat:@"名称：%@",model.name];

    cell.lab3.text = [NSString stringWithFormat:@"物品类别：%@",model.durableType];
    
    cell.lab4.text = [NSString stringWithFormat:@"物品品牌：%@",model.brand];

    
    if (model.model_s != nil) {
        cell.lab5.text = [NSString stringWithFormat:@"型号：%@",model.model_s];
    }else{
        cell.lab5.text = [NSString stringWithFormat:@"型号：%@",@"-"];
    }
    
    
    cell.lab6.text = [NSString stringWithFormat:@"规格：%@",model.standard];
    
    cell.lab7.text = [NSString stringWithFormat:@"领用数量：%@",model.num];
    
    cell.lab8.text = [NSString stringWithFormat:@"单位：%@",model.unit];
    
    
    
    
    return cell;
}






- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    shang.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
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
            @"takeId":self.takeId,
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodstakeitem/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        if (totalnum > 0) {
            yuan.hidden = NO;
            xia.text = [NSString stringWithFormat:@"%ld",totalnum];
        }else{
            yuan.hidden = YES;
        }
        
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
            @"takeId":self.takeId,
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodstakeitem/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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

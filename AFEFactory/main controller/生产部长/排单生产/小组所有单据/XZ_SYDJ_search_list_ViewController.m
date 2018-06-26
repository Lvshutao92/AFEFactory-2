//
//  XZ_SYDJ_search_list_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/6.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XZ_SYDJ_search_list_ViewController.h"
#import "SY_11_Cell.h"
#import "PaiDanModel.h"
#import "SYDJ_details_Controller.h"
@interface XZ_SYDJ_search_list_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation XZ_SYDJ_search_list_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"检索信息";
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
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
    cell.btn1.hidden = NO;
    cell.btn2.hidden = NO;
    LRViewBorderRadius(cell.btn, 10, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn1, 10, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn2, 10, 1, [UIColor blackColor]);
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
    
    
    
    if ([model.status isEqualToString:@"producting"]) {
        if (model.field1 == nil || [model.field1 isEqualToString:@"N"]) {
            cell.btn1.hidden = NO;
            cell.btn2.hidden = YES;
            cell.btn1width.constant  = 80;
            cell.btn12width.constant = 10;
        }else{
            cell.btn1.hidden = YES;
            cell.btn2.hidden = NO;
            cell.btn1width.constant  = 0;
            cell.btn12width.constant = 0;
        }
    }else{
        cell.btn1.hidden = YES;
        cell.btn2.hidden = YES;
    }
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 addTarget:self action:@selector(clickbtn2:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}




- (void)clickbtn1:(UIButton *)sender{
    SY_11_Cell *cell = (SY_11_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认暂停生产吗？" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"id":model.id,
                @"field1":@"Y",
                };
        [session POST:KURLNSString(@"servlet/production/productionorder/myorder/suspend") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"暂停生产成功" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:sure];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}



- (void)clickbtn2:(UIButton *)sender{
    SY_11_Cell *cell = (SY_11_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认恢复生产吗？" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"id":model.id,
                @"field1":@"N",
                };
        [session POST:KURLNSString(@"servlet/production/productionorder/myorder/suspend") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"恢复生产成功" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
        
        
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:sure];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
    
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
            
            @"productionOrderNo":self.text1,
            @"orderNo":self.text2,
            @"productionDate":self.text3,
            @"fcno":self.text4,
            @"status":self.text5,
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
            
            @"productionOrderNo":self.text1,
            @"orderNo":self.text2,
            @"productionDate":self.text3,
            @"fcno":self.text4,
            @"status":self.text5,
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

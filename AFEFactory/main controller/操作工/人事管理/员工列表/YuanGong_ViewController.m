//
//  YuanGong_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/4.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "YuanGong_ViewController.h"
#import "YuanGong_Cell.h"

#import "PaiDanModel.h"
#import "PaidanModel1.h"

@interface YuanGong_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, strong)NSMutableArray *arr1;
@property(nonatomic, strong)NSMutableArray *arr2;

@end

@implementation YuanGong_ViewController
- (NSMutableArray *)arr1 {
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)arr2 {
    if (_arr2 == nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    [self lodd];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"YuanGong_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    
    [self setUpReflash];
}


- (void)lodd{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    __weak typeof (self) weakSelf = self;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/organization/departmentperson/initpage") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr1 = [[dic objectForKey:@"rows"] objectForKey:@"departmentList"];
        NSMutableArray *arr2 = [[dic objectForKey:@"rows"] objectForKey:@"departmentPositionList"];
        [weakSelf.arr1 removeAllObjects];
        [weakSelf.arr2 removeAllObjects];
        for (NSDictionary *dict in arr1) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.arr1 addObject:model];
        }
        for (NSDictionary *dict in arr2) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.arr2 addObject:model];
        }
        
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 330;
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
    cell.lab9.hidden  = YES;
    cell.lab10.hidden = YES;
    cell.lab11.hidden = YES;
    cell.lab12.hidden = YES;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.file)]placeholderImage:[UIImage imageNamed:@"user"]];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    
    cell.lab1.text = [NSString stringWithFormat:@"员工姓名：%@",model.realName];
    
    
    
    for (PaiDanModel *mo in self.arr1) {
        if ([mo.id isEqualToString:model.departmentId]) {
            cell.lab2.text = [NSString stringWithFormat:@"所属部门：%@ %@",mo.departmentCode,mo.departmentName];
        }
    }
    
    
    for (PaiDanModel *mod in self.arr2) {
        if ([mod.id isEqualToString:model.positionId]) {
            cell.lab3.text = [NSString stringWithFormat:@"职位：%@",mod.positionName];
        }
    }
    

    cell.lab4.text = [NSString stringWithFormat:@"员工编号：%@",model.personCode];
    
    
    if ([model.sex isEqualToString:@"M"]) {
        cell.lab5.text = [NSString stringWithFormat:@"性别：%@",@"男"];
    }else if ([model.sex isEqualToString:@"W"]) {
        cell.lab5.text = [NSString stringWithFormat:@"性别：%@",@"女"];
    }
    
    
    cell.lab6.text = [NSString stringWithFormat:@"联系电话：%@",model.phone];
    
    
    if (model.bqq == nil) {
        cell.lab7.text = [NSString stringWithFormat:@"企业QQ：%@",@"-"];
    }else{
        cell.lab7.text = [NSString stringWithFormat:@"企业QQ：%@",model.bqq];
    }
    
    if (model.enterpriseMailbox == nil) {
        cell.lab8.text = [NSString stringWithFormat:@"企业邮箱：%@",@"-"];
    }else{
        cell.lab8.text = [NSString stringWithFormat:@"企业邮箱：%@",model.enterpriseMailbox];
    }
    
    
    cell.btn.hidden  = YES;
    
    
    LRViewBorderRadius(cell.btn1, 5, 1, [UIColor blackColor]);
    [cell.btn1 addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)clickbtn:(UIButton *)sender{
    YuanGong_Cell *cell = (YuanGong_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    LookPictureViewController *look = [[LookPictureViewController alloc]init];
    look.imgStr = model.file;
    [self.navigationController pushViewController:look animated:YES];
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
            @"status":@"Y",
        
            
            @"personCode":@"",
            @"realName":@"",
            @"sex":@"",
            @"phone":@"",
            @"bqq":@"",
            @"enterpriseMailbox":@"",
            @"departmentId":@"",
            @"positionId":@"",
            };
    [session POST:KURLNSString(@"servlet/organization/departmentperson/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
            @"status":@"Y",
            
            
            @"personCode":@"",
            @"realName":@"",
            @"sex":@"",
            @"phone":@"",
            @"bqq":@"",
            @"enterpriseMailbox":@"",
            @"departmentId":@"",
            @"positionId":@"",
            };
    [session POST:KURLNSString(@"servlet/organization/departmentperson/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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

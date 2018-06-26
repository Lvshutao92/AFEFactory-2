//
//  LiZhi_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/4.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "LiZhi_ViewController.h"
#import "BJRKD_12_Cell.h"

#import "PaiDanModel.h"
#import "PaidanModel1.h"

@interface LiZhi_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation LiZhi_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"BJRKD_12_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 380;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    BJRKD_12_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[BJRKD_12_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.btn  setTitle:@"删除" forState:UIControlStateNormal];
    [cell.btn1 setTitle:@"我要离职" forState:UIControlStateNormal];
//    [cell.btn2 setTitle:@"我要离职" forState:UIControlStateNormal];
    cell.lab12.hidden = YES;
    
    
    cell.lab1.text = [NSString stringWithFormat:@"员工姓名：%@",model.realName];
    cell.lab2.text = [NSString stringWithFormat:@"身份证号码：%@",model.idCard];
    cell.lab3.text = [NSString stringWithFormat:@"入职日期：%@",model.field4];
    
    cell.lab4.text = [NSString stringWithFormat:@"离职日期：%@",model.dimissionTime];
    
    if ([model.type isEqualToString:@"A"]) {
        cell.lab5.text = [NSString stringWithFormat:@"类型：%@",@"主动离职"];
    }else {
        cell.lab5.text = [NSString stringWithFormat:@"类型：%@",@"被动离职"];
    }
    
    
    
    cell.lab6.text = [NSString stringWithFormat:@"离职类型：%@",model.contentType];
    
    cell.lab7.text = [NSString stringWithFormat:@"离职原因：%@",model.contentReason];
    
    
    if ([model.isHire isEqualToString:@"Y"]) {
         cell.lab8.text = [NSString stringWithFormat:@"是否可再录用：%@",@"是"];
    }else{
         cell.lab8.text = [NSString stringWithFormat:@"是否可再录用：%@",@"否"];
    }
    
    
   
    cell.lab9.text = [NSString stringWithFormat:@"社保截止日期：%@",model.socialTime];
    
    cell.lab10.text = [NSString stringWithFormat:@"公积金截止日期：%@",model.fundTime];
    
    if ([model.t_departmentPerson_status isEqualToString:@"N"]) {
        cell.lab11.text = [NSString stringWithFormat:@"状态：%@",@"已完成"];
    }else{
        cell.lab11.text = [NSString stringWithFormat:@"状态：%@",@"未完成"];
    }

    cell.btn1.hidden = YES;
    cell.btn2.hidden = YES;
    cell.btn1width.constant = 80;
    
    LRViewBorderRadius(cell.btn, 10, 1, [UIColor blackColor]);
//    LRViewBorderRadius(cell.btn1, 10, 1, [UIColor blackColor]);
//    LRViewBorderRadius(cell.btn2, 10, 1, [UIColor blackColor]);
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.btn2 addTarget:self action:@selector(clickbtn2:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}





- (void)clickbtn:(UIButton *)sender{
    BJRKD_12_Cell *cell = (BJRKD_12_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":model.id,
            };
    [session POST:KURLNSString(@"servlet/organization/departmentdimission/delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除成功！" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.dataArray removeObjectAtIndex:indexpath.row];
                [weakSelf.tableview deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    

}
- (void)clickbtn1:(UIButton *)sender{
    BJRKD_12_Cell *cell = (BJRKD_12_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认离职吗？" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
//        AFHTTPSessionManager *session = [Manager returnsession];
//        __weak typeof(self) weakSelf = self;
//        NSDictionary *dic = [[NSDictionary alloc]init];
//        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
//                @"id":model.id,
//                };
//        [session POST:KURLNSString(@"servlet/organization/departmentperson/confirmGet") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSDictionary *dic = [Manager returndictiondata:responseObject];
//            //NSLog(@"+++%@",[dic objectForKey:@"message"]);
//            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除成功！" message:@"温馨提示" preferredStyle:1];
//                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                    [weakSelf setUpReflash];
//                }];
//                [alert addAction:cancel];
//                [weakSelf presentViewController:alert animated:YES completion:nil];
//            }
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        }];
        
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:sure];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
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
            @"personId":[Manager redingwenjianming:@"id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            };
    [session POST:KURLNSString(@"servlet/organization/departmentdimission/mylist") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
            @"personId":[Manager redingwenjianming:@"id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            };
    [session POST:KURLNSString(@"servlet/organization/departmentdimission/mylist") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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

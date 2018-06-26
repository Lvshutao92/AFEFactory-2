//
//  XZGL_search_list_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/6.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XZGL_search_list_ViewController.h"
#import "SCBZ_xzgl_4_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel2.h"
#import "PaidanModel1.h"
#import "XZGL_add_ViewController.h"
#import "RenYuanPeiZhi_ViewController.h"
@interface XZGL_search_list_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation XZGL_search_list_ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    btn.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [btn setTitle:@"新增" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickadd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"SCBZ_xzgl_4_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    [self.view bringSubviewToFront:btn];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self setUpReflash];
}

- (void)clickadd{
    XZGL_add_ViewController *order = [[XZGL_add_ViewController alloc]init];
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:order animated:YES];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 205;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    SCBZ_xzgl_4_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[SCBZ_xzgl_4_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    cell.lab1.text = [NSString stringWithFormat:@"小组名称：%@",model.configName];
    cell.lab2.text = [NSString stringWithFormat:@"工艺模板编号：%@",model.modelCraftBomStencil_model.stencilNo];
    cell.lab3.text = [NSString stringWithFormat:@"工艺模板描述：%@",model.modelCraftBomStencil_model.stencilDesc];
    cell.lab4.text = [NSString stringWithFormat:@"工艺类型：%@",model.modelCraftBomStencil_model.modelCraftType_model.name];
    
    
    
    LRViewBorderRadius(cell.btn, 10, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn1, 10, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn2, 10, 1, [UIColor blackColor]);
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 addTarget:self action:@selector(clickbtn2:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}




- (void)clickbtn:(UIButton *)sender{
    SCBZ_xzgl_4_Cell *cell = (SCBZ_xzgl_4_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    RenYuanPeiZhi_ViewController *order = [[RenYuanPeiZhi_ViewController alloc]init];
    
    order.idstr  = model.crafId;
    order.idstr1 = model.id;
    
    
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:order animated:YES];
    
}
- (void)clickbtn1:(UIButton *)sender{
    SCBZ_xzgl_4_Cell *cell = (SCBZ_xzgl_4_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认删除吗？" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"departmentPersonName":[NSString stringWithFormat:@"%@",[Manager redingwenjianming:@"realName.text"]],
                @"departmentPersonSession":[Manager sharedManager].diction,
                @"id":model.id,
                };
        [session POST:KURLNSString(@"servlet/productionconfig/productionorderperson/delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //            NSLog(@"+++%@",dic);
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除成功" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.dataArray removeObjectAtIndex:indexpath.row];  //删除_data数组里的数据
                    [weakSelf.tableview deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];  //删除对应数据的cell
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
    SCBZ_xzgl_4_Cell *cell = (SCBZ_xzgl_4_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:                                        @"修改窗口" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *TextField1 = alertController.textFields.firstObject;
        if (TextField1.text!=nil) {
            
            AFHTTPSessionManager *session = [Manager returnsession];
            __weak typeof(self) weakSelf = self;
            NSDictionary *dic = [[NSDictionary alloc]init];
            dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                    @"id":model.id,
                    @"configName":TextField1.text,
                    };
            [session POST:KURLNSString(@"servlet/productionconfig/productionorderperson/update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dic = [Manager returndictiondata:responseObject];
                //                NSLog(@"+++%@",dic);
                if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改成功" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [weakSelf setUpReflash];
                    }];
                    [alert addAction:cancel];
                    [weakSelf presentViewController:alert animated:YES completion:nil];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            }];
            
            
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"小组名称不能为空" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }]];
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.text = model.configName;
    }];
    [self presentViewController:alertController animated:true completion:nil];
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
            
            @"crafId":self.str1,
            @"configName":self.str2,
            @"createUser":self.str3,
            };
    [session POST:KURLNSString(@"servlet/productionconfig/productionorderperson/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //                        NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [dic objectForKey:@"rows"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.modelCraftBomStencil];
            model.modelCraftBomStencil_model = model1;
            
            PaidanModel2 *model2 = [PaidanModel2 mj_objectWithKeyValues:model1.modelCraftType];
            model1.modelCraftType_model = model2;
            
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
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"crafId":self.str1,
            @"configName":self.str2,
            @"createUser":self.str3,
            };
    [session POST:KURLNSString(@"servlet/productionconfig/productionorderperson/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [dic objectForKey:@"rows"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.modelCraftBomStencil];
            model.modelCraftBomStencil_model = model1;
            
            PaidanModel2 *model2 = [PaidanModel2 mj_objectWithKeyValues:model1.modelCraftType];
            model1.modelCraftType_model = model2;
            
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

//
//  LBGL_TableViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/15.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "LBGL_TableViewController.h"
#import "SY_11_Cell.h"
#import "PaiDanModel.h"
@interface LBGL_TableViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    NSString *idstr;
    
    NSString *namestr;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UISearchBar *searchbar;
@end

@implementation LBGL_TableViewController


- (void)cancelClick:(UIButton *)btn
{
    [btn.superview performSelector:@selector(close)];
}
-  (void)confirmClick:(UIButton *)btn
{
    [btn.superview performSelector:@selector(close)];
    UITextField *tf1 = [btn.superview viewWithTag:100];
    if (tf1.text.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"name":tf1.text,
                };
        [session POST:KURLNSString(@"servlet/equipment/equipmentcategory/add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //        NSLog(@"----------%@",dic);
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新增成功！" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
- (void)clickadd{
    YBAlertView *alertView = [[YBAlertView alloc] initWithFrame:CGRectMake(50, 150, kScreenW-100, 220)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, alertView.width, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"新增窗口";
    titleLabel.font = [UIFont systemFontOfSize:20];
    [alertView addSubview:titleLabel];
    
    UITextField *passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 40, alertView.width-32, 40)];
    passwordTF.tag = 100;
    passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    passwordTF.layer.borderWidth = 1;
    passwordTF.placeholder = @"类别名称";
    passwordTF.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.5].CGColor;
    passwordTF.layer.cornerRadius = 5;
    [alertView addSubview:passwordTF];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(16, CGRectGetMaxY(passwordTF.frame) + 30, passwordTF.width/2, 40);
    [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(passwordTF.frame) + 30, passwordTF.width/2, 40);
    [confirmBtn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:confirmBtn];
    
    [alertView show];
}








- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    namestr = @"";
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickadd)];
    self.navigationItem.rightBarButtonItem = bar;
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = @"请输入类别名称";
    [self.view addSubview:_searchbar];
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, height+50, SCREEN_WIDTH, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    [self.view addSubview:line1];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, height+51, SCREEN_WIDTH, SCREEN_HEIGHT-51-height) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"SY_11_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    
    
    
    
    [self setUpReflash];
}

#pragma mark --searchBar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    namestr = searchBar.text;
    [self setUpReflash];
    [searchBar resignFirstResponder];
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    namestr = @"";
    return YES;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"cell";
    SY_11_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[SY_11_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"类别名称：%@",model.name];
    
    
    
    
    cell.lab2.hidden = YES;
    cell.lab3.hidden = YES;
    cell.lab4.hidden = YES;
    cell.lab5.hidden = YES;
    cell.lab6.hidden = YES;
    cell.lab7.hidden = YES;
    cell.lab8.hidden = YES;
    cell.lab9.hidden = YES;
    cell.lab10.hidden = YES;
    cell.lab11.hidden = YES;
    
    cell.btn2.hidden = YES;
    cell.btn1.hidden = NO;
    [cell.btn setTitle:@"删除" forState:UIControlStateNormal];
    [cell.btn1 setTitle:@"修改" forState:UIControlStateNormal];
    LRViewBorderRadius(cell.btn, 15, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn1, 15, 1, [UIColor blackColor]);
    
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)clickbtn:(UIButton *)sender{
    SY_11_Cell *cell = (SY_11_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":model.id,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentcategory/delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"----------%@",dic);
        if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除成功！" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.dataArray removeObjectAtIndex:indexpath.row];
                [weakSelf.tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (void)clickbtn1:(UIButton *)sender{
    SY_11_Cell *cell = (SY_11_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableView indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    idstr = model.id;
    
    YBAlertView *alertView = [[YBAlertView alloc] initWithFrame:CGRectMake(50, 150, kScreenW-100, 220)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, alertView.width, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"编辑窗口";
    titleLabel.font = [UIFont systemFontOfSize:20];
    [alertView addSubview:titleLabel];
    
    UITextField *passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 40, alertView.width-32, 40)];
    passwordTF.tag = 100;
    passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    passwordTF.layer.borderWidth = 1;
    passwordTF.text = model.name;
    passwordTF.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.5].CGColor;
    passwordTF.layer.cornerRadius = 5;
    [alertView addSubview:passwordTF];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(16, CGRectGetMaxY(passwordTF.frame) + 30, passwordTF.width/2, 40);
    [cancelBtn addTarget:self action:@selector(cancelClick1:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(passwordTF.frame) + 30, passwordTF.width/2, 40);
    [confirmBtn addTarget:self action:@selector(confirmClick1:) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:confirmBtn];
    
    [alertView show];
    
}

- (void)cancelClick1:(UIButton *)btn
{
    [btn.superview performSelector:@selector(close)];
}
-  (void)confirmClick1:(UIButton *)btn
{
    [btn.superview performSelector:@selector(close)];
    UITextField *tf1 = [btn.superview viewWithTag:100];
    if (tf1.text.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"id":idstr,
                @"name":tf1.text,
                };
        [session POST:KURLNSString(@"servlet/equipment/equipmentcategory/update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //        NSLog(@"----------%@",dic);
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改成功！" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
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
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"name":namestr,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentcategory/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"name":namestr,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentcategory/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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


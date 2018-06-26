//
//  PJGL_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/11.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "PJGL_ViewController.h"
#import "SY_11_Cell.h"
#import "PaiDanModel.h"
@interface PJGL_ViewController ()<UISearchBarDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    NSString *idstr;
    
    NSString *idstring;
    
    UITextField *text1;
    UITextField *text2;
    UIView *window;
    UIView *bgview;
    UITextField *text3;
    UITextField *text4;
    UILabel *titleLabel;
    
    NSString *namestr;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(strong,nonatomic)UITableView    *tableview;


@property(strong,nonatomic)UITableView    *tableview1;
@property(nonatomic,strong)NSMutableArray *arr;

@property(nonatomic,strong)UISearchBar *searchbar;
@end

@implementation PJGL_ViewController

- (NSMutableArray *)arr{
    if (_arr== nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}

- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentdetail/add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.arr removeAllObjects];
        if (![[dic objectForKey:@"equipmentCategoryList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"equipmentCategoryList"];
            for (NSDictionary *dic in arr) {
                 PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr addObject:model];
            }
        }
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}








- (void)setupview{
    window = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    window.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktap:)];
    tap.delegate = self;
    [window addGestureRecognizer:tap];
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350)];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [window addSubview:self.tableview1];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview1.tableFooterView = v;
    
    [self lod];
}







- (void)setupview1{
    
    bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgview.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    bgview.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktap:)];
    tap.delegate = self;
    [bgview addGestureRecognizer:tap];
    [self.view addSubview:bgview];
    [self.view bringSubviewToFront:bgview];
    
    UIView *alertView = [[UIView alloc]initWithFrame:CGRectMake(40, 150, SCREEN_WIDTH-80, 220)];
    alertView.backgroundColor = [UIColor whiteColor];
    LRViewBorderRadius(alertView, 10, 0, [UIColor whiteColor]);
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, alertView.width, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    titleLabel.font = [UIFont systemFontOfSize:20];
    [alertView addSubview:titleLabel];
    
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 20, alertView.width-32, 40)];
    text1.tag = 100;
    text1.borderStyle = UITextBorderStyleRoundedRect;
    text1.layer.borderWidth = 1;
    text1.delegate =self;
    text1.placeholder = @"所属类别";
    text1.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.5].CGColor;
    text1.layer.cornerRadius = 5;
    [alertView addSubview:text1];
    
    
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame) + 70, alertView.width-32, 40)];
    text2.tag = 101;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.layer.borderWidth = 1;
    text2.placeholder = @"配件名称";
    text2.delegate =self;
    text2.layer.borderColor = [UIColor colorWithWhite:.8 alpha:.5].CGColor;
    text2.layer.cornerRadius = 5;
    [alertView addSubview:text2];
    
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(16, CGRectGetMaxY(text1.frame) + 70, text1.width/2, 40);
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    confirmBtn.frame = CGRectMake(CGRectGetMaxX(cancelBtn.frame), CGRectGetMaxY(text1.frame) + 70, text1.width/2, 40);
    [confirmBtn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [alertView addSubview:confirmBtn];
    
    [bgview addSubview:alertView];
}
- (void)cancelClick{
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
    bgview.hidden = YES;
}
- (void)confirmClick{
    if ([titleLabel.text isEqualToString:@"新增窗口"]) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"categoryId":idstr,
                @"name":text2.text,
                };
        [session POST:KURLNSString(@"servlet/equipment/equipmentdetail/add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //        NSLog(@"----------%@",dic);
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"新增成功！" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    [text2 resignFirstResponder];
                    [text3 resignFirstResponder];
                    [text4 resignFirstResponder];
                    bgview.hidden = YES;
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }else{
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"categoryId":idstr,
                @"name":text2.text,
                @"id":idstring,
                };
        [session POST:KURLNSString(@"servlet/equipment/equipmentdetail/update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //        NSLog(@"----------%@",dic);
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改成功！" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    [text2 resignFirstResponder];
                    [text3 resignFirstResponder];
                    [text4 resignFirstResponder];
                    bgview.hidden = YES;
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
}





- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return YES;
    }
    return NO;
}
- (void)clicktap:(UITapGestureRecognizer *)tap{
     window.hidden = YES;
     bgview.hidden = YES;
    
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        window.hidden = YES;
        PaiDanModel *model = [self.arr objectAtIndex:indexPath.row];
        text1.text = model.name;
        idstr = model.id;
    }
}





- (void)clickadd{
    text2.text = nil;
    text1.text = nil;
    titleLabel.text = @"新增窗口";
    bgview.hidden = NO;
}





- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        if (window.hidden == YES) {
            window.hidden = NO;
        }else{
            window.hidden = YES;
        }
        return NO;
    }
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    namestr = @"";
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, 50)];
    _searchbar.delegate = self;
    _searchbar.searchBarStyle = UISearchBarStyleMinimal;
    _searchbar.placeholder = @"请输入配件名称";
    [self.view addSubview:_searchbar];
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, height+50, SCREEN_WIDTH, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    [self.view addSubview:line1];
    
    
    
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickadd)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, height+51, SCREEN_WIDTH, SCREEN_HEIGHT-51-height) style:UITableViewStylePlain];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"SY_11_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview.tableHeaderView = v;
    
    [self setupview1];
    [self setupview];
    
    
    
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
    if ([tableView isEqual:self.tableview1]) {
        return self.arr.count;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 50;
    }
    return 120;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableview1]) {
        static NSString *identifierCell = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.arr objectAtIndex:indexPath.row];
        cell.textLabel.text = model.name;
        return cell;
    }
    static NSString *identifierCell = @"cell";
    SY_11_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[SY_11_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    cell.lab1.text = [NSString stringWithFormat:@"所属类别：%@",model.categoryName];
    cell.lab2.text = [NSString stringWithFormat:@"配件名称：%@",model.name];
    
    
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
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":model.id,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentdetail/delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"----------%@",dic);
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
    SY_11_Cell *cell = (SY_11_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    titleLabel.text = @"编辑窗口";
    idstring = model.id;
    bgview.hidden = NO;
    text1.text = model.categoryName;
    text2.text = model.name;
    
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
            
            @"name":namestr,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentdetail/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
            
            @"name":namestr,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentdetail/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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

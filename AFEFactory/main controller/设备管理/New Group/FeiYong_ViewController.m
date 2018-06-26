//
//  FeiYong_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/22.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "FeiYong_ViewController.h"
#import "PaiDanModel.h"
#import "FeiYong_Cell.h"
@interface FeiYong_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    NSString *idstring;
    
    UIView *bgview;
    UILabel *bglab;
    
    
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}


@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *arr;

@property(nonatomic,strong)UITableView *tableview1;
@property(nonatomic,strong)NSMutableArray *arr1;
@end

@implementation FeiYong_ViewController





- (void)clicksave{
    if (text3.text.length != 0 && self.idstr.length != 0 && idstring.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        NSString *str;
        if ([self.navigationItem.title isEqualToString:@"维修费用"]) {
            str = @"servlet/equipment/equipmentmaintenancedetail/add";
            dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                    @"maintenanceId":self.idstr,
                    @"detailId":idstring,
                    @"cost":text3.text,
                    };
        }else{
            str = @"servlet/equipment/equipmentmaintaindetail/add";
            dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                    @"maintainId":self.idstr,
                    @"detailId":idstring,
                    @"cost":text3.text,
                    };
        }
        [session POST:KURLNSString(str) parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //            /NSLog(@"----------%@",dic);
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSDictionary *dict = [[NSDictionary alloc]init];
                    NSNotification *notification =[NSNotification notificationWithName:@"weixiu" object:nil userInfo:dict];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:[dic objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入完整信息，再重新保存" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
   
}













- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clicksave)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    CGFloat he;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        he = 88;
    }else{
        he = 64;
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    if ([self.navigationItem.title isEqualToString:@"维修费用"]) {
        array = [@[@"维修申请编号",@"维修项",@"维修费用"]mutableCopy];
    }else{
        array = [@[@"保养申请编号",@"保养项",@"保养费用"]mutableCopy];
    }
    for (int i = 0; i<array.count; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, he+10+30*i+20*i, 135, 30)];
        lab.text = array[i];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.font = [UIFont systemFontOfSize:16];
        [self.view addSubview:lab];
    }
    for (int j = 0; j<3; j++) {
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(150,he + 5+40*j+10*j, SCREEN_WIDTH-165, 40)];
        textfield.delegate = self;
        switch (j) {
            case 0:
                text1 = textfield;
                text1.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                text1.text = _str1;
                break;
            case 1:
                text2 = textfield;
                text2.placeholder= @"请选择";
                break;
            case 2:
                text3 = textfield;
                break;
            default:
                break;
        }
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        [self.view addSubview:textfield];
    }
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, he+175, SCREEN_WIDTH, 5)];
    line.backgroundColor = [UIColor colorWithWhite:.85 alpha:.35];
    [self.view addSubview:line];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, he+180, SCREEN_WIDTH, SCREEN_HEIGHT-180-he)];
    [self.tableview registerNib:[UINib nibWithNibName:@"FeiYong_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview.tableFooterView = v;
    
    [self setupview_tableview];
    
    
    [self lod];
    [self setUpReflash];
}


- (void)setupview_tableview{
    bgview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgview.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    bgview.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapbgwindowview:)];
    tap.delegate = self;
    [bgview addGestureRecognizer:tap];
    [self.view addSubview:bgview];
    [self.view bringSubviewToFront:bgview];
    
    bglab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-400.5, SCREEN_WIDTH, 50)];
    bglab.backgroundColor = [UIColor whiteColor];
    if ([self.navigationItem.title isEqualToString:@"维修费用"]){
        bglab.text = @"维修项";
    }else{
        bglab.text = @"保养项";
    }
    
    bglab.textAlignment = NSTextAlignmentCenter;
    [bgview addSubview:bglab];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350)];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [bgview addSubview:self.tableview1];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview1.tableFooterView = v;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return YES;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UILabel"]) {
        return YES;
    }
    return NO;
}
- (void)clicktapbgwindowview:(UITapGestureRecognizer *)tap{
    bgview.hidden = YES;
}




- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        return NO;
    }
    if ([textField isEqual:text2]) {
        bgview.hidden = NO;
        return NO;
    }
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
        text2.text = model.name;
        idstring = model.id;
        bgview.hidden = YES;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]) {
        return self.arr1.count;
    }
    return self.arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 60;
    }
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableview1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.name;
        return cell;
    }
    
    
    if ([self.navigationItem.title isEqualToString:@"维修费用"]){
        FeiYong_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.arr objectAtIndex:indexPath.row];
        cell.lab1.text = [NSString stringWithFormat:@"维修项目：%@",model.equipmentDetail_model.name];
        cell.lab2.text = [NSString stringWithFormat:@"维修成本：%@",model.cost];
        LRViewBorderRadius(cell.btn, 15, 1, [UIColor blueColor]);
        [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    FeiYong_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PaiDanModel *model = [self.arr objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"保养项目：%@",model.equipmentDetail_model.name];
    cell.lab2.text = [NSString stringWithFormat:@"保养成本：%@",model.cost];
    LRViewBorderRadius(cell.btn, 15, 1, [UIColor blueColor]);
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)clickbtn:(UIButton *)sender{
    FeiYong_Cell *cell = (FeiYong_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.arr objectAtIndex:indexpath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认删除？" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"id":model.id,
                };
        NSString *str;
        if ([self.navigationItem.title isEqualToString:@"维修费用"]){
            str= KURLNSString(@"servlet/equipment/equipmentmaintenancedetail/delete");
        }else{
            str=KURLNSString(@"servlet/equipment/equipmentmaintaindetail/delete");
        }
        [session POST:str parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //NSLog(@"--- ---%@",dic);
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController      *alert = [UIAlertController alertControllerWithTitle:@"删除成功！" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.arr removeObjectAtIndex:indexpath.row];
                    [weakSelf.tableview deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexpath] withRowAnimation:UITableViewRowAnimationAutomatic];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }];
    [alert addAction:sure];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
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
        if (self.arr.count == totalnum) {
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
    NSString *str;
    if ([self.navigationItem.title isEqualToString:@"维修费用"]){
        str = KURLNSString(@"servlet/equipment/equipmentmaintenancedetail/list");
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"sorttype":@"asc",
                @"sort":@"undefined",
                @"page":[NSString stringWithFormat:@"%ld",page],
                @"maintenanceId":self.idstr,
                };
    }else{
        str = KURLNSString(@"servlet/equipment/equipmentmaintaindetail/list");
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"sorttype":@"asc",
                @"sort":@"undefined",
                @"page":[NSString stringWithFormat:@"%ld",page],
                @"maintainId":self.idstr,
                };
    }
//    NSLog(@"%@----%@",str,dic);
    [session POST:str parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                        NSLog(@"guowai----%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.arr removeAllObjects];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentDetail];
                model.equipmentDetail_model = model1;

                
                [weakSelf.arr addObject:model];
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
    NSString *str;
    if ([self.navigationItem.title isEqualToString:@"维修费用"]){
        str = KURLNSString(@"servlet/equipment/equipmentmaintenancedetail/list");
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"sorttype":@"asc",
                @"sort":@"undefined",
                @"page":[NSString stringWithFormat:@"%ld",page],
                @"maintenanceId":self.idstr,
                };
    }else{
        str = KURLNSString(@"servlet/equipment/equipmentmaintaindetail/list");
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"sorttype":@"asc",
                @"sort":@"undefined",
                @"page":[NSString stringWithFormat:@"%ld",page],
                @"maintainId":self.idstr,
                };
    }
    [session POST:str parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentDetail];
                model.equipmentDetail_model = model1;
                
                [weakSelf.arr addObject:model];
            }
        }
        page++;
        [weakSelf.tableview reloadData];
        [weakSelf.tableview.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [weakSelf.tableview.mj_footer endRefreshing];
    }];
}



- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":self.idstr,
            };
    NSString *str;
    if ([self.navigationItem.title isEqualToString:@"维修费用"]){
        str = KURLNSString(@"servlet/equipment/equipmentmaintenance/editMoney/inittext");
    }else{
        str = KURLNSString(@"servlet/equipment/equipmentmaintain/editMoney/inittext");
    }
    [session POST:str parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//          NSLog(@"%@",dic);
        
        [weakSelf.arr1 removeAllObjects];
        if (![[dic objectForKey:@"equipmentDetailList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"equipmentDetailList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr1 addObject:model];
            }
        }
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}








- (NSMutableArray *)arr{
    if (_arr == nil) {
        self.arr = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr;
}
- (NSMutableArray *)arr1{
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
@end

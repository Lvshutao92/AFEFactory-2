//
//  PaiDan_jrsz_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PaiDan_jrsz_ViewController.h"
#import "JRSZ_2_Cell.h"
#import "PaiDanModel.h"
@interface PaiDan_jrsz_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    UITextField *TextField1;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation PaiDan_jrsz_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 108.3, SCREEN_WIDTH, 5)];
    lab.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [self.view addSubview:lab];
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    TextField1.delegate = self;
    UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    btn.backgroundColor = RGBACOLOR(32.0, 157.0, 149.0, 1.0);
    [btn setTitle:@"新增" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickadd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, height+50, SCREEN_WIDTH, SCREEN_HEIGHT-160)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"JRSZ_2_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    [self.view bringSubviewToFront:btn];
    [self setUpReflash];
   
}


- (void)clickadd{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:                                        @"新增窗口" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TextField1 = alertController.textFields.firstObject;
        if (TextField1.text!=nil) {
            
            AFHTTPSessionManager *session = [Manager returnsession];
            __weak typeof(self) weakSelf = self;
            NSDictionary *dic = [[NSDictionary alloc]init];
            dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                    @"holidayDay":TextField1.text,
                    };
            [session POST:KURLNSString(@"servlet/production/productionholiday/add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dic = [Manager returndictiondata:responseObject];
//                            NSLog(@"+++%@",dic);
                if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加成功" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                       
                    }];
                    [alert addAction:cancel];
                    [weakSelf presentViewController:alert animated:YES completion:nil];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            }];
           
            
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"日期不能为空" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }]];
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        TextField1 = textField;
        textField.placeholder = @"日期";
        textField.delegate = self;
    }];
    [self presentViewController:alertController animated:true completion:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
           KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                TextField1.text = str;
            }
        };
        [picker show];
         return NO;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    JRSZ_2_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[JRSZ_2_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (model.holidayDay == nil) {
        cell.lab1.text = [NSString stringWithFormat:@"日期：%@",@"-"];
    }else{
        cell.lab1.text = [NSString stringWithFormat:@"日期：%@",model.holidayDay];
    }

    if (model.holidayWeek == nil) {
        cell.lab2.text = [NSString stringWithFormat:@"星期：%@",@"-"];
    }else{
        cell.lab2.text = [NSString stringWithFormat:@"星期：%@",model.holidayWeek];
    }
    LRViewBorderRadius(cell.btn, 10, 1, [UIColor blackColor]);
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}




- (void)clickbtn:(UIButton *)sender{
        JRSZ_2_Cell *cell = (JRSZ_2_Cell *)[[sender superview] superview];
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
        [session POST:KURLNSString(@"servlet/production/productionholiday/delete") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//            NSLog(@"+++%@",dic);
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
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
            @"sort":@"holidayDay",
            
            @"holidayDay":@"",
            @"holidayWeek":@"",
           
            };
    [session POST:KURLNSString(@"servlet/production/productionholiday/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
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
            @"sort":@"holidayDay",
            
            @"holidayDay":@"",
            @"holidayWeek":@"",
            
            };
    [session POST:KURLNSString(@"servlet/production/productionholiday/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
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

//
//  PiLiang_C_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/3.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "PiLiang_C_ViewController.h"
#import "LLDCK_10_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface PiLiang_C_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    UITextField *text8;
    NSString *status;
    UIView *window;
    UIScrollView *bgview;
    
    
    UIView *bgwindow;
}
@property(nonatomic, strong)NSMutableArray *dataArray1;
@property(nonatomic, strong)UITableView *tableview1;

@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation PiLiang_C_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    status = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray1 = [@[@"待入库",@"已接单",@"已入库"]mutableCopy];
    UIBarButtonItem *bars = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bars;
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-0)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"LLDCK_10_Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableview];
    
    
    [self setupview1];
    
    [self setup_tableview];
}
- (void)setup_tableview{
    bgwindow = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgwindow.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    bgwindow.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapbgwindowview:)];
    tap.delegate = self;
    [bgwindow addGestureRecognizer:tap];
    [self.view addSubview:bgwindow];
    [self.view bringSubviewToFront:bgwindow];
    
    UILabel *toplab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-450.5, SCREEN_WIDTH, 50)];
    toplab.backgroundColor = [UIColor whiteColor];
    toplab.text = @"单据状态";
    toplab.textAlignment = NSTextAlignmentCenter;
    [bgwindow addSubview:toplab];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-400, SCREEN_WIDTH, 400)];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [bgwindow addSubview:self.tableview1];
    
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.tableview1.tableFooterView = v;
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return YES;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIImageView"]) {
        return YES;
    }
    return NO;
}
- (void)clicktapbgwindowview:(UITapGestureRecognizer *)tap{
    bgwindow.hidden = YES;
}


- (void)clicksearch{
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text1 resignFirstResponder];
    [text4 resignFirstResponder];
    [text5 resignFirstResponder];
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    text5.text = @"";
    text6.text = @"";
    text7.text = @"";
    text8.text = @"";
    status = @"";
    if ( window.hidden == YES) {
        window.hidden = NO;
    }else{
        window.hidden = YES;
    }
}
- (void)setupview1{
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    window = [[UIView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT-height)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    bgview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    bgview.backgroundColor = [UIColor whiteColor];
    bgview.userInteractionEnabled = YES;
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 40)];
    lab1.text = @"入库单号";
    [bgview addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入入库单号";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [bgview addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"FCNO";
    [bgview addSubview:lab2];
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"请输入FCNO";
    [bgview addSubview: text2];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    lab3.text = @"生产单号";
    [bgview addSubview:lab3];
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.placeholder = @"请输入生产单号";
    [bgview addSubview: text3];
    
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 290, SCREEN_WIDTH-20, 40)];
    lab4.text = @"领料单号";
    [bgview addSubview:lab4];
    text4 = [[UITextField alloc] initWithFrame:CGRectMake(10, 335, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    text4.placeholder = @"请输入领料单号";
    [bgview addSubview: text4];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 385, SCREEN_WIDTH-20, 40)];
    lab5.text = @"订单编号";
    [bgview addSubview:lab5];
    text5 = [[UITextField alloc] initWithFrame:CGRectMake(10, 430, SCREEN_WIDTH-20, 40)];
    text5.delegate = self;
    text5.borderStyle = UITextBorderStyleRoundedRect;
    text5.placeholder = @"请输入订单编号";
    [bgview addSubview: text5];
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 480, SCREEN_WIDTH-20, 40)];
    lab6.text = @"单据状态";
    [bgview addSubview:lab6];
    text6 = [[UITextField alloc] initWithFrame:CGRectMake(10, 525, SCREEN_WIDTH-20, 40)];
    text6.delegate = self;
    text6.borderStyle = UITextBorderStyleRoundedRect;
    text6.placeholder = @"请选择";
    [bgview addSubview: text6];
    
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 575, SCREEN_WIDTH-20, 40)];
    lab7.text = @"入库日期";
    [bgview addSubview:lab7];
    
    
    text7 = [[UITextField alloc] initWithFrame:CGRectMake(10, 620, SCREEN_WIDTH/2-20, 40)];
    text7.delegate = self;
    text7.borderStyle = UITextBorderStyleRoundedRect;
    text7.placeholder = @"请输入开始日期";
    [bgview addSubview: text7];
    
   
    text8 = [[UITextField alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2+10, 620, SCREEN_WIDTH/2-20, 40)];
    text8.delegate = self;
    text8.borderStyle = UITextBorderStyleRoundedRect;
    text8.placeholder = @"请输入结束日期";
    [bgview addSubview: text8];
    
    bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-249);
    bgview.contentSize = CGSizeMake(0, 750);
    [window addSubview:bgview];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-250, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-249.5, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-250,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    [self setUpReflash];
}
- (void)cancle{
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text1 resignFirstResponder];
    [text4 resignFirstResponder];
    [text5 resignFirstResponder];
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    text5.text = @"";
    text6.text = @"";
    text7.text = @"";
    text8.text = @"";
    status = @"";
    window.hidden = YES;
}
- (void)sure{
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text1 resignFirstResponder];
    [text4 resignFirstResponder];
    [text5 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    if (text5.text.length == 0) {
        text5.text = @"";
    }
    if (text6.text.length == 0) {
        text6.text = @"";
    }
    if (text7.text.length == 0) {
        text7.text = @"";
    }
    if (text8.text.length == 0) {
        text8.text = @"";
    }
    if (status.length == 0) {
        status = @"";
    }
    window.hidden = YES;
    [self setUpReflash];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text6]) {
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
        [text1 resignFirstResponder];
        [text4 resignFirstResponder];
        [text5 resignFirstResponder];
        bgwindow.hidden = NO;
        return NO;
    }
    if ([textField isEqual:text7]) {
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
        [text1 resignFirstResponder];
        [text4 resignFirstResponder];
        [text5 resignFirstResponder];
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text7.text = str;
            }
        };
        [self.view bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    if ([textField isEqual:text8]) {
        [text2 resignFirstResponder];
        [text3 resignFirstResponder];
        [text1 resignFirstResponder];
        [text4 resignFirstResponder];
        [text5 resignFirstResponder];
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text8.text = str;
            }
        };
        [self.view bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    return YES;
}













- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
         text6.text = self.dataArray1[indexPath.row];
        
        if ([text6.text isEqualToString:@"待入库"]) {
            status = @"create";
        }else if ([text6.text isEqualToString:@"已接单"]) {
            status = @"working";
        }else if ([text6.text isEqualToString:@"已入库"]) {
            status = @"finished";
        }
       
        bgwindow.hidden = YES;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 60;
    }
    return 400;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray1.count;
    }
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.tableview1]) {
        static NSString *identifierCell = @"cells";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = self.dataArray1[indexPath.row];
        return cell;
    }
    
    
    
    static NSString *identifierCell = @"cell1";
    LLDCK_10_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[LLDCK_10_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    cell.lab1.text = [NSString stringWithFormat:@"入库单号：%@",model.storageNo];
    cell.lab2.text = [NSString stringWithFormat:@"FCNO：%@",model.fcno];
    cell.lab3.text = [NSString stringWithFormat:@"产品数量：%@",model.quantity];
    
    cell.lab4.text = [NSString stringWithFormat:@"生产单号：%@",model.productionOrderNo];
    cell.lab5.text = [NSString stringWithFormat:@"领料单号：%@",model.pickOrderNo];
    cell.lab6.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    
    if ([model.status isEqualToString:@"create"]) {
        cell.lab7.text = @"状态：待入库";
    }else if ([model.status isEqualToString:@"working"]) {
        cell.lab7.text = @"状态：已接单";
    }else if ([model.status isEqualToString:@"finished"]) {
        cell.lab7.text = @"状态：已入库";
    }
    
    
    if (model.grabPersonName == nil) {
        cell.lab8.text = @"接单人：-";
    }else{
        cell.lab8.text = [NSString stringWithFormat:@"接单人：%@",model.grabPersonName];
    }
    
    if (model.grabTime == nil) {
        cell.lab9.text = @"入库日期：-";
    }else{
        cell.lab9.text = [NSString stringWithFormat:@"入库日期：%@",[Manager TimeCuoToTime:model.grabTime]];
    }
    
    
    if (model.forkliftPersonName == nil) {
        cell.lab10.text = @"叉车工：-";
    }else{
        cell.lab10.text = [NSString stringWithFormat:@"叉车工：%@",model.forkliftPersonName];
    }
    
    
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
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"desc",
            @"sort":@"storageNo",
            
            
            @"storageNo":text1.text,
            @"fcno":text2.text,
            @"productionOrderNo":text3.text,
            @"pickOrderNo":text4.text,
            
            @"orderNo":text5.text,
            @"status":status,
            @"finishedStartDate":text7.text,
            @"finishedEndDate":text8.text,
            };
    //     NSLog(@"%@",dic);
    [session POST:KURLNSString(@"servlet/production/productionorderstorage/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //                     NSLog(@"%@",dic);
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
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"desc",
            @"sort":@"storageNo",
            
            
            @"storageNo":text1.text,
            @"fcno":text2.text,
            @"productionOrderNo":text3.text,
            @"pickOrderNo":text4.text,
            
            @"orderNo":text5.text,
            @"status":status,
            @"finishedStartDate":text7.text,
            @"finishedEndDate":text8.text,
            };
    //     NSLog(@"%@",dic);
    [session POST:KURLNSString(@"servlet/production/productionorderstorage/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}
@end

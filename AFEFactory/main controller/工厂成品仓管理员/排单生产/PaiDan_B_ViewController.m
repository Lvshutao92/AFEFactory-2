//
//  PaiDan_B_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/3.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "PaiDan_B_ViewController.h"
#import "HCDSH_7_Cell.h"
#import "PaiDanModel.h"
#import "PLDD_details_ViewController.h"

#import "PLDD_one_details_ViewController.h"
#import "PLDD_two_details_ViewController.h"
#import "PLDD_three_details_ViewController.h"
#import "PLDD_four_details_ViewController.h"
@interface PaiDan_B_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UIView *window;
    UIScrollView *bgview;
    UILabel *titleLabel;
    NSString *status;
    
    UIView *bgwindow;
}
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray1;



@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation PaiDan_B_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    status = @"";
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 108.3, SCREEN_WIDTH, 5)];
    lab.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [self.view addSubview:lab];
    self.dataArray1 = [@[@"已确认",@"生产中",@"待发货",@"已发货",@"已取消"]mutableCopy];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"HCDSH_7_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
    [self setupview1];
    [self setup_tableview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewappear:) name:@"SCBZ_PLDD_appear" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cheng_pin_cang__PiLiangDingDan:) name:@"cheng_pin_cang__PiLiangDingDan" object:nil];
}
- (void)cheng_pin_cang__PiLiangDingDan:(NSNotification *)text {
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text1 resignFirstResponder];
    
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    status = @"";
    if ( window.hidden == YES) {
        window.hidden = NO;
    }else{
        window.hidden = YES;
    }
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
    
    UILabel *toplab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-500.5, SCREEN_WIDTH, 50)];
    toplab.backgroundColor = [UIColor whiteColor];
    toplab.text = @"订单状态";
    toplab.textAlignment = NSTextAlignmentCenter;
    [bgwindow addSubview:toplab];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-450, SCREEN_WIDTH, 450)];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [bgwindow addSubview:self.tableview1];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview1.tableFooterView = v;
    
}
- (void)setupview1{
    
    window = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    bgview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    bgview.backgroundColor = [UIColor whiteColor];
    bgview.userInteractionEnabled = YES;
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 40)];
    lab1.text = @"订单编号";
    [bgview addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入订单编号";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [bgview addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"客户简称";
    [bgview addSubview:lab2];
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"请输入客户简称";
    [bgview addSubview: text2];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    lab3.text = @"出货单号";
    [bgview addSubview:lab3];
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.placeholder = @"请输入出货单号";
    [bgview addSubview: text3];
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 290, SCREEN_WIDTH-20, 40)];
    lab4.text = @"订单状态";
    [bgview addSubview:lab4];
    text4 = [[UITextField alloc] initWithFrame:CGRectMake(10, 335, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    text4.placeholder = @"请选择";
    text4.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [bgview addSubview: text4];
    
    
    
    
    bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-249);
//    bgview.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
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
}
- (void)cancle{
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text1 resignFirstResponder];
    
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    status = @"";
    
    window.hidden = YES;
}
- (void)sure{
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text1 resignFirstResponder];
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
    if (status.length == 0) {
        status = @"";
    }
    window.hidden = YES;
    [self setUpReflash];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text4]) {
        bgwindow.hidden = NO;
        return NO;
    }
    return YES;
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










- (void)viewappear:(NSNotification *)text {
    [self setUpReflash];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 60;
    }
    return 290;
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
    static NSString *identifierCell = @"cell";
    HCDSH_7_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[HCDSH_7_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.line.hidden = YES;
    cell.btn.hidden = YES;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (model.orderNo == nil) {
        cell.lab1.text = [NSString stringWithFormat:@"订单编号：%@",@"-"];
    }else{
        cell.lab1.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    }
    
    cell.lab2.text = [NSString stringWithFormat:@"客户简称：%@",model.dealerName];
    
    
    
    
    if ([model.orderStatus isEqualToString:@"confirm"]) {
        cell.lab3.textColor = [UIColor blackColor];
        cell.lab3.text =@"订单状态：待确认订单";
    }else  if ([model.orderStatus isEqualToString:@"confirmed"]) {
        cell.lab3.textColor = [UIColor blackColor];
        cell.lab3.text =@"订单状态：已确认订单";
    }else  if ([model.orderStatus isEqualToString:@"production"]) {
        cell.lab3.textColor = RGBACOLOR(32, 157, 149, 1.0);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"订单状态：生产中订单"];
        NSRange range = NSMakeRange(0, 5);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab3 setAttributedText:noteStr];
    }else  if ([model.orderStatus isEqualToString:@"delivery"]) {
        cell.lab3.textColor = [UIColor blackColor];
        cell.lab3.text =@"订单状态：已发货订单";
    }else  if ([model.orderStatus isEqualToString:@"cancel"]) {
        cell.lab3.textColor = [UIColor blackColor];
        cell.lab3.text =@"订单状态：已取消订单";
    }else  if ([model.orderStatus isEqualToString:@"undelivery"]) {
        cell.lab3.textColor = [UIColor blackColor];
        cell.lab3.text =@"订单状态：待发货订单";
    }
    
    
    if (model.container == nil) {
        cell.lab4.text = [NSString stringWithFormat:@"集装箱：%@",@"-"];
    }else{
        cell.lab4.text = [NSString stringWithFormat:@"集装箱：%@",model.container];
    }
    if (model.planDeliveryDate == nil) {
        cell.lab5.text = [NSString stringWithFormat:@"计划生产日期：%@",@"-"];
    }else{
        cell.lab5.text = [NSString stringWithFormat:@"计划生产日期：%@",[Manager TimeCuoToTimes:model.planDeliveryDate]];
    }
    if (model.actualDeliveryDate == nil) {
        cell.lab6.text = [NSString stringWithFormat:@"实际生产日期：%@",@"-"];
    }else{
        cell.lab6.text = [NSString stringWithFormat:@"实际生产日期：%@",[Manager TimeCuoToTimes:model.actualDeliveryDate]];
    }
    
    if (model.field7 == nil) {
        cell.lab7.text = [NSString stringWithFormat:@"出货单号：%@",@"-"];
    }else{
        cell.lab7.text = [NSString stringWithFormat:@"出货单号：%@",model.field7];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        text4.text = self.dataArray1[indexPath.row];
        if ([text4.text isEqualToString:@"已确认"]) {
            status = @"confirmed";
        }else if ([text4.text isEqualToString:@"生产中"]) {
            status = @"production";
        }else if ([text4.text isEqualToString:@"待发货"]) {
            status = @"undelivery";
        }else if ([text4.text isEqualToString:@"已发货"]) {
            status = @"delivery";
        }else if ([text4.text isEqualToString:@"已取消"]) {
            status = @"cancel";
        }
        bgwindow.hidden = YES;
    }
    if ([tableView isEqual:self.tableview]){
        PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
        
        
        PLDD_details_ViewController *vc = [[PLDD_details_ViewController alloc] initWithAddVCARY:@[[PLDD_one_details_ViewController new],[PLDD_two_details_ViewController new],[PLDD_three_details_ViewController new],[PLDD_four_details_ViewController new]] TitleS:@[@"订单明细",@"部件清单",@"排单日志",@"操作日志"]];
        
        
        NSDictionary *dict = [[NSDictionary alloc]init];
        dict = @{@"orderNo":model.orderNo,@"orderId":model.id};
        NSNotification *notification =[NSNotification notificationWithName:@"zzpldd" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        
        
        MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        MainNavigationViewController *Nav = [tabBarVc selectedViewController];
        [Nav pushViewController:vc animated:YES];
    }
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
            @"sort":@"createTime",
            
            @"orderNo":text1.text,
            @"dealerName":text2.text,
            @"field7":text3.text,
            @"orderStatus":status,
            };
    [session POST:KURLNSString(@"servlet/order/batch/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",dic);
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
            @"sort":@"createTime",
            
            @"orderNo":text1.text,
            @"dealerName":text2.text,
            @"field7":text3.text,
            @"orderStatus":status,
            };
    [session POST:KURLNSString(@"servlet/order/batch/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}

@end

//
//  PaiDan_A_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/3.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "PaiDan_A_ViewController.h"
#import "Paidan_5_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
#import "PaidanModel2.h"

#import "PDJH_details_ViewController.h"
#import "Details_1_ViewController.h"
#import "Details_2_ViewController.h"
#import "Details_3_ViewController.h"

#import "PaidanjihuaSearch_ViewController.h"
@interface PaiDan_A_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    UIView *vie;
    
    BOOL isorno;
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
    UILabel *lab4;
    UILabel *lab5;
    NSString *string1;
    NSString *string2;
    NSString *string3;
    NSString *string4;
    NSString *string5;
    
    UILabel *lines;
    UIImageView *img;
    
    CGFloat hei;
    
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UIView *window;
    UIScrollView *bgview;
    UILabel *titleLabel;
    NSString *status;
    
    
    UIView *bgwindow;
    
}


@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray11;


@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation PaiDan_A_ViewController

- (void)lodd{
    __weak typeof (self) weakSelf = self;
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/production/productionplan") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        
        NSDictionary *dict = [dic objectForKey:@"rows"];
        
        NSMutableAttributedString *noteStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"每日正常产量：%@",[[dict objectForKey:@"productionConfig"]objectForKey:@"normalOutput"]]];
        NSRange range1 = NSMakeRange(0, 7);
        [noteStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        [lab1 setAttributedText:noteStr1];
        
        
        
        NSMutableAttributedString *noteStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"每日加班产量：%@",[[dict objectForKey:@"productionConfig"]objectForKey:@"overtimeOutput"]]];
        NSRange range2 = NSMakeRange(0, 7);
        [noteStr2 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        [lab2 setAttributedText:noteStr2];
        
        
        NSMutableAttributedString *noteStr3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"允许插单最早日期：%@，如遇休息日，则顺延",[dict objectForKey:@"productionConfigstartDate"]]];
        NSRange range3 = NSMakeRange(0, 9);
        [noteStr3 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range3];
        [lab3 setAttributedText:noteStr3];
        
        
        
        NSMutableAttributedString *noteStr4 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已排计划最晚日期：%@",[dict objectForKey:@"productionConfigendDate"]]];
        NSRange range4 = NSMakeRange(0, 9);
        [noteStr4 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range4];
        [lab4 setAttributedText:noteStr4];
        
        NSMutableAttributedString *noteStr5 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"最近休息计划：%@",[dict objectForKey:@"holidayStr"]]];
        NSRange range5 = NSMakeRange(0, 7);
        [noteStr5 addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range5];
        [lab5 setAttributedText:noteStr5];
        
        lab5.font = [UIFont systemFontOfSize:13];
        lab5.numberOfLines = 0;
        lab5.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [lab5 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
        hei = size.height;
        
        
        
        
        [weakSelf.dataArray11 removeAllObjects];
                if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
                    NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"dealerList"];
                    for (NSDictionary *dic in arr) {
                        PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                        [weakSelf.dataArray11 addObject:model];
                    }
                }
        [weakSelf.tableview1 reloadData];
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
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
    toplab.text = @"经销商名称";
    toplab.textAlignment = NSTextAlignmentCenter;
    [bgwindow addSubview:toplab];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-450, SCREEN_WIDTH, 450)];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell11"];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [bgwindow addSubview:self.tableview1];
    
   
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    self.tableview1.tableFooterView = v;
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 108.3, SCREEN_WIDTH, 5)];
    lab.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [self.view addSubview:lab];
    
   
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"Paidan_5_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setuptopview];
    [self setUpReflash];
    
    [self setupview1];
    [self setup_tableview];
    [self lodd];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cheng_pin_cang__PaiDanJiHua:) name:@"cheng_pin_cang__PaiDanJiHua" object:nil];
}







- (void)cheng_pin_cang__PaiDanJiHua:(NSNotification *)text {
    [text2 resignFirstResponder];
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    if ( window.hidden == YES) {
        window.hidden = NO;
    }else{
        window.hidden = YES;
    }
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
    lab1.text = @"经销商名称";
    [bgview addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入经销商名称";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [bgview addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"订单编号";
    [bgview addSubview:lab2];
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"请输入订单编号";
    [bgview addSubview: text2];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    lab3.text = @"计划日期";
    [bgview addSubview:lab3];
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.placeholder = @"请选择";
    [bgview addSubview: text3];
    text1.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    text3.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    
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
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    window.hidden = YES;
}
- (void)sure{
    [text2 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    window.hidden = YES;
    [self setUpReflash];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text1]) {
        [text2 resignFirstResponder];
        bgwindow.hidden = NO;
        return NO;
    }
    if ([textField isEqual:text3]) {
        [text2 resignFirstResponder];
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text3.text = str;
            }
        };
        [self.view bringSubviewToFront:picker];
        [picker show];
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































- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)setuptopview{
    vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 47)];
    lable.text = @"排单说明";
    lable.font = [UIFont systemFontOfSize:18];
    lable.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickinfor:)];
    [lable addGestureRecognizer:tap];
    [vie addSubview:lable];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 47, SCREEN_WIDTH, 3)];
    line.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [vie addSubview:line];
    self.tableview.tableHeaderView = vie;
    
    img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 15, 20, 20)];
    img.image = [UIImage imageNamed:@"jiantou"];
    [vie addSubview:img];
    
    lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, SCREEN_WIDTH-20, 20)];
    lab1.hidden = YES;
    lab1.font = [UIFont systemFontOfSize:13];
    lab1.textColor = [UIColor redColor];
    [vie addSubview:lab1];
    
    lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 80, SCREEN_WIDTH-20, 20)];
    lab2.hidden = YES;
    lab2.font = [UIFont systemFontOfSize:13];
    lab2.textColor = [UIColor redColor];
    [vie addSubview:lab2];
    
    lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 105, SCREEN_WIDTH-20, 20)];
    lab3.hidden = YES;
    lab3.font = [UIFont systemFontOfSize:13];
    lab3.textColor = [UIColor redColor];
    [vie addSubview:lab3];
    
    lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, SCREEN_WIDTH-20, 20)];
    lab4.hidden = YES;
    lab4.font = [UIFont systemFontOfSize:13];
    lab4.textColor = [UIColor redColor];
    [vie addSubview:lab4];
    
    lab5 = [[UILabel alloc]init];
    lab5.hidden = YES;
    lab5.font = [UIFont systemFontOfSize:13];
    lab5.textColor = [UIColor redColor];
    [vie addSubview:lab5];
    
    lines = [[UILabel alloc]init];
    lines.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    lines.hidden = YES;
    [vie addSubview:lines];
    
    
}
- (void)clickinfor:(UITapGestureRecognizer *)sender{
    if (isorno == NO) {
        lab5.frame = CGRectMake(10, 155, SCREEN_WIDTH-40, hei);
        [vie addSubview:lab5];
        
        lines.frame = CGRectMake(0, 160+hei, SCREEN_WIDTH, 3);
        [vie addSubview:lines];
        
        vie.frame = CGRectMake(0, 0, SCREEN_WIDTH, 163+hei);
        self.tableview.tableHeaderView = vie;
        
        lab1.hidden = NO;
        lab2.hidden = NO;
        lab3.hidden = NO;
        lab4.hidden = NO;
        lab5.hidden = NO;
        lines.hidden = NO;
        
        img.image = [UIImage imageNamed:@"jiantou1"];
        [vie addSubview:img];
    }else{
        vie.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
        self.tableview.tableHeaderView = vie;
        lab1.hidden = YES;
        lab2.hidden = YES;
        lab3.hidden = YES;
        lab4.hidden = YES;
        lab5.hidden = YES;
        lines.hidden = YES;
        img.image = [UIImage imageNamed:@"jiantou"];
        [vie addSubview:img];
    }
    isorno = !isorno;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        PaiDanModel *model = [self.dataArray11 objectAtIndex:indexPath.row];
        text1.text = model.dealerName;
        bgwindow.hidden = YES;
    }
    if ([tableView isEqual:self.tableview]) {
        PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
        
        PDJH_details_ViewController *vc = [[PDJH_details_ViewController alloc] initWithAddVCARY:@[[Details_1_ViewController new],[Details_2_ViewController new],[Details_3_ViewController new]] TitleS:@[@"订单明细",@"部件列表",@"操作日志"]];
        
        NSDictionary *dict = [[NSDictionary alloc]init];
        dict = @{@"orderNo":model.orderNo,@"orderId":model.orderId};
        NSNotification *notification =[NSNotification notificationWithName:@"details" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        MainNavigationViewController *Nav = [tabBarVc selectedViewController];
        [Nav pushViewController:vc animated:YES];
    }
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 60;
    }
    return 295;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray11.count;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.tableview1]) {
        static NSString *identifierCell = @"cell11";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.dataArray11 objectAtIndex:indexPath.row];
        
        cell.textLabel.text = model.dealerName;
        return cell;
    }
   
    static NSString *identifierCell = @"cell";
    Paidan_5_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[Paidan_5_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"计划日期：%@",model.planDate];
    cell.lab2.text = [NSString stringWithFormat:@"公司名称：%@",model.oeder_model.dealerName];
    cell.lab3.text = [NSString stringWithFormat:@"订单编号：%@",model.orderNo];
    cell.lab4.text = [NSString stringWithFormat:@"订单总量：%@",model.totalQuantity];
    
    
    
    
    
    
    if (model.purchasePlan != nil) {
        if ([model.purchasePlan_model.orderStatus isEqualToString:@"created"]) {
            LRViewBorderRadius(cell.lab6, 5, 0, RGBACOLOR(46, 165, 204, 0.41));
            cell.lab6.backgroundColor = RGBACOLOR(46, 165, 204, 0.41);
            cell.lab6.textColor = [UIColor whiteColor];
            
            cell.lab7.textColor = [UIColor orangeColor];
            LRViewBorderRadius(cell.lab7, 5, 2, [UIColor orangeColor]);
        }else{
            LRViewBorderRadius(cell.lab6, 5, 0, RGBACOLOR(46, 165, 204, 0.41));
            cell.lab6.backgroundColor = RGBACOLOR(46, 165, 204, 0.41);
            LRViewBorderRadius(cell.lab7, 5, 0, [UIColor orangeColor]);
            cell.lab7.backgroundColor = [UIColor orangeColor];
            
            cell.lab6.textColor = [UIColor whiteColor];
            cell.lab7.textColor = [UIColor whiteColor];
        }
    }else {
        cell.lab6.backgroundColor = [UIColor whiteColor];
        cell.lab7.backgroundColor = [UIColor whiteColor];
        cell.lab8.backgroundColor = [UIColor whiteColor];
        
        
        cell.lab6.textColor = RGBACOLOR(46, 165, 204, 0.41);
        LRViewBorderRadius(cell.lab6, 5, 2, RGBACOLOR(46, 165, 204, 0.41));
        
        cell.lab7.textColor = [UIColor orangeColor];
        LRViewBorderRadius(cell.lab7, 5, 2, [UIColor orangeColor]);
    }
    cell.lab8.textColor = [UIColor redColor];
    LRViewBorderRadius(cell.lab8, 5, 2, [UIColor redColor]);
    
    
    
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
            @"sorttype":@"asc",
            @"sort":@"planDate,seq",
            @"order.dealerName":text1.text,
            @"orderNo":text2.text,
            @"planDate":text3.text,
            };
    [session POST:KURLNSString(@"servlet/production/productionplan/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.order];
            model.oeder_model = model1;
            
            PaidanModel2 *model2 = [PaidanModel2 mj_objectWithKeyValues:model.purchasePlan];
            model.purchasePlan_model = model2;
            
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
            @"sort":@"planDate,seq",
            @"order.dealerName":text1.text,
            @"orderNo":text2.text,
            @"planDate":text3.text,
            };
    [session POST:KURLNSString(@"servlet/production/productionplan/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *diction = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[diction objectForKey:@"rows"] objectForKey:@"resultList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.order];
            model.oeder_model = model1;
            
            PaidanModel2 *model2 = [PaidanModel2 mj_objectWithKeyValues:model.purchasePlan];
            model.purchasePlan_model = model2;
            
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
- (NSMutableArray *)dataArray11 {
    if (_dataArray11 == nil) {
        self.dataArray11 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray11;
}
@end

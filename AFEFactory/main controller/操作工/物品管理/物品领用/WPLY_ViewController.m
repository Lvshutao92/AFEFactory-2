//
//  WPLY_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WPLY_ViewController.h"
#import "BJRKD_12_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"

#import "WPLY_1ceng_ViewController.h"
#import "WPLY_details_ViewController.h"
#import "WPLY_edit_ViewController.h"
@interface WPLY_ViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    UIView *window;
    UITextField *text1;
    UITextField *text2;
    NSString *idstring;
    
    
    
    UIView *bgwindowview;
    UILabel *bglab;
}
@property(nonatomic,strong)UIScrollView *bgview;
@property(nonatomic,strong)UILabel *toplab;

@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(strong,nonatomic)UITableView    *tableview1;


@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation WPLY_ViewController
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text2]) {
        bgwindowview.hidden = NO;
        [self.tableview1 reloadData];
        return NO;
    }
    return YES;
}
- (void)cancle{
    [text1 resignFirstResponder];
    text1.text = @"";
    text2.text = @"";
    idstring = @"";
    window.hidden = YES;
}
- (void)sure{
    [text1 resignFirstResponder];
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (idstring.length == 0) {
        idstring = @"";
    }
    [self setUpReflash];
    window.hidden = YES;
}
- (void)clicksearch{
    [text1 resignFirstResponder];
    text1.text = @"";
    text2.text = @"";
    idstring = @"";
    if (window.hidden == YES) {
         window.hidden = NO;
    }else{
         window.hidden = YES;
    }
}
- (void)setupButton {
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    window = [[UIView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    //window.windowLevel = UIWindowLevelNormal;
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    self.bgview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    self.bgview.backgroundColor = [UIColor whiteColor];
    self.bgview.userInteractionEnabled = YES;
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 40)];
    lab1.text = @"领用单编号";
    [self.bgview addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.text= @"";
    text1.placeholder = @"请输入领用单编号";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"状态";
    [self.bgview addSubview:lab2];
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.text= @"";
    text2.placeholder = @"请选择";
    text2.backgroundColor = [UIColor colorWithWhite:.85 alpha:.4];
    [self.bgview addSubview: text2];
    
    self.bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-199);
//    self.bgview.contentSize = CGSizeMake(0, SCREEN_HEIGHT*1.1);
    [window addSubview:self.bgview];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-200, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-199, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
    [self setUpReflash];
}
- (void)setupview_tableview{
    bgwindowview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgwindowview.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    bgwindowview.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapbgwindowview:)];
    tap.delegate = self;
    [bgwindowview addGestureRecognizer:tap];
    [self.view addSubview:bgwindowview];
    [self.view bringSubviewToFront:bgwindowview];
    
    bglab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-400.5, SCREEN_WIDTH, 50)];
    bglab.backgroundColor = [UIColor whiteColor];
    bglab.textAlignment = NSTextAlignmentCenter;
    bglab.text = @"状态";
    [bgwindowview addSubview:bglab];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350)];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [bgwindowview addSubview:self.tableview1];
    
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
    bgwindowview.hidden = YES;
}













- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    idstring = @"";
    self.dataArray1 = [@[@"已申请待审核",@"待领用",@"已取消",@"领用完成",@"管理员驳回",@"管理员取消"]mutableCopy];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickadd)];
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItems = @[bar,bar1];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"BJRKD_12_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setupButton];
    [self setupview_tableview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewappear:) name:@"wply1ceng_appear" object:nil];
}
- (void)viewappear:(NSNotification *)text {
    [self setUpReflash];
}

- (void)clickadd{
    WPLY_1ceng_ViewController *vc = [[WPLY_1ceng_ViewController alloc]init];
    [[Manager sharedManager].wplyArr removeAllObjects];
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:vc animated:YES];
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        bgwindowview.hidden = YES;
        text2.text = self.dataArray1[indexPath.row];
        if ([text2.text isEqualToString:@"已申请待审核"]) {
            idstring = @"wait_audit";
        }else if ([text2.text isEqualToString:@"待领用"]) {
            idstring = @"wait_take";
        }else if ([text2.text isEqualToString:@"已取消"]) {
            idstring = @"cancel";
        }else if ([text2.text isEqualToString:@"领用完成"]) {
            idstring = @"finish";
        }else if ([text2.text isEqualToString:@"管理员驳回"]) {
            idstring = @"send_back";
        }else if ([text2.text isEqualToString:@"管理员取消"]) {
            idstring = @"admin_cancel";
        }
    }
    if ([tableView isEqual:self.tableview]) {
        PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
        
        
        WPLY_details_ViewController *vc = [[WPLY_details_ViewController alloc] init];
        vc.takeId = model.id;
        
        MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        MainNavigationViewController *Nav = [tabBarVc selectedViewController];
        [Nav pushViewController:vc animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 60;
    }
    if ([tableView isEqual:self.tableview]){
        PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
        if ([model.state isEqualToString:@"wait_audit"] || [model.state isEqualToString:@"wait_take"]){
            return 180;
        }
        return 135;
    }
    return 0;
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
    BJRKD_12_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[BJRKD_12_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lab5.hidden  = YES;
    cell.lab6.hidden  = YES;
    cell.lab7.hidden  = YES;
    cell.lab8.hidden  = YES;
    cell.lab9.hidden  = YES;
    cell.lab10.hidden = YES;
    cell.lab11.hidden = YES;
    cell.lab12.hidden = YES;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.btn  setTitle:@"取消" forState:UIControlStateNormal];
    [cell.btn1 setTitle:@"修改" forState:UIControlStateNormal];
    
    
    cell.lab1.text = [NSString stringWithFormat:@"领用单编号：%@",model.code];
    
    
    
    
    
    if ([model.state isEqualToString:@"wait_audit"]) {
        cell.lab2.text = @"状态：已申请待审核";
    }else if ([model.state isEqualToString:@"wait_take"]) {
        cell.lab2.text = @"状态：待领用";
    }else if ([model.state isEqualToString:@"cancel"]) {
        cell.lab2.text = @"状态：已取消";
    }else if ([model.state isEqualToString:@"finish"]) {
        cell.lab2.text = @"状态：领用完成";
    }else if ([model.state isEqualToString:@"send_back"]) {
        cell.lab2.text = @"状态：管理员驳回";
    }else if ([model.state isEqualToString:@"admin_cancel"]) {
        cell.lab2.text = @"状态：管理员取消";
    }
    
 
    
    
    if (model.createTime == nil) {
        cell.lab3.text = [NSString stringWithFormat:@"申请时间：%@",@"-"];
    }else{
        cell.lab3.text = [NSString stringWithFormat:@"申请时间：%@",[Manager TimeCuoToTimes:model.createTime]];
    }
    
    if (model.finishTime == nil) {
        cell.lab4.text = [NSString stringWithFormat:@"结束时间：%@",@"-"];
    }else{
        cell.lab4.text = [NSString stringWithFormat:@"结束时间：%@",[Manager TimeCuoToTimes:model.finishTime]];
    }
    
    if ([model.state isEqualToString:@"wait_audit"] || [model.state isEqualToString:@"wait_take"]) {
        cell.btn.hidden = NO;
        cell.btn1.hidden = NO;
        cell.line.hidden = NO;
    }else{
        cell.btn.hidden = YES;
        cell.btn1.hidden = YES;
        cell.line.hidden = YES;
    }
    
    
    
    cell.btn2.hidden = YES;
    cell.btn1width.constant = 50;
    LRViewBorderRadius(cell.btn, 10, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn1, 10, 1, [UIColor blackColor]);
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}



- (void)clickbtn:(UIButton *)sender{
    BJRKD_12_Cell *cell = (BJRKD_12_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认取消吗？" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"id":model.id,
                };
        [session POST:KURLNSString(@"servlet/officegoods/officegoodstake/cancel") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//            NSLog(@"+++%@",dic);
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"取消成功！" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf setUpReflash];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:cancle];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}






- (void)clickbtn1:(UIButton *)sender{
    BJRKD_12_Cell *cell = (BJRKD_12_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    [[Manager sharedManager].wplyArr removeAllObjects];
    
    WPLY_edit_ViewController *vc = [[WPLY_edit_ViewController alloc]init];
    vc.takeId = model.id;
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:vc animated:YES];
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
            @"takerId":[Manager redingwenjianming:@"userid.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"code":text1.text,
            @"state":idstring,
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodstake/my/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
            @"takerId":[Manager redingwenjianming:@"userid.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"code":text1.text,
            @"state":idstring,
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodstake/my/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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



- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}




- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end

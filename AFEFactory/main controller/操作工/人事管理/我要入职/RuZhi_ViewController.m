//
//  RuZhi_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/4.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "RuZhi_ViewController.h"
#import "YuanGong_Cell.h"

#import "PaiDanModel.h"
#import "PaidanModel1.h"

#import "WYRZ_details_ViewController.h"

#import "WYRZ_details_one_ViewController.h"
#import "WYRZ_details_two_ViewController.h"
#import "WYRZ_details_three_ViewController.h"
#import "WYRZ_details_four_ViewController.h"
@interface RuZhi_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation RuZhi_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"YuanGong_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [self setUpReflash];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 470;
    
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    YuanGong_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[YuanGong_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.file)]placeholderImage:[UIImage imageNamed:@"user"]];
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    
    
    cell.lab1.text = [NSString stringWithFormat:@"员工编号：%@",model.personCode];
    cell.lab2.text = [NSString stringWithFormat:@"员工姓名：%@",model.realName];
    if ([model.sex isEqualToString:@"M"]) {
        cell.lab3.text = [NSString stringWithFormat:@"性别：%@",@"男"];
    }else if ([model.sex isEqualToString:@"W"]) {
        cell.lab3.text = [NSString stringWithFormat:@"性别：%@",@"女"];
    }
    
    cell.lab4.text = [NSString stringWithFormat:@"联系电话：%@",model.phone];
    
    if (model.bqq == nil) {
        cell.lab5.text = [NSString stringWithFormat:@"企业QQ：%@",@"-"];
    }else{
        cell.lab5.text = [NSString stringWithFormat:@"企业QQ：%@",model.bqq];
    }
    
    if (model.enterpriseMailbox == nil) {
        cell.lab6.text = [NSString stringWithFormat:@"企业邮箱：%@",@"-"];
    }else{
        cell.lab6.text = [NSString stringWithFormat:@"企业邮箱：%@",model.enterpriseMailbox];
    }
    
    
    cell.lab7.text = [NSString stringWithFormat:@"户籍所在地：%@%@",model.provinceName,model.cityName];
    
    cell.lab8.text = [NSString stringWithFormat:@"所属部门：%@",model.realName];
    cell.lab9.text = [NSString stringWithFormat:@"职位：%@",model.realName];
    
    
    if ([model.status isEqualToString:@"Y"]) {
        cell.lab10.text = @"状态：在职";
    }else  if([model.status isEqualToString:@"N"]) {
        cell.lab10.text = @"状态：离职";
    }else  if([model.status isEqualToString:@"A"]) {
        cell.lab10.text = @"状态：待入职";
    }

    
    
    
    if (model.formalDate == nil || model.formalDate.length == 0) {
        cell.lab11.text = @"转正状态：-";
    }else{
        NSString *str1 = [model.formalDate substringToIndex:10];
        NSDate * ValueDate1 = [self StringTODate:str1];
        
        NSString *str2 = [[self getCurrentTimes] substringToIndex:10];
        NSDate * ValueDate2 = [self StringTODate:str2];
        
        NSInteger days = [Manager calcDaysFromBegin:ValueDate2 end:ValueDate1];
        
        if (days > 0) {
            cell.lab11.text = [NSString stringWithFormat:@"转正状态：%@",@"未转正"];
        }else{
            cell.lab11.text = [NSString stringWithFormat:@"转正状态：%@",@"已转正"];
        }
    }
    
    
    if ([model.payStatus isEqualToString:@"Y"]) {
        cell.lab12.text = @"是否结算工资：是";
    }else{
        cell.lab12.text = @"是否结算工资：否";
    }
    
    LRViewBorderRadius(cell.btn, 5, 1, [UIColor blackColor]);
    
    
    if ([model.status isEqualToString:@"Y"] || [model.status isEqualToString:@"N"]) {
        cell.btn.hidden  = YES;
    }else{
        cell.btn.hidden  = NO;
    }
    
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    LRViewBorderRadius(cell.btn1, 5, 1, [UIColor blackColor]);
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)clickbtn1:(UIButton *)sender{
    YuanGong_Cell *cell = (YuanGong_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    LookPictureViewController *look = [[LookPictureViewController alloc]init];
    look.imgStr = model.file;
    [self.navigationController pushViewController:look animated:YES];
}






- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    WYRZ_details_ViewController *vc = [[WYRZ_details_ViewController alloc] initWithAddVCARY:@[[WYRZ_details_one_ViewController new],[WYRZ_details_two_ViewController new],[WYRZ_details_three_ViewController new],[WYRZ_details_four_ViewController new]] TitleS:@[@"个人资料",@"文件清单", @"合同管理", @"联系地址"]];
    
    NSDictionary *dict = [[NSDictionary alloc]init];
    dict = @{@"id":model.id};
    NSNotification *notification =[NSNotification notificationWithName:@"wyrz_details" object:nil userInfo:dict];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    MainTabbarViewController *tabBarVc = (MainTabbarViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    MainNavigationViewController *Nav = [tabBarVc selectedViewController];
    [Nav pushViewController:vc animated:YES];
    
}
- (void)clickbtn:(UIButton *)sender{
    YuanGong_Cell *cell = (YuanGong_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认入职吗？" message:@"温馨提示" preferredStyle:1];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"id":model.id,
                };
        [session POST:KURLNSString(@"servlet/organization/departmentperson/confirmGet") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //NSLog(@"+++%@",[dic objectForKey:@"message"]);
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确认报到成功！" message:@"温馨提示" preferredStyle:1];
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
    
    
//字符串转日期
- (NSDate *)StringTODate:(NSString *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MMMM-dd";
    [dateFormatter setMonthSymbols:[NSArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",nil]];
    NSDate * ValueDate = [dateFormatter dateFromString:sender];
    return ValueDate;
}

-(NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
    
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
            @"id":[Manager redingwenjianming:@"id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            };
    [session POST:KURLNSString(@"servlet/organization/departmentperson/myindex") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"-------%@",dic);
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
            @"id":[Manager redingwenjianming:@"id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            };
    //    NSLog(@"%@",dic);
    [session POST:KURLNSString(@"servlet/organization/departmentperson/myindex") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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

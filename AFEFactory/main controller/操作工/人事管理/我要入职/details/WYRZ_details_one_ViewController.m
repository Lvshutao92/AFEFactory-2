//
//  WYRZ_details_one_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WYRZ_details_one_ViewController.h"
#import "WYRZ_one_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"

@interface WYRZ_details_one_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *idstr;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation WYRZ_details_one_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"WYRZ_one_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(details:) name:@"wyrz_details" object:nil];
    
}
- (void)details:(NSNotification *)text{
    NSDictionary *dic = text.userInfo;
    idstr = [dic objectForKey:@"id"];
    [self loddeList];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 565;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    WYRZ_one_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[WYRZ_one_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    cell.lab1.text = [NSString stringWithFormat:@"入职日期：%@",model.enterDate];
    cell.lab2.text = [NSString stringWithFormat:@"转正日期：%@",model.formalDate];
    cell.lab3.text = [NSString stringWithFormat:@"身份证号码：%@",model.idCard];
    cell.lab4.text = [NSString stringWithFormat:@"出生日期：%@-%@-%@",model.birthYear,model.birthMonth,model.birthDay];
    cell.lab5.text = [NSString stringWithFormat:@"毕业学校：%@",model.graduationSchool];
    cell.lab6.text = [NSString stringWithFormat:@"毕业日期：%@",model.graduationDate];
    cell.lab7.text = [NSString stringWithFormat:@"专业：%@",model.major];
    
    
    if ([model.education isEqualToString:@"1"]) {
        cell.lab8.text = @"学历：初中";
    }else if ([model.education isEqualToString:@"2"]) {
        cell.lab8.text = @"学历：高中";
    }else if ([model.education isEqualToString:@"3"]) {
        cell.lab8.text = @"学历：本科";
    }else if ([model.education isEqualToString:@"4"]) {
        cell.lab8.text = @"学历：硕士";
    }else if ([model.education isEqualToString:@"5"]) {
        cell.lab8.text = @"学历：博士";
    }else if ([model.education isEqualToString:@"6"]) {
        cell.lab8.text = @"学历：博士后";
    }else if ([model.education isEqualToString:@"7"]) {
        cell.lab8.text = @"学历：大专";
    }else{
        cell.lab8.text = @"学历：-";
    }
    
    
    cell.lab9.text  = [NSString stringWithFormat:@"英语等级：%@",model.englishLevel];
    cell.lab10.text = [NSString stringWithFormat:@"原公司名称：%@",model.historyCompany];
    cell.lab11.text = [NSString stringWithFormat:@"原公司职位：%@",model.historyPosition];
    cell.lab12.text = [NSString stringWithFormat:@"婚姻情况：%@",model.marriage];
    cell.lab13.text = [NSString stringWithFormat:@"社保账号：%@",model.socialSecurityAccount];
    cell.lab14.text = [NSString stringWithFormat:@"公积金账号：%@",model.accumulationFundAccount];
    cell.lab15.text = [NSString stringWithFormat:@"开户银行：%@",model.field1];
    cell.lab16.text = [NSString stringWithFormat:@"银行卡号：%@",model.bankAccount];
    
    return cell;
}


- (void)loddeList{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    if (idstr == nil || idstr.length == 0) {
        idstr = @"";
    }
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"page":@"1",
            @"personId":idstr,
            };
    [session POST:KURLNSString(@"servlet/organization/departmentpersonfile/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"-------%@",dic);
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                [weakSelf.dataArray addObject:model];
            }
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}




- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end

//
//  WYRZ_details_four_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/13.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "WYRZ_details_four_ViewController.h"
#import "HeTong_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface WYRZ_details_four_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *idstr;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation WYRZ_details_four_ViewController

-  (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"HeTong_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(details:) name:@"wyrz_details" object:nil];
    
}
- (void)details:(NSNotification *)text{
    NSDictionary *dic = text.userInfo;
    idstr = [dic objectForKey:@"id"];
    [self loddeList];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    HeTong_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[HeTong_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.btn.hidden = YES;
    cell.lab1.text = [NSString stringWithFormat:@"员工姓名：%@",model.realName];
    cell.lab2.text = [NSString stringWithFormat:@"省份：%@",model.province];
    cell.lab3.text = [NSString stringWithFormat:@"城市：%@",model.city];
    cell.lab4.text = [NSString stringWithFormat:@"区域：%@",model.district];
    cell.lab5.text = [NSString stringWithFormat:@"详细地址：%@",model.address];
    
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
    [session POST:KURLNSString(@"servlet/organization/departmentpersonaddress/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"-------%@",dic);
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

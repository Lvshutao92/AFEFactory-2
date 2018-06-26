//
//  CGJH_3_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/7.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "CGJH_3_ViewController.h"
#import "TimeZhou_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface CGJH_3_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableView;

@end

@implementation CGJH_3_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-100)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"TimeZhou_Cell" bundle:nil] forCellReuseIdentifier:@"cell3"];
    [self.view addSubview:self.tableView];
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(details:) name:@"CGJH_details" object:nil];
    //    [self lod3];
}
- (void)details:(NSNotification *)text{
    NSDictionary *dic = text.userInfo;
    [Manager sharedManager].ids = [dic objectForKey:@"purchasePlanId"];
    [self lod3];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80+height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"cell3";
    TimeZhou_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[TimeZhou_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = [NSString stringWithFormat:@"%@",model.remark];
    cell.lab1.numberOfLines = 0;
    cell.lab1.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab1 sizeThatFits:CGSizeMake(SCREEN_WIDTH-30, MAXFLOAT)];
    cell.lab1height.constant = size.height;
    height= size.height;
    
    cell.lab2.text = [NSString stringWithFormat:@"%@",model.operator];
    cell.lab3.text = [Manager TimeCuoToTimes:model.createTime];
    
    cell.img.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    cell.line.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    return cell;
}


- (void)lod3{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    if ([Manager sharedManager].ids == nil) {
        [Manager sharedManager].ids = @"";
    }
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"purchasePlanId":[Manager sharedManager].ids,
            };
    [session POST:KURLNSString(@"servlet/purchase/purchaseplanlog/log/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = (NSMutableArray *)dic;
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableView reloadData];
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

//
//  PLDD_one_details_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PLDD_one_details_ViewController.h"
#import "HCDSH_3_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface PLDD_one_details_ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat height;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic, strong)UITableView *tableView;

@end

@implementation PLDD_one_details_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 108.3, SCREEN_WIDTH, 5)];
    lab.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [self.view addSubview:lab];
    
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"HCDSH_3_Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.view addSubview:self.tableView];
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(details:) name:@"zzpldd" object:nil];
    [self lod1];
}
- (void)details:(NSNotification *)text{
    NSDictionary *dic = text.userInfo;
    [Manager sharedManager].ids = [dic objectForKey:@"orderNo"];
    [Manager sharedManager].orderid = [dic objectForKey:@"orderId"];
    [self lod1];
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100+height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"cell1";
    HCDSH_3_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[HCDSH_3_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lab1.textColor = RGBACOLOR(102, 102, 102, 1);
    cell.lab2.textColor = RGBACOLOR(102, 102, 102, 1);
    cell.lab3.textColor = RGBACOLOR(102, 102, 102, 1);
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.lab1.text = [NSString stringWithFormat:@"FCNO：%@",model.productCode];
    
    cell.lab2.text = [NSString stringWithFormat:@"名称：%@",model.productNameZh];
    cell.lab2.numberOfLines = 0;
    cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
    cell.lab2height.constant = size.height;
    height = size.height;
    
    cell.lab3.text = [NSString stringWithFormat:@"数量：%@",model.quantity];
    return cell;
}

- (void)lod1{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    if ([Manager sharedManager].orderid == nil) {
        [Manager sharedManager].orderid = @"";
    }
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"orderId":[Manager sharedManager].orderid,
            };
    
    [session POST:KURLNSString(@"servlet/order/orderitem/item/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray removeAllObjects];
//        NSLog(@"+++%@",dic);
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"resultList"];
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

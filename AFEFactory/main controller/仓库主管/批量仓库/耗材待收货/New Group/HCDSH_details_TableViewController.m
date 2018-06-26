//
//  HCDSH_details_TableViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/24.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "HCDSH_details_TableViewController.h"
#import "HCDSH_3_Cell.h"
#import "TimeZhou_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface HCDSH_details_TableViewController ()
{
    CGFloat height;
    CGFloat height1;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataArray1;
@end

@implementation HCDSH_details_TableViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"HCDSH_3_Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"TimeZhou_Cell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self lodLogDetails];
    [self lodOrderDetails];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataArray.count;
    }
    return self.dataArray1.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100+height1;
    }
    return 80+height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *identifierCell = @"cell1";
        HCDSH_3_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[HCDSH_3_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];

        cell.lab1.text = [NSString stringWithFormat:@"部件编号：%@",model.partNo];
        
        cell.lab2.text = [NSString stringWithFormat:@"部件名称：%@",model.parts_model.name];
        cell.lab2.numberOfLines = 0;
        cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
        cell.lab2height.constant = size.height;
        height1 = size.height;
        
        
        cell.lab3.text = [NSString stringWithFormat:@"采购数量：%@",model.quantity];

        
        
        
        cell.lab1.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab2.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab3.textColor = RGBACOLOR(102, 102, 102, 1);
        
        return cell;
    }
    
    static NSString *identifierCell = @"cell2";
    TimeZhou_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[TimeZhou_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PaiDanModel *model = [self.dataArray1 objectAtIndex:indexPath.row];


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


- (void)lodOrderDetails{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"stockInOrderId":self.purchaseOrderId,
            };
    [session POST:KURLNSString(@"servlet/stock/stockinorderitem/item/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray removeAllObjects];
//        NSLog(@"---%@",dic);
        NSMutableArray *arr = (NSMutableArray *)dic;
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];

            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.parts];
            model.parts_model = model1;
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}
- (void)lodLogDetails{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"userId":[Manager redingwenjianming:@"userid.text"],
            @"stockInOrderId":self.purchaseOrderId,
            };
    [session POST:KURLNSString(@"servlet/stock/stockinorderlog/log/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray1 removeAllObjects];
//       NSLog(@"+++%@",dic);
        NSMutableArray *arr = (NSMutableArray *)dic;
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray1 addObject:model];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 120, 30)];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:18];
    [view addSubview:label];
    
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    line1.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    [view addSubview:line1];
    
    UILabel *line11 = [[UILabel alloc] initWithFrame:CGRectMake(0, 39, SCREEN_WIDTH, 1)];
    line11.backgroundColor = RGBACOLOR(230, 230, 230, 1);
    [view addSubview:line11];
    
    if (section == 0) {
        label.text = [NSString stringWithFormat:@"入库单详情"];
        return view;
    }
    label.text = [NSString stringWithFormat:@"操作日志"];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
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

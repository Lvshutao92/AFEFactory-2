//
//  HCCKD_details_TableViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/27.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "HCCKD_details_TableViewController.h"
#import "HCDSH_3_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface HCCKD_details_TableViewController ()
{
    CGFloat height;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation HCCKD_details_TableViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"HCDSH_3_Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *vie = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.tableFooterView = vie;
    
    [self lodOrderDetails];
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
        PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
        
        cell.lab1.text = [NSString stringWithFormat:@"部件编号：%@",model.partNo];
        
        cell.lab2.text = [NSString stringWithFormat:@"部件名称：%@",model.partName];
        cell.lab2.numberOfLines = 0;
        cell.lab2.lineBreakMode = NSLineBreakByWordWrapping;
        CGSize size = [cell.lab2 sizeThatFits:CGSizeMake(SCREEN_WIDTH-20, MAXFLOAT)];
        cell.lab2height.constant = size.height;
        height = size.height;
    
        cell.lab3.text = [NSString stringWithFormat:@"数量：%@",model.quantity];
        
        cell.lab1.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab2.textColor = RGBACOLOR(102, 102, 102, 1);
        cell.lab3.textColor = RGBACOLOR(102, 102, 102, 1);
        
        return cell;
    
    return cell;
}


- (void)lodOrderDetails{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic  = [[NSDictionary alloc]init];
    NSString *str;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":self.purchaseOrderId,
            };
    str = KURLNSString(@"servlet/material/consumables/item/list");
    
    [session POST:str parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"-------%@",dic);
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

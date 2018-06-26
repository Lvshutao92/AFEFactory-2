//
//  SYDJ_details_Controller.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "SYDJ_details_Controller.h"
#import "SYDJ_details_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface SYDJ_details_Controller ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation SYDJ_details_Controller
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView registerNib:[UINib nibWithNibName:@"SYDJ_details_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self lod];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 195;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifierCell = @"cell";
    SYDJ_details_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[SYDJ_details_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.lab1.text = [NSString stringWithFormat:@"步骤名称：%@",model.craftName];
    cell.lab2.text = [NSString stringWithFormat:@"单价：%@",model.unitPrice];
    cell.lab3.text = [NSString stringWithFormat:@"工资倍数：%@",model.overtimePay];
    cell.lab4.text = [NSString stringWithFormat:@"数量：%@",model.quantity];
    cell.lab5.text = [NSString stringWithFormat:@"小计：%.2f",[model.unitPrice floatValue]*[model.quantity floatValue]];
    cell.lab6.text = [NSString stringWithFormat:@"负责人：%@ %@",model.person_model.personCode,model.person_model.realName];
    
    
    return cell;
}
- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"productionOrderId":self.idstr,
            };
    [session POST:KURLNSString(@"servlet/productionconfig/productionorderwages/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray removeAllObjects];
        //NSLog(@"+++%@",dic);
        NSMutableArray *arr = (NSMutableArray *)dic;
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.person];
            model.person_model = model1;
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


@end

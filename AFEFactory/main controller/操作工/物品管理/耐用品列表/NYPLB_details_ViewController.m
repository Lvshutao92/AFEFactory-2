//
//  NYPLB_details_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/18.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "NYPLB_details_ViewController.h"
#import "HCDSH_7_Cell.h"
#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface NYPLB_details_ViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
}
@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation NYPLB_details_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"物品列表";
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"HCDSH_7_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    
    [self setUpReflash];
}






- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 265;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifierCell = @"cell";
    HCDSH_7_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[HCDSH_7_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lab6.hidden = YES;
    cell.lab7.hidden = YES;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    
    cell.lab1.text = [NSString stringWithFormat:@"序号：%ld",indexPath.row+1];

    cell.lab2.text = [NSString stringWithFormat:@"编号：%@",model.code];

    cell.lab3.text = [NSString stringWithFormat:@"设备序列号：%@",model.serialNumber];

    
    cell.lab4.text = [NSString stringWithFormat:@"状态：%@",model.state];
    
    cell.lab5.text = [NSString stringWithFormat:@"当前使用/预订人：%@",model.userName];
    
    
    [cell.btn setTitle:@"编辑" forState:UIControlStateNormal];
    
    LRViewBorderRadius(cell.btn, 5, 1, [UIColor blackColor]);
    [cell.btn addTarget:self action:@selector(clickbtn:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)clickbtn:(UIButton *)sender{
    HCDSH_7_Cell *cell = (HCDSH_7_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];

    [self lodedit:model.code str2:model.serialNumber str3:model.id];
    
}
- (void)lodedit:(NSString *)str1 str2:(NSString *)str2 str3:(NSString *)str3{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"修改窗口" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
//        UITextField *TextField1 = alertController.textFields.firstObject;
        
        UITextField *TextField2 = alertController.textFields.lastObject;
        TextField2.delegate = self;
        [TextField2 resignFirstResponder];
      
        
        if (TextField2.text != nil) {
            
            AFHTTPSessionManager *session = [Manager returnsession];
            __weak typeof(self) weakSelf = self;
            NSDictionary *dic = [[NSDictionary alloc]init];
            dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                    @"serialNumber":TextField2.text,
                    @"id":str3,
                    };
            [session POST:KURLNSString(@"servlet/officegoods/officegoodsitem/update") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dic = [Manager returndictiondata:responseObject];
                NSLog(@"+++%@",dic);
                if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"更新成功" message:@"温馨提示" preferredStyle:1];
                    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        [weakSelf setUpReflash];
                    }];
                    [alert addAction:cancel];
                    [weakSelf presentViewController:alert animated:YES completion:nil];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            }];
            
            
            
            
            
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"设备序列号不能为空" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
    }]];
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
         textField.userInteractionEnabled = NO;
         textField.text = str1;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        if (str2.length != 0) {
            textField.text = str2;
        }else{
            textField.placeholder = @"设备序列号";
        }
    }];
    [self presentViewController:alertController animated:true completion:nil];
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
            @"sort":@"undefined",
            @"goodsId":self.idstr,
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodsitem/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                NSLog(@"%@",dic);
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
            @"departmentPersonSessionId":[Manager redingwenjianming:@"id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"code",
            
            @"code":@"",
            @"name":@"",
            @"brand":@"",
            @"model":@"",
            @"durableTypeId":@"",
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodsitem/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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

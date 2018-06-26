//
//  XZXZ_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/23.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XZXZ_ViewController.h"
#import "PaiDanModel.h"
@interface XZXZ_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *ids;
}
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation XZXZ_ViewController
- (IBAction)clickbtn:(id)sender {
    if (ids.length != 0 && self.idstr.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"order_id":self.idstr,
                @"configId":ids,
                };
        //NSLog(@"---%@",dic);
        [session POST:KURLNSString(@"servlet/production/productionorder/myorder/config") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//            NSLog(@"+++%@",dic);
            if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"配置成功" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择小组" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


















- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择小组";
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    self.text.delegate = self;

    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(95, 115, SCREEN_WIDTH-105, 150)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    
    [self lod];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableview1.hidden = YES;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    self.text.text = model.configName;
    ids = model.id;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = model.configName;
    return cell;
}


- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":self.idstr,
            };
    //NSLog(@"---%@",dic);
    [session POST:KURLNSString(@"servlet/production/productionorder/myorder/configtext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.dataArray removeAllObjects];
        //NSLog(@"+++%@",dic);
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"productionOrderPersonList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}








- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
     self.tableview1.hidden = YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
}

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
@end

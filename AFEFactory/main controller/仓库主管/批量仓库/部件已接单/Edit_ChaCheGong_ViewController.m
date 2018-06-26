//
//  Edit_ChaCheGong_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "Edit_ChaCheGong_ViewController.h"
#import "PaiDanModel.h"
@interface Edit_ChaCheGong_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *status;
}
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray;
@property(nonatomic, strong)NSMutableArray *dataArrayid;

@end

@implementation Edit_ChaCheGong_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    self.text.delegate = self;
    if ([self.biaoshi isEqualToString:@"GGJDR"]) {
        self.l5.text = @"选择接货人";
        self.navigationItem.title = @"更改接单人";
    }else{
        self.l5.text = @"选择叉车工";
        self.navigationItem.title = @"选择叉车工";
    }
    
    self.lab1.text = self.lab1str;
    self.lab2.text = self.lab2str;
    self.lab3.text = self.lab3str;
    self.lab4.text = self.lab4str;
    self.text.text = self.textstr;
    status = self.textidstr;
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(105, 315, SCREEN_WIDTH-115, 250)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    [self lodlist];
    
}


- (void)lodlist{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"departmentId":[Manager redingwenjianming:@"departmentId.text"],
            @"id":self.idstr,
            };
    [session POST:KURLNSString(@"servlet/stock/stockinorder/set_forklift/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"receiverList"];
        for (NSDictionary *dict in arr) {
            PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableview1.hidden = YES;
     PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
     self.text.text = [NSString stringWithFormat:@"%@ %@",model.personCode,model.realName];
    status = model.id;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",model.personCode,model.realName];
    return cell;
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
- (NSMutableArray *)dataArrayid {
    if (_dataArrayid == nil) {
        self.dataArrayid = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArrayid;
}


- (IBAction)clicksave:(id)sender {
   if ([self.biaoshi isEqualToString:@"GGJDR"]){
       AFHTTPSessionManager *session = [Manager returnsession];
       __weak typeof(self) weakSelf = self;
       NSDictionary *dic = [[NSDictionary alloc]init];
       dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
               @"departmentPersonSessionId":[Manager redingwenjianming:@"id.text"],
               @"departmentPersonName":[Manager redingwenjianming:@"realName.text"],
               
               @"id":self.idstr,
               @"orderNo":self.lab1str,
               @"stockInOrderNo":self.lab2str,
               @"purchaseOrderNo":self.lab3str,
               @"purchaseOrder.supplierNo":self.lab4str,
               @"stockInPersonId":status,
               };
       [session POST:KURLNSString(@"servlet/stock/stockinorder/change_receiver") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           NSDictionary *dic = [Manager returndictiondata:responseObject];
//                   NSLog(@"%@",dic);
           if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功" message:@"温馨提示" preferredStyle:1];
               UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                   
                   NSDictionary *dict = [[NSDictionary alloc]init];
                   NSNotification *notification =[NSNotification notificationWithName:@"save_success" object:nil userInfo:dict];
                   [[NSNotificationCenter defaultCenter] postNotification:notification];
                   
                   [weakSelf.navigationController popViewControllerAnimated:YES];
               }];
               [alert addAction:cancel];
               [weakSelf presentViewController:alert animated:YES completion:nil];
           }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       }];
   }else{
       AFHTTPSessionManager *session = [Manager returnsession];
       __weak typeof(self) weakSelf = self;
       NSDictionary *dic = [[NSDictionary alloc]init];
       dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
               @"departmentPersonSessionId":[Manager redingwenjianming:@"id.text"],
               @"departmentPersonName":[Manager redingwenjianming:@"realName.text"],
               
               @"id":self.idstr,
               @"orderNo":self.lab1str,
               @"stockInOrderNo":self.lab2str,
               @"purchaseOrderNo":self.lab3str,
               @"purchaseOrder.supplierNo":self.lab4str,
               @"forkliftPersonId":status,
               };
       [session POST:KURLNSString(@"servlet/stock/stockinorder/set_forklift") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           NSDictionary *dic = [Manager returndictiondata:responseObject];
           //        NSLog(@"%@",dic);
           if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功" message:@"温馨提示" preferredStyle:1];
               UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                   
                   NSDictionary *dict = [[NSDictionary alloc]init];
                   NSNotification *notification =[NSNotification notificationWithName:@"save_success" object:nil userInfo:dict];
                   [[NSNotificationCenter defaultCenter] postNotification:notification];
                   
                   [weakSelf.navigationController popViewControllerAnimated:YES];
               }];
               [alert addAction:cancel];
               [weakSelf presentViewController:alert animated:YES completion:nil];
           }
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       }];
   }
       
    
    
}

@end

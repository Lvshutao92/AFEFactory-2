//
//  XZGL_add_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/5.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "XZGL_add_ViewController.h"
#import "PaidanModel2.h"
#import "PaidanModel1.h"
@interface XZGL_add_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSString *idstr;
}
@property(nonatomic, strong)UITableView *tableview1;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation XZGL_add_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新增";
    LRViewBorderRadius(self.btn, 5, 0, [UIColor whiteColor]);
    self.text1.delegate = self;
    self.text2.delegate = self;
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(90, 165, SCREEN_WIDTH-100, 250)];
    [self.tableview1.layer setBorderColor:[UIColor colorWithWhite:.5 alpha:.5].CGColor];
    [self.tableview1.layer setBorderWidth:1];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    self.tableview1.hidden = YES;
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview1];
    [self.view bringSubviewToFront:self.tableview1];
    
    [self lodd];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.tableview1.hidden = YES;
    PaidanModel1 *model = [self.dataArray objectAtIndex:indexPath.row];
    self.text2.text = [NSString stringWithFormat:@"%@ %@",model.stencilNo,model.modelCraftType_model.name];
    idstr = model.id;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PaidanModel1 *model = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",model.stencilNo,model.modelCraftType_model.name];
    return cell;
}


- (void)lodd{
    AFHTTPSessionManager *session = [Manager returnsession];
    NSDictionary *dic = [[NSDictionary alloc]init];
    __weak typeof (self) weakSelf = self;
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/productionconfig/productionorderperson/add/inittext") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"modelCraftBomStencilList"];
//        NSLog(@"%@",dic);
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dict in arr) {
             PaidanModel1 *model = [PaidanModel1 mj_objectWithKeyValues:dict];
            
            PaidanModel2 *model1 = [PaidanModel2 mj_objectWithKeyValues:model.modelCraftType];
            model.modelCraftType_model = model1;
            
            [weakSelf.dataArray addObject:model];
        }
        
        PaidanModel1 *model = weakSelf.dataArray.firstObject;
        weakSelf.text2.text = [NSString stringWithFormat:@"%@ %@",model.stencilNo,model.modelCraftType_model.name];
        idstr = model.id;
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}









- (IBAction)clicksave:(id)sender {
    
    
    if (self.text1.text == nil || self.text1.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"小组名称不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"personCode":[Manager redingwenjianming:@"personCode.text"],
                @"crafId":idstr,
                @"configName":self.text1.text,
                };
        [session POST:KURLNSString(@"servlet/productionconfig/productionorderperson/add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //                NSLog(@"+++%@",dic);
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"修改成功" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }
    
    
    
    
    
}






- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.tableview1.hidden = YES;
    [self.text1 resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text2]) {
        [self.text1 resignFirstResponder];
        if (self.tableview1.hidden == YES) {
            self.tableview1.hidden = NO;
        }else{
            self.tableview1.hidden = YES;
        }
        return NO;
    }
    return YES;
}
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}

@end

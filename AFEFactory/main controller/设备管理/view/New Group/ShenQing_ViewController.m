//
//  ShenQing_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/15.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "ShenQing_ViewController.h"
#import "PaiDanModel.h"
@interface ShenQing_ViewController ()<UITextViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    UIView *bgwindowview;
    
    NSString *idstring;
}
@property(strong,nonatomic)UITableView    *tableview1;
@property(nonatomic,strong)NSMutableArray *arr1;


@end

@implementation ShenQing_ViewController

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.textfield1]) {
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                self.textfield1.text = str;
            }
        };
        [self.view bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    if ([textField isEqual:self.textfield2]) {
        
        bgwindowview.hidden = NO;
        
       return NO;
    }
    return NO;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clicksave)];
    self.navigationItem.rightBarButtonItem = bar;
    self.textfield1.delegate = self;
    self.textfield2.delegate = self;
    self.textview.delegate = self;
    [self setupview];
    if ([self.navigationItem.title isEqualToString:@"维修申请"]) {
        self.lab1.text = @"维修开始时间";
        self.lab2.text = @"设备维修商";
        self.lab3.text = @"故障描述";
    }else{
        self.lab1.text = @"保养开始时间";
        self.lab2.text = @"设备维修商";
        self.lab3.text = @"保养内容";
    }
    
    [self lod];
    
}


- (void)clicksave{
    if (self.textfield1.text.length != 0 && idstring.length != 0 && self.textview.text.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        NSString *str;
        if ([self.navigationItem.title isEqualToString:@"维修申请"]){
            str = @"servlet/equipment/equipmentmaintenance/add";
            dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                    @"equipmentId":self.idstr,
                    @"startTime":self.textfield1.text,
                    @"maintenancePeopleOut":idstring,
                    @"content":self.textview.text,
                    @"originator":[Manager redingwenjianming:@"id.text"],
                    };
        }else{
            str = @"servlet/equipment/equipmentmaintain/add";
            dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                    @"equipmentId":self.idstr,
                    @"startTime":self.textfield1.text,
                    @"maintainPeopleOut":idstring,
                    @"content":self.textview.text,
                    @"originator":[Manager redingwenjianming:@"id.text"],
                    };
        }
        [session POST:KURLNSString(str) parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功！" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:[dic objectForKey:@"message"] message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"所有信息不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}





- (void)setupview{
    bgwindowview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgwindowview.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    bgwindowview.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapbgwindowview:)];
    tap.delegate = self;
    [bgwindowview addGestureRecognizer:tap];
    [self.view addSubview:bgwindowview];
    [self.view bringSubviewToFront:bgwindowview];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-400.5, SCREEN_WIDTH, 50)];
    lab.text = @"设备维修商";
    lab.backgroundColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [bgwindowview addSubview:lab];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350)];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [bgwindowview addSubview:self.tableview1];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview1.tableFooterView = v;
}
- (void)clicktapbgwindowview:(UITapGestureRecognizer *)tap{
    bgwindowview.hidden = YES;
}


#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    bgwindowview.hidden = YES;
    PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
    
    self.textfield2.text = model.supplierName;
    idstring = model.id;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr1.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *identifierCell = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.supplierName;
        return cell;
}






- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/equipment/equipment") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        [weakSelf.arr1 removeAllObjects];
        if (![[dic objectForKey:@"equipmentSupplierList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"equipmentSupplierList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr1 addObject:model];
            }
        }
        [weakSelf.tableview1 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}










- (NSMutableArray *)arr1{
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return YES;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UILabel"]) {
        return YES;
    }
    return NO;
}

@end

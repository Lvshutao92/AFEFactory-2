//
//  ShenHe__ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/22.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "ShenHe__ViewController.h"
#import "PaiDanModel.h"
@interface ShenHe__ViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *scrollview;
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    
    UITextView *textview;
    
    
    UIView *window;
    UILabel *toplab;
    NSString *idstring1;
    NSString *idstring2;
    NSString *idstring3;
    NSString *idstring4;
}
@property(strong,nonatomic)UITableView    *tableview;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *arr3;

@end

@implementation ShenHe__ViewController



- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentmaintenance") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //NSLog(@"%@",dic);
        [weakSelf.arr1 removeAllObjects];
        if (![[dic objectForKey:@"equipmentList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"equipmentList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr1 addObject:model];
            }
        }
        
        [weakSelf.arr2 removeAllObjects];
        if (![[dic objectForKey:@"departmentPersonList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"departmentPersonList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr2 addObject:model];
            }
        }
        
//        [weakSelf.arr3 removeAllObjects];
//        if (![[dic objectForKey:@"equipmentSupplierList"] isEqual:[NSNull null]]) {
//            NSMutableArray *arr = [dic objectForKey:@"equipmentSupplierList"];
//            for (NSDictionary *dic in arr) {
//                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
//                [weakSelf.arr3 addObject:model];
//            }
//        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.dataArray isEqualToArray:self.arr1]) {
        PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
        text2.text = [NSString stringWithFormat:@"%@-%@",model.equipmentNo,model.equipmentName];
        idstring1 = model.id;
    }
//    if ([self.dataArray isEqualToArray:self.arr2]) {
//        PaiDanModel *model = [self.arr2 objectAtIndex:indexPath.row];
//        text4.text = model.realName;
//        idstring2 = model.id;
//    }
    if ([self.dataArray isEqualToArray:self.arr3]) {
//        PaiDanModel *model = [self.arr3 objectAtIndex:indexPath.row];
//        text5.text = model.supplierName;
//        idstring3 = model.id;
        text6.text = [self.arr3 objectAtIndex:indexPath.row];
        if ([text6.text isEqualToString:@"审核通过"]) {
            idstring4 = @"B";
        }else if ([text6.text isEqualToString:@"审核不通过"]) {
            idstring4 = @"C";
        }
    }
    window.hidden = YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataArray isEqualToArray:self.arr1]) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",model.equipmentNo,model.equipmentName];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }
//    if ([self.dataArray isEqualToArray:self.arr2]) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        PaiDanModel *model = [self.arr2 objectAtIndex:indexPath.row];
//        cell.textLabel.text = model.realName;
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        return cell;
//    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    PaiDanModel *model = [self.arr3 objectAtIndex:indexPath.row];
//    cell.textLabel.text = model.supplierName;
    cell.textLabel.text = [self.arr3 objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    
    return cell;
    
}
- (void)clicksave{
    if (textview.text.length != 0 && idstring1.length != 0  &&
        idstring4.length != 0 && text3.text.length != 0 &&
        self.idstr.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"id":self.idstr,
                
                @"equipmentId":idstring1,
                @"startTime":text3.text,
                @"content":textview.text,
                @"status":idstring4,
                };
        NSString *str;
        if ([self.navigationItem.title isEqualToString:@"维修审核"]) {
            str = @"servlet/equipment/equipmentmaintenance/check";
        }else{
            str = @"servlet/equipment/equipmentmaintain/check";
        }
        
        [session POST:KURLNSString(str) parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//                       NSLog(@"----------%@",dic);
            if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功" message:@"温馨提示" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    NSDictionary *dict = [[NSDictionary alloc]init];
                    NSNotification *notification =[NSNotification notificationWithName:@"weixiu" object:nil userInfo:dict];
                    [[NSNotificationCenter defaultCenter] postNotification:notification];
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
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请输入完整信息，再重新保存" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self lod];
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clicksave)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 10, SCREEN_WIDTH-10, SCREEN_HEIGHT-10)];
    scrollview.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [self.view addSubview:scrollview];
    
    self.arr3 = [@[@"审核通过",@"审核不通过"]mutableCopy];
    
    if ([self.navigationItem.title isEqualToString:@"维修审核"]) {
        NSArray *arr = @[@"维修申请编号",@"设备编号",@"维修开始时间",@"发起人",@"设备维修商",@"维修内容"];
        for (int i = 0; i<arr.count; i++) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+30*i+20*i, 135, 30)];
            lab.text = arr[i];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont systemFontOfSize:16];
            [scrollview addSubview:lab];
        }
    }else{
        NSArray *arr = @[@"保养申请编号",@"设备编号",@"保养开始时间",@"发起人",@"设备维修商",@"保养内容"];
        for (int i = 0; i<arr.count; i++) {
            UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+30*i+20*i, 135, 30)];
            lab.text = arr[i];
            lab.textAlignment = NSTextAlignmentCenter;
            lab.font = [UIFont systemFontOfSize:16];
            [scrollview addSubview:lab];
        }
    }
    
    
    for (int j = 0; j<5; j++) {
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(150, 5+40*j+10*j, SCREEN_WIDTH-165, 40)];
        textfield.delegate = self;
        switch (j) {
            case 0:
                text1 = textfield;
                text1.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                text1.text = _str1;
                break;
            case 1:
                text2 = textfield;
                text2.text = _str2;
                break;
            case 2:
                text3 = textfield;
                text3.text = _str3;
                break;
            case 3:
                text4 = textfield;
                text4.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                text4.text = _str4;
                break;
            case 4:
                text5 = textfield;
                text5.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
                text5.text = _str5;
                break;
            default:
                break;
        }
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        [scrollview addSubview:textfield];
    }
    textview = [[UITextView alloc]initWithFrame:CGRectMake(150, 265,SCREEN_WIDTH-165, 200)];
    textview.delegate = self;
    textview.font = [UIFont systemFontOfSize:17];
    textview.text = self.str6;
    [scrollview addSubview:textview];
    
    text6 = [[UITextField alloc]initWithFrame:CGRectMake(150, 490, SCREEN_WIDTH-165, 40)];
    text6.delegate = self;
    text6.placeholder = @"请选择";
    text6.borderStyle = UITextBorderStyleRoundedRect;
    [scrollview addSubview:text6];
    
    
    UILabel *labs = [[UILabel alloc]initWithFrame:CGRectMake(10, 490, 135, 30)];
    labs.text = @"审核状态";
    labs.textAlignment = NSTextAlignmentCenter;
    labs.font = [UIFont systemFontOfSize:16];
    [scrollview addSubview:labs];
    
    
    
    
    
    
    idstring1 = self.str2id;
    idstring2 = self.str4id;
    idstring3 = self.str5id;
    
    scrollview.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
    
    
    window = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    window.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapbgwindowview:)];
    tap.delegate = self;
    [window addGestureRecognizer:tap];
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
    toplab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-400.5, SCREEN_WIDTH, 50)];
    toplab.backgroundColor = [UIColor whiteColor];
    toplab.textAlignment = NSTextAlignmentCenter;
    [window addSubview:toplab];
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350)];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [window addSubview:self.tableview];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview.tableFooterView = v;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text2]) {
        toplab.text = @"设备编号";
        window.hidden = NO;
        self.dataArray = self.arr1;
        [self.tableview reloadData];
        return NO;
    }
    if ([textField isEqual:text3]) {
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text3.text = str;
            }
        };
        [self.view bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    if ([textField isEqual:text4]) {
        //        toplab.text = @"发起人";
        //        window.hidden = NO;
        //        self.dataArray = self.arr2;
        //        [self.tableview reloadData];
        return NO;
    }
    if ([textField isEqual:text5]) {
//        toplab.text = @"设备维修商";
//        window.hidden = NO;
//        self.dataArray = self.arr3;
//        [self.tableview reloadData];
        return NO;
    }
    if ([textField isEqual:text6]) {
                toplab.text = @"审核状态";
                window.hidden = NO;
                self.dataArray = self.arr3;
                [self.tableview reloadData];
        return NO;
    }
    return NO;
}
- (void)clicktapbgwindowview:(UITapGestureRecognizer *)gesture{
    window.hidden = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return YES;
    }
    return NO;
}
- (void)cancel{
    window.hidden = YES;
}



- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        self.dataArray = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray;
}
- (NSMutableArray *)arr1{
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)arr2{
    if (_arr2 == nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (NSMutableArray *)arr3{
    if (_arr3 == nil) {
        self.arr3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr3;
}

@end

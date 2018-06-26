//
//  SuoyouBaoyang_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/19.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "SuoyouBaoyang_ViewController.h"
#import "Shenqing_Cell.h"
#import "PaiDanModel.h"
#import "ShenHe__ViewController.h"
#import "FeiYong_ViewController.h"
#import "QueRen__ViewController.h"
#import "YiShouFaPiao__ViewController.h"

#import "BaoYangMingXi_ViewController.h"
@interface SuoyouBaoyang_ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    CGFloat height1;
    CGFloat height2;
    
    UIView *window;
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    UITextField *text8;
    NSString *idstring1;
    NSString *idstring2;
    NSString *idstring3;
    
    NSString *idstring4;
    NSString *stu;
    
    
    UIView *bgwindowview;
    UILabel *bglab;
}
@property(nonatomic,strong)UIScrollView *bgview;
@property(nonatomic,strong)UILabel *toplab;


@property(nonatomic,strong)NSMutableArray *dataArray;
@property(strong,nonatomic)UITableView    *tableview;

@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(strong,nonatomic)UITableView    *tableview1;

@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,strong)NSMutableArray *arr3;
@property(nonatomic,strong)NSMutableArray *arr4;

@end

@implementation SuoyouBaoyang_ViewController

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
- (NSMutableArray *)arr1 {
    if (_arr1 == nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)arr2 {
    if (_arr2 == nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
}
- (NSMutableArray *)arr3 {
    if (_arr3 == nil) {
        self.arr3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr3;
}
- (NSMutableArray *)arr4 {
    if (_arr4 == nil) {
        self.arr4 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr4;
}

- (void)setupButton {
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    window = [[UIView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    //window.windowLevel = UIWindowLevelNormal;
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    self.bgview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    self.bgview.backgroundColor = [UIColor whiteColor];
    self.bgview.userInteractionEnabled = YES;
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 40)];
    lab1.text = @"保养申请编号";
    [self.bgview addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入保养申请编号";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"设备编号";
    [self.bgview addSubview:lab2];
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"请输入设备编号";
    [self.bgview addSubview: text2];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    lab3.text = @"保养开始时间";
    [self.bgview addSubview:lab3];
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text2.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    text3.placeholder = @"请选择";
    [self.bgview addSubview: text3];
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 290, SCREEN_WIDTH-20, 40)];
    lab4.text = @"设备维修商";
    [self.bgview addSubview:lab4];
    text4 = [[UITextField alloc] initWithFrame:CGRectMake(10, 335, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    text4.placeholder = @"请选择";
    text4.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [self.bgview addSubview: text4];
    
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 385, SCREEN_WIDTH-20, 40)];
    lab5.text = @"保养结束时间";
    [self.bgview addSubview:lab5];
    text5 = [[UITextField alloc] initWithFrame:CGRectMake(10, 430, SCREEN_WIDTH-20, 40)];
    text5.delegate = self;
    text5.borderStyle = UITextBorderStyleRoundedRect;
    text5.placeholder = @"请选择";
    
    [self.bgview addSubview: text5];
    
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10,480, SCREEN_WIDTH-20, 40)];
    lab6.text = @"保养状态";
    [self.bgview addSubview:lab6];
    text6 = [[UITextField alloc] initWithFrame:CGRectMake(10, 525, SCREEN_WIDTH-20, 40)];
    text6.delegate = self;
    text6.borderStyle = UITextBorderStyleRoundedRect;
    text6.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    text6.placeholder = @"请选择";
    [self.bgview addSubview: text6];
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10,575, SCREEN_WIDTH-20, 40)];
    lab7.text = @"发起人";
    [self.bgview addSubview:lab7];
    text7 = [[UITextField alloc] initWithFrame:CGRectMake(10, 620, SCREEN_WIDTH-20, 40)];
    text7.delegate = self;
    text7.borderStyle = UITextBorderStyleRoundedRect;
    text7.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    text7.placeholder = @"请选择";
    [self.bgview addSubview: text7];
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10,670, SCREEN_WIDTH-20, 40)];
    lab8.text = @"确认人";
    [self.bgview addSubview:lab8];
    text8 = [[UITextField alloc] initWithFrame:CGRectMake(10, 715, SCREEN_WIDTH-20, 40)];
    text8.delegate = self;
    text8.borderStyle = UITextBorderStyleRoundedRect;
    text8.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    text8.placeholder = @"请输入确认人";
    [self.bgview addSubview: text8];
    
    self.bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-199);
    self.bgview.contentSize = CGSizeMake(0, SCREEN_HEIGHT*1.2);
    [window addSubview:self.bgview];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT-200, SCREEN_WIDTH/2, 50);
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0,SCREEN_HEIGHT-199, SCREEN_WIDTH/2, 49);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"取消" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    
    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-200,SCREEN_WIDTH/2, 1)];
    lin.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [window addSubview:lin];
    
    [self.view addSubview:window];
    [self.view bringSubviewToFront:window];
    
    [self setUpReflash];
}
- (void)lod{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentmaintenance") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"%@",dic);
        [weakSelf.arr1 removeAllObjects];
        if (![[dic objectForKey:@"equipmentList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"equipmentList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr1 addObject:model];
            }
        }
        
        [weakSelf.arr2 removeAllObjects];
        if (![[dic objectForKey:@"equipmentSupplierList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"equipmentSupplierList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr2 addObject:model];
            }
        }
        
        [weakSelf.arr4 removeAllObjects];
        if (![[dic objectForKey:@"departmentPersonList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"departmentPersonList"];
            for (NSDictionary *dic in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dic];
                [weakSelf.arr4 addObject:model];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)cancle{
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    text5.text = @"";
    text6.text = @"";
    text7.text = @"";
    text8.text = @"";
    idstring4 = @"";
    idstring1 = @"";
    idstring2 = @"";
    idstring3 = @"";
    window.hidden = YES;
}

- (void)sure{
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    if (text5.text.length == 0) {
        text5.text = @"";
    }
    if (text6.text.length == 0) {
        text6.text = @"";
    }
    if (text7.text.length == 0) {
        text7.text = @"";
    }
    if (text8.text.length == 0) {
        text8.text = @"";
    }
    [self setUpReflash];
    window.hidden = YES;
}
- (void)clicksearch{
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    text5.text = @"";
    text6.text = @"";
    text7.text = @"";
    idstring4 = @"";
    idstring1 = @"";
    idstring2 = @"";
    idstring3 = @"";
    text8.text = @"";
    window.hidden = NO;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text3]) {
        [text1 resignFirstResponder];
        [text8 resignFirstResponder];
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
    if ([textField isEqual:text5]) {
        [text1 resignFirstResponder];
        [text8 resignFirstResponder];
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text5.text = str;
            }
        };
        [self.view bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    if ([textField isEqual:text2]) {
        [text1 resignFirstResponder];
        [text8 resignFirstResponder];
        bglab.text = @"设备编号";
        bgwindowview.hidden = NO;
        self.dataArray1 = self.arr1;
        [self.tableview1 reloadData];
        return NO;
    }
    if ([textField isEqual:text4]) {
        [text1 resignFirstResponder];
        [text8 resignFirstResponder];
        bglab.text = @"设备维修商";
        bgwindowview.hidden = NO;
        self.dataArray1 = self.arr2;
        [self.tableview1 reloadData];
        return NO;
    }
    if ([textField isEqual:text6]) {
        [text1 resignFirstResponder];
        [text8 resignFirstResponder];
        bglab.text = @"保养状态";
        bgwindowview.hidden = NO;
        self.dataArray1 = self.arr3;
        [self.tableview1 reloadData];
        return NO;
    }
    if ([textField isEqual:text7]) {
        [text1 resignFirstResponder];
        [text8 resignFirstResponder];
        bglab.text = @"发起人";
        bgwindowview.hidden = NO;
        self.dataArray1 = self.arr4;
        [self.tableview1 reloadData];
        return NO;
    }
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    stu = @"";
    [self lod];
    idstring1 = @"";
    idstring2 = @"";
    idstring3 = @"";
    idstring4 = @"";
    self.arr3 = [@[@"新建",@"已审核",@"未通过",@"保养成功",@"保养失败",@"已生成付款单"]mutableCopy];
    UIBarButtonItem *bar1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bar1;
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"Shenqing_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview.tableHeaderView = v;
    
    [self setupButton];
    [self setupview_tableview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(save:) name:@"weixiu" object:nil];
}

- (void)save:(NSNotification *)text {
    [self setUpReflash];
}


- (void)setupview_tableview{
    bgwindowview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgwindowview.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    bgwindowview.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapbgwindowview:)];
    tap.delegate = self;
    [bgwindowview addGestureRecognizer:tap];
    [self.view addSubview:bgwindowview];
    [self.view bringSubviewToFront:bgwindowview];
    
    bglab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-400.5, SCREEN_WIDTH, 50)];
    bglab.backgroundColor = [UIColor whiteColor];
    bglab.textAlignment = NSTextAlignmentCenter;
    [bgwindowview addSubview:bglab];
    
    self.tableview1 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350)];
    [self.tableview1 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cells"];
    self.tableview1.delegate = self;
    self.tableview1.dataSource = self;
    [bgwindowview addSubview:self.tableview1];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview1.tableFooterView = v;
}






#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        if ([self.dataArray1 isEqualToArray:self.arr1]) {
            PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
            text2.text = [NSString stringWithFormat:@"%@-%@",model.equipmentNo,model.equipmentName];
            idstring1 = model.id;
        }
        if ([self.dataArray1 isEqualToArray:self.arr2]) {
            PaiDanModel *model = [self.arr2 objectAtIndex:indexPath.row];
            text4.text = model.supplierName;
            idstring2 = model.id;
        }
        if ([self.dataArray1 isEqualToArray:self.arr3]) {
            text6.text = self.arr3[indexPath.row];
            
            if ([text6.text isEqualToString:@"新建"]) {
                idstring3 = @"A";
            }else if ([text6.text isEqualToString:@"已审核"]) {
                idstring3 = @"B";
            }else if ([text6.text isEqualToString:@"未通过"]) {
                idstring3 = @"C";
            }else if ([text6.text isEqualToString:@"保养成功"]) {
                idstring3 = @"D";
            }else if ([text6.text isEqualToString:@"保养失败"]) {
                idstring3 = @"E";
            }else if ([text6.text isEqualToString:@"已生成付款单"]) {
                idstring3 = @"F";
            }
        }
        if ([self.dataArray1 isEqualToArray:self.arr4]) {
            PaiDanModel *model = [self.arr4 objectAtIndex:indexPath.row];
            text7.text = model.realName;
            idstring4 = model.id;
        }
        bgwindowview.hidden = YES;
    }
    if ([tableView isEqual:self.tableview]) {
        PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
        BaoYangMingXi_ViewController *mingxi = [[BaoYangMingXi_ViewController alloc]init];
        mingxi.idstr = model.id;
        [self.navigationController pushViewController:mingxi animated:YES];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray1.count;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 60;
    }
    return 620;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableview1]) {
        if ([self.dataArray1 isEqualToArray:self.arr1]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
            cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",model.equipmentNo,model.equipmentName];
            return cell;
        }
        if ([self.dataArray1 isEqualToArray:self.arr2]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            PaiDanModel *model = [self.arr2 objectAtIndex:indexPath.row];
            cell.textLabel.text = model.supplierName;
            return cell;
        }
        if ([self.dataArray1 isEqualToArray:self.arr3]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = self.arr3[indexPath.row];
            return cell;
        }
        if ([self.dataArray1 isEqualToArray:self.arr4]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            PaiDanModel *model = [self.arr4 objectAtIndex:indexPath.row];
            cell.textLabel.text = model.realName;
            return cell;
        }
    }
    
    
    static NSString *identifierCell = @"cell";
    Shenqing_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[Shenqing_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    cell.a0.text = @"保养申请编号";
    cell.a1.text = @"保养开始时间";
    cell.a2.text = @"保养内容";
    cell.a3.text = @"保养结束时间";
    cell.a4.text = @"保养情况描述";
    cell.a5.text = @"保养状态";
    
    cell.lab1.text = model.maintainNo;
    cell.lab2.text = model.equipment_model.equipmentNo;
    cell.lab3.text = model.equipment_model.equipmentName;
    cell.lab4.text = model.startTime;
    cell.lab5.text = model.departmentPerson_model.realName;
    cell.lab6.text = model.equipmentSupplier_model.supplierName;
    cell.lab7.text = model.content;
    
    if (model.endTime == nil) {
        cell.lab8.text = @"-";
    }else{
        cell.lab8.text = model.endTime;
    }
    
    if (model.checkName == nil) {
        cell.lab9.text = @"-";
    }else{
        cell.lab9.text = model.checkName;
    }
    
    if (model.total == nil) {
        cell.lab10.text = @"-";
    }else{
        cell.lab10.text = model.total;
    }
    
    if (model.mainContent == nil) {
        cell.lab11.text = @"-";
    }else{
        cell.lab11.text = model.mainContent;
    }
    
    if (model.field1 == nil) {
        cell.lab12.text = @"-";
    }else{
        cell.lab12.text = model.field1;
    }
    
    if (model.field3 == nil) {
        cell.lab13.text = @"-";
    }else{
        cell.lab13.text = model.field3;
    }
    
    if (model.field2 == nil) {
        cell.lab14.text = @"-";
    }else{
        cell.lab14.text = model.field2;
    }
    
    
    if ([model.status isEqualToString:@"A"]) {
        cell.lab15.text = @"新建";
        cell.lab15.textColor = [UIColor greenColor];
    }else if ([model.status isEqualToString:@"B"]) {
        cell.lab15.text = @"已审核";
        cell.lab15.textColor = [UIColor blackColor];
    }else if ([model.status isEqualToString:@"C"]) {
        cell.lab15.text = @"未通过";
        cell.lab15.textColor = RGBACOLOR(37, 167, 159, 1);
    }else if ([model.status isEqualToString:@"D"]) {
        cell.lab15.text = @"保养成功";
        cell.lab15.textColor = [UIColor blueColor];
    }else if ([model.status isEqualToString:@"E"]) {
        cell.lab15.text = @"保养失败";
        cell.lab15.textColor = [UIColor redColor];
    }else if ([model.status isEqualToString:@"F"]) {
        cell.lab15.text = @"已生成付款单";
        cell.lab15.textColor = RGBACOLOR(0, 229, 238, 1);
    }
    
    
    if ([model.paymentStatus isEqualToString:@"pendingCheck"]) {
        cell.lab16.text = @">待审核";
        cell.lab16.textColor = [UIColor redColor];
    }else if ([model.paymentStatus isEqualToString:@"created"]) {
        cell.lab16.text = @"已创建";
    }else if ([model.paymentStatus isEqualToString:@"delivery"]) {
        cell.lab16.text = @"待寄送";
        cell.lab16.textColor = [UIColor grayColor];
    }else if ([model.paymentStatus isEqualToString:@"pendingConfirm"]) {
        cell.lab16.text = @"待确认";
        cell.lab16.textColor = [UIColor redColor];
    }else if ([model.paymentStatus isEqualToString:@"returned"]) {
        cell.lab16.text = @"已退回";
        cell.lab16.textColor = [UIColor greenColor];
    }else if ([model.paymentStatus isEqualToString:@"pendingPayment"]) {
        cell.lab16.text = @"待付款";
        cell.lab16.textColor = [UIColor redColor];
    }else if ([model.paymentStatus isEqualToString:@"payed"]) {
        cell.lab16.text = @"已付款";
        cell.lab16.textColor = RGBACOLOR(37, 167, 159, 1);
    }else if ([model.paymentStatus isEqualToString:@"canceled"]) {
        cell.lab16.text = @"审核不通过";
        cell.lab16.textColor = [UIColor greenColor];
    }else if ([model.paymentStatus isEqualToString:@"pendingPaymentFirst"]) {
        cell.lab16.text = @"待付定金";
        cell.lab16.textColor = [UIColor redColor];
    }else if ([model.paymentStatus isEqualToString:@"pendingPaymentFinal"]) {
        cell.lab16.text = @"待付尾款";
        cell.lab16.textColor = [UIColor redColor];
    }else{
        cell.lab16.text = @"-";
    }
    
    cell.btn3.hidden = NO;
    cell.btn4.hidden = NO;
    LRViewBorderRadius(cell.btn1, 15, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn2, 15, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn3, 15, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn4, 15, 1, [UIColor blackColor]);
    [cell.btn1 setTitle:@"已收发票" forState:UIControlStateNormal];
    [cell.btn2 setTitle:@"保养确认" forState:UIControlStateNormal];
    [cell.btn3 setTitle:@"保养费用" forState:UIControlStateNormal];
    [cell.btn4 setTitle:@"审核" forState:UIControlStateNormal];
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn2 addTarget:self action:@selector(clickbtn2:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn3 addTarget:self action:@selector(clickbtn3:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn4 addTarget:self action:@selector(clickbtn4:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)clickbtn1:(UIButton *)sender{
    Shenqing_Cell *cell = (Shenqing_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    YiShouFaPiao__ViewController *edit = [[YiShouFaPiao__ViewController alloc]init];
    edit.biaoji = @"baoyang";
    edit.idstr = model.id;
    edit.str1 = model.maintainNo;
    [self.navigationController pushViewController:edit animated:YES];
}
- (void)clickbtn2:(UIButton *)sender{
    Shenqing_Cell *cell = (Shenqing_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    QueRen__ViewController *edit = [[QueRen__ViewController alloc]init];
    edit.navigationItem.title = @"确认保养";
    edit.idstr = model.id;
    
    edit.str1 = model.maintainNo;
    edit.str2 = model.equipment_model.equipmentNo;
    edit.str3 = model.equipmentSupplier_model.supplierName;
    edit.equipmentId = model.equipment_model.id;
    [self.navigationController pushViewController:edit animated:YES];
}
- (void)clickbtn3:(UIButton *)sender{
    Shenqing_Cell *cell = (Shenqing_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];

    FeiYong_ViewController *edit = [[FeiYong_ViewController alloc]init];
    edit.navigationItem.title = @"保养费用";
    edit.idstr = model.id;
    edit.str1 = model.maintainNo;
    [self.navigationController pushViewController:edit animated:YES];

}
- (void)clickbtn4:(UIButton *)sender{
    Shenqing_Cell *cell = (Shenqing_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];

    ShenHe__ViewController *edit = [[ShenHe__ViewController alloc]init];
    edit.navigationItem.title = @"保养审核";
    edit.idstr = model.id;
    
    edit.str1 = model.maintainNo;
    
    edit.str2 = [NSString stringWithFormat:@"%@-%@",model.equipment_model.equipmentNo,model.equipment_model.equipmentName];
    edit.str2id =  model.equipment_model.id;
    
    edit.str3 = model.startTime;
    
    edit.str4 = model.departmentPerson_model.realName;
    edit.str4id = model.departmentPerson_model.id;
    
    edit.str5 = model.equipmentSupplier_model.supplierName;
    edit.str5id = model.equipmentSupplier_model.id;
    
    edit.str6 = model.content;
    
    [self.navigationController pushViewController:edit animated:YES];

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
            
            @"maintainNo":text1.text,
            @"equipmentId":idstring1,
            @"startTime":text3.text,
            @"maintenancePeopleOut":idstring2,
            @"endTime":text5.text,
            @"status":idstring3,
            @"originator":idstring4,
            @"checkName":text8.text,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentmaintain/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //                NSLog(@"guowai----%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.departmentPerson];
                model.departmentPerson_model = model1;
                
                PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentSupplier];
                model.equipmentSupplier_model = model2;
                
                PaidanModel1 *model3 = [PaidanModel1 mj_objectWithKeyValues:model.equipment];
                model.equipment_model = model3;
                
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
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"maintainNo":text1.text,
            @"equipmentId":idstring1,
            @"startTime":text3.text,
            @"maintenancePeopleOut":idstring2,
            @"endTime":text5.text,
            @"status":idstring3,
            @"originator":idstring4,
            @"checkName":text8.text,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipmentmaintain/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.departmentPerson];
                model.departmentPerson_model = model1;
                
                PaidanModel1 *model2 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentSupplier];
                model.equipmentSupplier_model = model2;
                
                PaidanModel1 *model3 = [PaidanModel1 mj_objectWithKeyValues:model.equipment];
                model.equipment_model = model3;
                
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"]) {
        return YES;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UILabel"]) {
        return YES;
    }
    return NO;
}
- (void)clicktapbgwindowview:(UITapGestureRecognizer *)tap{
    bgwindowview.hidden = YES;
}



@end

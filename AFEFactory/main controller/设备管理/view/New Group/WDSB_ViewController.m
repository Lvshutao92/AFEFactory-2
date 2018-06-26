//
//  WDSB_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/12.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "WDSB_ViewController.h"
#import "WDSB_Cell.h"
#import "PaiDanModel.h"
#import "ShenQing_ViewController.h"

#import "Details_01_ViewController.h"
#import "Details_1_1_ViewController.h"
#import "Details_1_2_ViewController.h"

@interface WDSB_ViewController ()<UISearchBarDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    NSString *idstr;
    
    NSString *idstring;
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    UIView *window;
    NSString *statu;
    NSString *statu1;
    NSString *statu2;
    UILabel *titleLabel;
    
    
    UIView *headerview;
    UILabel *line1;
    UIImageView *imgjiantou;
    UILabel *la3;
    UILabel *la1;
    UILabel *la2;
    UILabel *la4;
    UILabel *la5;
    
    
    UIView *bgwindowview;
    UIView *bgwindowview1;
}
@property(nonatomic,strong)UIScrollView *bgview;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(strong,nonatomic)UITableView    *tableview;

@property(strong,nonatomic)UITableView    *tableview1;
@property(strong,nonatomic)UITableView    *tableview2;
@property(nonatomic,strong)NSMutableArray *arr;

@property(nonatomic,strong)NSMutableArray *arr1;
@property(nonatomic,strong)NSMutableArray *arr2;
@property(nonatomic,assign)BOOL isHidden;
@end

@implementation WDSB_ViewController


- (void)clicksearch{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text4 resignFirstResponder];
    text2.text = @"";
    text1.text = @"";
    text3.text = @"";
    text4.text = @"";
    text5.text = @"";
    text6.text = @"";
    
    statu = @"";
    statu1 = @"";
    statu2 = @"";
    
    if (window.hidden == YES) {
        window.hidden = NO;
    }else{
        window.hidden = YES;
    }
}




- (void)sure{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text4 resignFirstResponder];
    
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
        statu1= @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    if (text5.text.length == 0) {
        text5.text = @"";
        statu2= @"";
    }
    if (text6.text.length == 0) {
        text6.text = @"";
    }
    if (statu.length == 0) {
        statu = @"";
    }
    [self setUpReflash];
    window.hidden = YES;
}
- (void)handleClick:(UIButton *)btn{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text4 resignFirstResponder];
    
    if (text1.text.length == 0) {
        text1.text = @"";
    }
    if (text2.text.length == 0) {
        text2.text = @"";
    }
    if (text3.text.length == 0) {
        text3.text = @"";
        statu1= @"";
    }
    if (text4.text.length == 0) {
        text4.text = @"";
    }
    if (text5.text.length == 0) {
        text5.text = @"";
        statu2= @"";
    }
    if (text6.text.length == 0) {
        text6.text = @"";
    }
    if (statu.length == 0) {
        statu = @"";
    }
    
    if ([btn.titleLabel.text isEqualToString:@"正常"]) {
        statu = @"A";
    }else if ([btn.titleLabel.text isEqualToString:@"停用"]) {
        statu = @"B";
    }
    [self setUpReflash];
    window.hidden = YES;
}



- (void)cancle{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text4 resignFirstResponder];
     text2.text = @"";
     text1.text = @"";
     text3.text = @"";
     text4.text = @"";
     text5.text = @"";
     text6.text = @"";
    
    statu = @"";
    statu1 = @"";
    statu2 = @"";
    window.hidden = YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text3]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        [text4 resignFirstResponder];
        bgwindowview.hidden = NO;
        return NO;
    }
    if ([textField isEqual:text5]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        [text4 resignFirstResponder];
        bgwindowview1.hidden = NO;
        return NO;
    }
    if ([textField isEqual:text6]) {
        [text1 resignFirstResponder];
        [text2 resignFirstResponder];
        [text4 resignFirstResponder];
        KSDatePicker *picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                text6.text = str;
            }
        };
        [window bringSubviewToFront:picker];
        [picker show];
        return NO;
    }
    return YES;
}


- (void)setupsearchview{
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
    }else{
        height = 64;
    }
    
    window = [[UIView alloc] initWithFrame:CGRectMake(0, height, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.backgroundColor = [UIColor colorWithWhite:.85 alpha:.5];
    //    window.windowLevel = UIWindowLevelNormal;
    window.alpha = 1.f;
    window.hidden = YES;
    
    
    self.bgview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    self.bgview.backgroundColor = [UIColor whiteColor];
    self.bgview.userInteractionEnabled = YES;
    
    UILabel *lab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 40)];
    lab1.text = @"设备编号";
    [self.bgview addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.placeholder = @"请输入设备编号";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text1];
    
    
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"设备名称";
    [self.bgview addSubview:lab2];
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.placeholder = @"请输入设备名称";
    [self.bgview addSubview: text2];
    
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, SCREEN_WIDTH-20, 40)];
    lab3.text = @"设备类别";
    [self.bgview addSubview:lab3];
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(10, 240, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.borderStyle = UITextBorderStyleRoundedRect;
    text3.placeholder = @"请选择";
    [self.bgview addSubview: text3];
    
    
    UILabel *toplab = [[UILabel alloc]initWithFrame:CGRectMake(10, 290, SCREEN_WIDTH-20, 40)];
    toplab.text = @"状态";
    [self.bgview addSubview:toplab];
    
    NSArray *arr = @[@"正常",@"停用"];
    CGFloat w = 0;//保存前一个button的宽以及前一个button距离屏幕边缘的距离
    CGFloat h = 335;//用来控制button距离父视图的高
    for (int i = 0; i < arr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 100 + i;
        button.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5.0;
        
        [button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //根据计算文字的大小
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22.f]};
        CGSize size = CGSizeMake(MAXFLOAT, 25);
        CGFloat length = [arr[i] boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width;
        //为button赋值
        [button setTitle:arr[i] forState:UIControlStateNormal];
        //设置button的frame
        button.frame = CGRectMake(10 + w, h, length + 20 , 40);
        //当button的位置超出屏幕边缘时换行 只是button所在父视图的宽度
        if(10 + w + length + 20 > self.view.frame.size.width){
            w = 0; //换行时将w置为0
            h = h + button.frame.size.height + 10;//距离父视图也变化
            button.frame = CGRectMake(10 + w, h, length + 20, 40);//重设button的frame
        }
        w = button.frame.size.width + button.frame.origin.x;
        [self.bgview addSubview:button];
        
    }
    
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, h+50, SCREEN_WIDTH-20, 40)];
    lab4.text = @"设备使用人";
    [self.bgview addSubview:lab4];
    text4 = [[UITextField alloc] initWithFrame:CGRectMake(10, h+95, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.borderStyle = UITextBorderStyleRoundedRect;
    text4.placeholder = @"请输入设备使用人";
    [self.bgview addSubview: text4];
    
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, h+145, SCREEN_WIDTH-20, 40)];
    lab5.text = @"设备维修商";
    [self.bgview addSubview:lab5];
    text5 = [[UITextField alloc] initWithFrame:CGRectMake(10, h+190, SCREEN_WIDTH-20, 40)];
    text5.delegate = self;
    text5.borderStyle = UITextBorderStyleRoundedRect;
    text5.placeholder = @"请选择";
    [self.bgview addSubview: text5];
    
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, h+240, SCREEN_WIDTH-20, 40)];
    lab6.text = @"开始使用时间";
    [self.bgview addSubview:lab6];
    text6 = [[UITextField alloc] initWithFrame:CGRectMake(10, h+285, SCREEN_WIDTH-20, 40)];
    text6.delegate = self;
    text6.borderStyle = UITextBorderStyleRoundedRect;
    text6.placeholder = @"请选择";
    [self.bgview addSubview: text6];
    
    
    self.bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-199);
    self.bgview.contentSize = CGSizeMake(0, SCREEN_HEIGHT*1.02);
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
    lab.text = @"设备类别";
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
    
    [self lod];
}
- (void)clicktapbgwindowview:(UITapGestureRecognizer *)tap{
    bgwindowview.hidden = YES;
}
- (void)setupview1{
    bgwindowview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    bgwindowview1.backgroundColor = [UIColor colorWithWhite:.8 alpha:.5];
    bgwindowview1.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapbgwindowview1:)];
    tap.delegate = self;
    [bgwindowview1 addGestureRecognizer:tap];
    [self.view addSubview:bgwindowview1];
    [self.view bringSubviewToFront:bgwindowview1];
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-400.5, SCREEN_WIDTH, 50)];
    lab.text = @"设备维修商";
    lab.backgroundColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [bgwindowview1 addSubview:lab];
    
    self.tableview2 = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-350, SCREEN_WIDTH, 350)];
    [self.tableview2 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    self.tableview2.delegate = self;
    self.tableview2.dataSource = self;
    [bgwindowview1 addSubview:self.tableview2];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableview2.tableFooterView = v;
    
    [self lod];
}
- (void)clicktapbgwindowview1:(UITapGestureRecognizer *)tap{
    bgwindowview1.hidden = YES;
}



- (NSMutableArray *)arr1{
    if (_arr1== nil) {
        self.arr1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr1;
}
- (NSMutableArray *)arr2{
    if (_arr2== nil) {
        self.arr2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _arr2;
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
//        NSLog(@"%@",dic);
        [weakSelf.arr1 removeAllObjects];
        if (![[dic objectForKey:@"equipmentCategoryList"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"equipmentCategoryList"];
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
        
        [weakSelf.tableview1 reloadData];
        [weakSelf.tableview2 reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}









- (void)clicktapTopView:(UITapGestureRecognizer *)tap{
    if (_isHidden == NO) {
        la1.hidden = NO;
        la2.hidden = NO;
        la3.hidden = NO;
        la4.hidden = NO;
        la5.hidden = NO;
        line1.hidden = NO;
        imgjiantou.image = [UIImage imageNamed:@"jiantou1"];
        headerview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 280);
        self.tableview.tableHeaderView = headerview;
    }else{
        la1.hidden = YES;
        la2.hidden = YES;
        la3.hidden = YES;
        la4.hidden = YES;
        la5.hidden = YES;
        line1.hidden = YES;
        imgjiantou.image = [UIImage imageNamed:@"jiantou"];
        headerview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 51);
        self.tableview.tableHeaderView = headerview;
    }
    _isHidden = !_isHidden;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    statu  = @"";
    statu1 = @"";
    statu2 = @"";
    [self lod];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"WDSB_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.view addSubview:self.tableview];
    
    headerview = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 51)];
    headerview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktapTopView:)];
    tap.delegate = self;
    [headerview addGestureRecognizer:tap];
    self.tableview.tableHeaderView = headerview;
    
    UILabel *v = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 50)];
    v.text = @"设备管理流程说明";
    [headerview addSubview:v];
    imgjiantou = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-30, 15, 20, 20)];
    imgjiantou.image = [UIImage imageNamed:@"jiantou"];
    [headerview addSubview:imgjiantou];
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 1)];
    line.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    [headerview addSubview:line];
    
    la1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 55, SCREEN_WIDTH-20, 40)];
    la1.text = @"第一，管理员发起设备维修或者保养申请";
    la1.hidden = YES;
    la1.textColor = [UIColor redColor];
    [headerview addSubview:la1];
    
    la2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 95, SCREEN_WIDTH-20, 40)];
    la2.text = @"第二，部门领导进行确认以及输入费用明细";
    la2.hidden = YES;
    la2.textColor = [UIColor redColor];
    [headerview addSubview:la2];
    
    la3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 135, SCREEN_WIDTH-20, 40)];
    la3.text = @"第三，监控审计部门进行费用确认";
    la3.hidden = YES;
    la3.textColor = [UIColor redColor];
    [headerview addSubview:la3];
    
    la4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 175, SCREEN_WIDTH-20, 40)];
    la4.text = @"发票说明";
    la4.hidden = YES;
    la4.textColor = [UIColor redColor];
    [headerview addSubview:la4];
    
    la5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 215, SCREEN_WIDTH-20, 60)];
    la5.text = @"所有的维修或者保养都是先票后款原则，请相关执行人注意细节。";
    la5.numberOfLines = 0;
    la5.hidden = YES;
    la5.textColor = [UIColor redColor];
    [headerview addSubview:la5];
    
    line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 279, SCREEN_WIDTH, 1)];
    line1.backgroundColor = [UIColor colorWithWhite:.8 alpha:.3];
    line1.hidden = YES;
    [headerview addSubview:line1];
    
//    [self setupsearchview];
//    [self setupview];
//    [self setupview1];
}


- (void)viewWillAppear:(BOOL)animated{
    [self setupsearchview];
    [self setupview];
    [self setupview1];
}



#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]){
        PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
        text3.text = model.name;
        statu1 = model.id;
        bgwindowview.hidden = YES;
    }else if ([tableView isEqual:self.tableview2]){
        PaiDanModel *model = [self.arr2 objectAtIndex:indexPath.row];
        text5.text = model.supplierName;
        statu2 = model.id;
        bgwindowview1.hidden = YES;
    }else if ([tableView isEqual:self.tableview]){
        
    }
    if ([tableView isEqual:self.tableview]) {
        Details_01_ViewController *vc = [[Details_01_ViewController alloc] initWithAddVCARY:@[[Details_1_1_ViewController new],[Details_1_2_ViewController new]] TitleS:@[@"维修记录",@"保养记录"]];
        PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
        
        NSDictionary *dict = [[NSDictionary alloc]init];
        dict = @{@"idstring":model.id};
        NSNotification *notification =[NSNotification notificationWithName:@"wdsb" object:nil userInfo:dict];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([tableView isEqual:self.tableview1]){
        return self.arr1.count;
    }else if ([tableView isEqual:self.tableview2]){
        return self.arr2.count;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]){
        return 50;
    }else if ([tableView isEqual:self.tableview2]){
        return 50;
    }
    return 670;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tableview1]) {
        static NSString *identifierCell = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.arr1 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.name;
        return cell;
    }
    if ([tableView isEqual:self.tableview2]) {
        static NSString *identifierCell = @"cell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PaiDanModel *model = [self.arr2 objectAtIndex:indexPath.row];
        cell.textLabel.text = model.supplierName;
        return cell;
    }
    
    static NSString *identifierCell = @"cell";
    WDSB_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[WDSB_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    LRViewBorderRadius(cell.img1, 0, 1, [UIColor colorWithWhite:.85 alpha:.3]);
    LRViewBorderRadius(cell.img2, 0, 1, [UIColor colorWithWhite:.85 alpha:.3]);
    
    [cell.img1 sd_setImageWithURL:[NSURL URLWithString:NSString(model.field3)]placeholderImage:[UIImage imageNamed:@"logo"]];
    [cell.img2 sd_setImageWithURL:[NSURL URLWithString:NSString(model.field4)]placeholderImage:[UIImage imageNamed:@"logo"]];
    
    cell.lab1.text  = model.equipmentNo;
    cell.lab2.text  = model.equipmentName;
    cell.lab3.text  = model.equipmentColor;
    
    for (PaiDanModel *model1 in self.arr1) {
        if ([model.equipmentCategoryId isEqualToString:model1.id]) {
            cell.lab4.text  = model1.name;
        }
    }
    if (model.field1 == nil) {
        cell.lab5.text  = @"-";
    }else{
        cell.lab5.text  = model.field1;
    }
    
    cell.lab6.text  = model.equipmentManager;
    cell.lab7.text  = model.field2;
    
    
    if (model.equipmentSupplier_s == nil) {
        cell.lab8.text  = @"-";
    }else{
        cell.lab8.text  = model.equipmentSupplier_model.supplierName;
    }
    
    cell.lab9.text  = model.equipmentUseTime;
    
    
    
    if ([model.equipmentStatus isEqualToString:@"A"]) {
        cell.lab10.text = @"正常";
        cell.lab10.textColor = [UIColor blueColor];
    }else if ([model.equipmentStatus isEqualToString:@"B"]) {
        cell.lab10.text = @"停用";
        cell.lab10.textColor = [UIColor redColor];
    }else if ([model.equipmentStatus isEqualToString:@"C"]) {
        cell.lab10.text = @"维修中";
        cell.lab10.textColor = RGBACOLOR(37,167,159, 1);
    }
    
    
    
    
    cell.btn3.hidden = YES;
   
    LRViewBorderRadius(cell.btn1, 15, 1, [UIColor blackColor]);
    LRViewBorderRadius(cell.btn2, 15, 1, [UIColor blackColor]);
    [cell.btn2 addTarget:self action:@selector(clickbtn2:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn1 addTarget:self action:@selector(clickbtn1:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)clickbtn1:(UIButton *)sender{
    WDSB_Cell *cell = (WDSB_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    ShenQing_ViewController *shenqing = [[ShenQing_ViewController alloc]init];
    shenqing.navigationItem.title = @"保养申请";
    shenqing.idstr = model.id;
    [self.navigationController pushViewController:shenqing animated:YES];
}
- (void)clickbtn2:(UIButton *)sender{
    WDSB_Cell *cell = (WDSB_Cell *)[[sender superview] superview];
    NSIndexPath *indexpath = [self.tableview indexPathForCell:cell];
    PaiDanModel *model = [self.dataArray objectAtIndex:indexpath.row];
    
    ShenQing_ViewController *shenqing = [[ShenQing_ViewController alloc]init];
    shenqing.navigationItem.title = @"维修申请";
    shenqing.idstr = model.id;
    [self.navigationController pushViewController:shenqing animated:YES];
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
            @"equipmentManager":[Manager redingwenjianming:@"id.text"],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"equipmentNo":text1.text,
            @"equipmentName":text2.text,
            @"equipmentCategoryId":statu1,
            @"equipmentStatus":statu,
            
            @"field2":text4.text,
            @"equipmentSupplierId":statu2,
            @"equipmentUseTime":text6.text,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipment/mylist") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//            NSLog(@"guowai----%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        [weakSelf.dataArray removeAllObjects];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentSupplier];
                model.equipmentSupplier_model = model1;
                
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
            @"equipmentManager":[Manager redingwenjianming:@"id.text"],
            
            @"equipmentNo":text1.text,
            @"equipmentName":text2.text,
            @"equipmentCategoryId":statu1,
            @"equipmentStatus":statu,
            
            @"field2":text4.text,
            @"equipmentSupplierId":statu2,
            @"equipmentUseTime":text6.text,
            };
    [session POST:KURLNSString(@"servlet/equipment/equipment/mylist") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        if (![[dic objectForKey:@"rows"]isEqual:[NSNull null]]) {
            NSMutableArray *arr = [dic objectForKey:@"rows"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                PaidanModel1 *model1 = [PaidanModel1 mj_objectWithKeyValues:model.equipmentSupplier];
                model.equipmentSupplier_model = model1;
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

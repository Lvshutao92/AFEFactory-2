//
//  YLWp_ViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2017/12/12.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "YLWp_ViewController.h"
#import "YuanGong_Cell.h"

#import "PaiDanModel.h"
#import "PaidanModel1.h"
@interface YLWp_ViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UITextFieldDelegate>
{
    CGFloat height;
    NSInteger page;
    NSInteger totalnum;
    
    
    UIView *yuan;
    UILabel *shang;
    UILabel *xia;
    
    
    UIView *window;
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    UITextField *text6;
    UITextField *text7;
    UITextField *text8;
    UITextField *text9;
    NSString *idstring2;
    NSString *idstring3;
    NSString *idstring4;
    
    
    UIView *bgwindowview;
    UILabel *bglab;
}
@property(nonatomic,strong)UIScrollView *bgview;
@property(nonatomic,strong)UILabel *toplab;
@property(nonatomic,strong)NSMutableArray *dataArray0;
@property(nonatomic,strong)NSMutableArray *dataArray1;
@property(nonatomic,strong)NSMutableArray *dataArray2;
@property(nonatomic,strong)NSMutableArray *dataArray3;
@property(nonatomic,strong)NSMutableArray *dataArray4;
@property(strong,nonatomic)UITableView    *tableview1;






@property(nonatomic, strong)UITableView *tableview;
@property(nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation YLWp_ViewController
- (void)setrespos{
    [text1 resignFirstResponder];
    [text2 resignFirstResponder];
    [text3 resignFirstResponder];
    [text4 resignFirstResponder];
    [text5 resignFirstResponder];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text6]) {
        self.dataArray0 = self.dataArray1;
        [self.tableview1 reloadData];
        bglab.text = @"使用人";
        bgwindowview.hidden = NO;
        return NO;
    }
    if ([textField isEqual:text7]) {
        self.dataArray0 = self.dataArray2;
        [self.tableview1 reloadData];
        bglab.text = @"耐用品类型";
        bgwindowview.hidden = NO;
        return NO;
    }
    if ([textField isEqual:text8]) {
        self.dataArray0 = self.dataArray3;
        [self.tableview1 reloadData];
        bglab.text = @"物品类型";
        bgwindowview.hidden = NO;
        return NO;
    }
    if ([textField isEqual:text9]) {
        self.dataArray0 = self.dataArray4;
        [self.tableview1 reloadData];
        bglab.text = @"状态";
        bgwindowview.hidden = NO;
        return NO;
    }
    return YES;
}
- (void)cancle{
    [self setrespos];
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    text5.text = @"";
    text6.text = @"";
    text7.text = @"";
    text8.text = @"";
    text9.text = @"";
    idstring2 = @"";
    idstring3 = @"";
    idstring4 = @"";
    window.hidden = YES;
}
- (void)sure{
    [self setrespos];
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
    if (idstring2.length == 0) {
        idstring2 = @"";
    }
    if (idstring3.length == 0) {
        idstring3 = @"";
    }
    if (idstring4.length == 0) {
        idstring4 = @"";
    }
    [self setUpReflash];
    window.hidden = YES;
}
- (void)clicksearch{
    [self setrespos];
    text1.text = @"";
    text2.text = @"";
    text3.text = @"";
    text4.text = @"";
    text5.text = @"";
    text6.text = @"";
    text7.text = @"";
    text8.text = @"";
    text9.text = @"";
    idstring2 = @"";
    idstring3 = @"";
    idstring4 = @"";
    if (window.hidden == YES) {
        window.hidden = NO;
    }else{
        window.hidden = YES;
    }
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
    lab1.text = @"物品编号";
    [self.bgview addSubview:lab1];
    text1 = [[UITextField alloc] initWithFrame:CGRectMake(10,50, SCREEN_WIDTH-20, 40)];
    text1.delegate = self;
    text1.text= @"";
    text1.placeholder = @"请输入物品编号";
    text1.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text1];
    
    UILabel *lab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 100, 40)];
    lab2.text = @"名称";
    [self.bgview addSubview:lab2];
    text2 = [[UITextField alloc] initWithFrame:CGRectMake(10, 145, SCREEN_WIDTH-20, 40)];
    text2.delegate = self;
    text2.borderStyle = UITextBorderStyleRoundedRect;
    text2.text= @"";
    text2.placeholder = @"请输入名称";
    
    [self.bgview addSubview: text2];
    
    UILabel *lab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 195, 150, 40)];
    lab3.text = @"品牌";
    [self.bgview addSubview:lab3];
    text3 = [[UITextField alloc] initWithFrame:CGRectMake(10,240, SCREEN_WIDTH-20, 40)];
    text3.delegate = self;
    text3.text= @"";
    text3.placeholder = @"请输入品牌";
    text3.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text3];
    
    UILabel *lab4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 290, 150, 40)];
    lab4.text = @"型号";
    [self.bgview addSubview:lab4];
    text4 = [[UITextField alloc] initWithFrame:CGRectMake(10,335, SCREEN_WIDTH-20, 40)];
    text4.delegate = self;
    text4.text= @"";
    text4.placeholder = @"请输入型号";
    text4.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text4];
    
    UILabel *lab5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 385, 150, 40)];
    lab5.text = @"规格";
    [self.bgview addSubview:lab5];
    text5 = [[UITextField alloc] initWithFrame:CGRectMake(10,430, SCREEN_WIDTH-20, 40)];
    text5.delegate = self;
    text5.text= @"";
    text5.placeholder = @"请输入规格";
    text5.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text5];
    
    UILabel *lab6 = [[UILabel alloc]initWithFrame:CGRectMake(10, 480, 150, 40)];
    lab6.text = @"使用人";
    [self.bgview addSubview:lab6];
    text6 = [[UITextField alloc] initWithFrame:CGRectMake(10,525, SCREEN_WIDTH-20, 40)];
    text6.delegate = self;
    text6.text= @"";
    text6.placeholder = @"请选择";
    text6.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text6];
    
    UILabel *lab7 = [[UILabel alloc]initWithFrame:CGRectMake(10, 575, 150, 40)];
    lab7.text = @"耐用品类型";
    [self.bgview addSubview:lab7];
    text7 = [[UITextField alloc] initWithFrame:CGRectMake(10,620, SCREEN_WIDTH-20, 40)];
    text7.delegate = self;
    text7.text= @"";
    text7.placeholder = @"请选择";
    text7.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text7];
    
    
    UILabel *lab8 = [[UILabel alloc]initWithFrame:CGRectMake(10, 670, 150, 40)];
    lab8.text = @"物品类型";
    [self.bgview addSubview:lab8];
    text8 = [[UITextField alloc] initWithFrame:CGRectMake(10,715, SCREEN_WIDTH-20, 40)];
    text8.delegate = self;
    text8.text= @"";
    text8.placeholder = @"请选择";
    text8.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text8];
    
    
    UILabel *lab9 = [[UILabel alloc]initWithFrame:CGRectMake(10, 765, 150, 40)];
    lab9.text = @"状态";
    [self.bgview addSubview:lab9];
    text9 = [[UITextField alloc] initWithFrame:CGRectMake(10,810, SCREEN_WIDTH-20, 40)];
    text9.delegate = self;
    text9.text= @"";
    text9.placeholder = @"请选择";
    text9.borderStyle = UITextBorderStyleRoundedRect;
    [self.bgview addSubview: text9];
    text6.backgroundColor = [UIColor colorWithWhite:.85 alpha:.4];
    text7.backgroundColor = [UIColor colorWithWhite:.85 alpha:.4];
    text8.backgroundColor = [UIColor colorWithWhite:.85 alpha:.4];
    text9.backgroundColor = [UIColor colorWithWhite:.85 alpha:.4];
    
    self.bgview.frame = CGRectMake(0, 0, self.view.frame.size.width, SCREEN_HEIGHT-199);
    self.bgview.contentSize = CGSizeMake(0, 950);
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


- (void)lodd{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodsstaff") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//        NSLog(@"-------%@",dic);
        
        
        [weakSelf.dataArray1 removeAllObjects];
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"users"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                [weakSelf.dataArray1 addObject:model];
            }
        }
        
        
        
        [weakSelf.dataArray2 removeAllObjects];
        if (![[dic objectForKey:@"rows"] isEqual:[NSNull null]]) {
            NSMutableArray *arr = [[dic objectForKey:@"rows"] objectForKey:@"types"];
            for (NSDictionary *dict in arr) {
                PaiDanModel *model = [PaiDanModel mj_objectWithKeyValues:dict];
                [weakSelf.dataArray2 addObject:model];
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
}










- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    idstring2 = @"";
    idstring3 = @"";
    idstring4 = @"";
    [self lodd];
    self.dataArray3 = [@[@"易耗品",@"耐用品"]mutableCopy];
    self.dataArray4 = [@[@"正常",@"维修中",@"归还中",@"已归还",@"维修失败"]mutableCopy];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(clicksearch)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"YuanGong_Cell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableview];
    
    
    
//    yuan = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-70, SCREEN_HEIGHT-80, 60, 60)];
//    yuan.backgroundColor = [UIColor orangeColor];
//    yuan.layer.cornerRadius = 30;
//    UILabel *lin = [[UILabel alloc]initWithFrame:CGRectMake(0, 29.5, 60, 1)];
//    lin.backgroundColor = [UIColor lightGrayColor];
//    [yuan addSubview:lin];
//    [self.view addSubview:yuan];
//
//
//    shang = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 60, 20)];
//    shang.textAlignment = NSTextAlignmentCenter;
//    [yuan addSubview:shang];
//
//    xia = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, 60, 20)];
//    xia.textAlignment = NSTextAlignmentCenter;
//    [yuan addSubview:xia];
    
    [self setupButton];
    [self setupview_tableview];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        if ([self.dataArray0 isEqual:self.dataArray1]) {
            PaiDanModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
            text6.text = model.username;
        }
        if ([self.dataArray0 isEqual:self.dataArray2]) {
            PaiDanModel *model = [self.dataArray2 objectAtIndex:indexPath.row];
            text7.text = model.name;
            idstring2 = model.id;
        }
        if ([self.dataArray0 isEqual:self.dataArray3]) {
            text8.text = self.dataArray3[indexPath.row];
            if ([text8.text isEqualToString:@"易耗品"]) {
                idstring3 = @"YH";
            }else if ([text8.text isEqualToString:@"耐用品"]) {
                idstring3 = @"NY";
            }
        }
        if ([self.dataArray0 isEqual:self.dataArray4]) {
            text9.text = self.dataArray3[indexPath.row];
            if ([text9.text isEqualToString:@"维修中"]) {
                idstring4 = @"repairing";
            }else if ([text9.text isEqualToString:@"归还中"]) {
                idstring4 = @"returning";
            }else if ([text9.text isEqualToString:@"已归还"]) {
                idstring4 = @"returned";
            }else if ([text9.text isEqualToString:@"维修失败"]) {
                idstring4 = @"repair_failed";
            }
        }
        bgwindowview.hidden = YES;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:self.tableview1]) {
        return 60;
    }
    return 400;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:self.tableview1]) {
        return self.dataArray0.count;
    }
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:self.tableview1]) {
        
        if ([self.dataArray0 isEqual:self.dataArray1]) {
            static NSString *identifierCell = @"cells";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            PaiDanModel *model = [self.dataArray1 objectAtIndex:indexPath.row];
            cell.textLabel.text = model.username;
            return cell;
        }
        
        
        if ([self.dataArray0 isEqual:self.dataArray2]) {
            static NSString *identifierCell = @"cells";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            PaiDanModel *model = [self.dataArray2 objectAtIndex:indexPath.row];
            cell.textLabel.text = model.name;
            return cell;
        }
        
        
        if ([self.dataArray0 isEqual:self.dataArray3]) {
            static NSString *identifierCell = @"cells";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = self.dataArray3[indexPath.row];
            return cell;
        }
        if ([self.dataArray0 isEqual:self.dataArray4]) {
            static NSString *identifierCell = @"cells";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = self.dataArray4[indexPath.row];
            return cell;
        }
    }
    
    static NSString *identifierCell = @"cell";
    YuanGong_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell];
    if (cell == nil) {
        cell = [[YuanGong_Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifierCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lab12.hidden = YES;
    cell.line.hidden  = YES;
    cell.btn.hidden   = YES;
    cell.btn1.hidden   = YES;
    PaiDanModel *model = [self.dataArray objectAtIndex:indexPath.row];
    
    if (model.itemPicture != nil) {
        [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.itemPicture)]placeholderImage:[UIImage imageNamed:@"user"]];
    }else{
        [cell.img sd_setImageWithURL:[NSURL URLWithString:NSString(model.goodsPicture)]placeholderImage:[UIImage imageNamed:@"user"]];
    }
    
    cell.img.contentMode = UIViewContentModeScaleAspectFit;
    
    cell.lab1.text = [NSString stringWithFormat:@"物品编号：%@",model.code];
    
    cell.lab2.text = [NSString stringWithFormat:@"名称：%@",model.name];
    
    cell.lab3.text = [NSString stringWithFormat:@"品牌：%@",model.brand];
    
    if (model.model_s != nil) {
        cell.lab4.text = [NSString stringWithFormat:@"型号：%@",model.model_s];
    }else{
        cell.lab4.text = [NSString stringWithFormat:@"型号：%@",@"-"];
    }
    
    cell.lab5.text = [NSString stringWithFormat:@"规格：%@",model.standard];
    
    if ([model.state isEqualToString:@"normal"]) {
        cell.lab6.textColor = [UIColor greenColor];
        
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：正常"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab6 setAttributedText:noteStr];
    } else if ([model.state isEqualToString:@"repairing"]) {
        cell.lab6.textColor = [UIColor orangeColor];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：维修中"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab6 setAttributedText:noteStr];
    } else if ([model.state isEqualToString:@"returning"]) {
        cell.lab6.textColor = RGBACOLOR(37, 167, 159, 1);
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：归还中"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab6 setAttributedText:noteStr];
    } else if ([model.state isEqualToString:@"returned"]) {
        cell.lab6.textColor = [UIColor blueColor];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：已归还"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab6 setAttributedText:noteStr];
    } else if ([model.state isEqualToString:@"repair_failed"]) {
        cell.lab6.textColor = [UIColor redColor];
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:@"状态：维修失败"];
        NSRange range = NSMakeRange(0, 3);
        [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [cell.lab6 setAttributedText:noteStr];
    }
    
    
    
    
    
    
    
    
    
    
    
    
    cell.lab7.text  = [NSString stringWithFormat:@"数量：%@     单位：%@",model.num,model.unit];
    
    if (model.durableType != nil) {
        cell.lab8.text  = [NSString stringWithFormat:@"物品类别：%@",model.durableType];
    }else{
        cell.lab8.text  = [NSString stringWithFormat:@"物品类别：%@",@"易耗品"];
    }
    
    
    
    if (model.price != nil) {
        cell.lab9.text  = [NSString stringWithFormat:@"价值(元)：%@",model.price];
    }else{
        cell.lab9.text  = [NSString stringWithFormat:@"价值(元)：%@",@"-"];
    }
    
    
    cell.lab10.text = [NSString stringWithFormat:@"使用人：%@",model.takerName];
    
    cell.lab11.text = [NSString stringWithFormat:@"领用时间：%@",[Manager TimeCuoToTimes:model.takeTime]];
    
    
    return cell;
}






- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    shang.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
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
            @"departmentPersonSessionId":[Manager redingwenjianming:@"id.text"],
            @"page":[NSString stringWithFormat:@"%ld",page],
            @"sorttype":@"asc",
            @"sort":@"undefined",
            
            @"code":text1.text,
            @"name":text2.text,
            @"brand":text3.text,
            @"model":text4.text,
            @"standard":text5.text,
            @"takerName":text6.text,
            @"durableTypeId":idstring2,
            @"type":idstring3,
            @"state":idstring4,
            };
//     NSLog(@"****************%@",dic);
    [session POST:KURLNSString(@"servlet/officegoods/officegoodsstaff/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //        NSLog(@"%@",dic);
        totalnum = [[dic objectForKey:@"total"] integerValue];
        if (totalnum > 0) {
            yuan.hidden = NO;
            xia.text = [NSString stringWithFormat:@"%ld",totalnum];
        }else{
            yuan.hidden = YES;
        }
        
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
            @"sort":@"undefined",
            
            @"code":text1.text,
            @"name":text2.text,
            @"brand":text3.text,
            @"model":text4.text,
            @"standard":text5.text,
            @"takerName":text6.text,
            @"durableTypeId":idstring2,
            @"type":idstring3,
            @"state":idstring4,
            };
    [session POST:KURLNSString(@"servlet/officegoods/officegoodsstaff/list") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
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
- (NSMutableArray *)dataArray0 {
    if (_dataArray0 == nil) {
        self.dataArray0 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray0;
}
- (NSMutableArray *)dataArray1 {
    if (_dataArray1 == nil) {
        self.dataArray1 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray1;
}

- (NSMutableArray *)dataArray2 {
    if (_dataArray2 == nil) {
        self.dataArray2 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray2;
}

- (NSMutableArray *)dataArray3 {
    if (_dataArray3 == nil) {
        self.dataArray3 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray3;
}

- (NSMutableArray *)dataArray4 {
    if (_dataArray4 == nil) {
        self.dataArray4 = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataArray4;
}


@end

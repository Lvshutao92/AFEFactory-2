//
//  XiuGaiViewController.m
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/11.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import "XiuGaiViewController.h"

@interface XiuGaiViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
{
    UIScrollView *scrollview;
    
    UITextField *text1;
    UITextField *text2;
    UITextField *text3;
    UITextField *text4;
    UITextField *text5;
    
    UITextField *text6;
    UITextField *text7;
    UITextField *text8;
    UITextField *text9;
    UITextField *text10;
    
    UITextField *text11;
    
    UIView *window;
}


@end

@implementation XiuGaiViewController


- (void)clicksave{
    NSString *statu;
    if ([text11.text isEqualToString:@"正常"]) {
        statu = @"Y";
    }else{
        statu = @"N";
    }
    
    if (text1.text.length != 0 && text5.text.length != 0 && text9.text.length != 0 &&
        text2.text.length != 0 && text6.text.length != 0 && text3.text.length != 0 &&
        text7.text.length != 0 && text11.text.length != 0&&
        text4.text.length != 0 && text8.text.length != 0 ) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"id":self.idstr,
                @"supplierCode":text1.text,
                @"supplierName":text2.text,
                @"supplierAddress":text3.text,
                @"supplierTel":text4.text,
                @"supplierConPerson":text5.text,
                
                @"supplierConPersonTel":text6.text,
                @"field1":text7.text,
                @"field2":text8.text,
                @"field3":text9.text,
                @"field4":text10.text,
                @"status":statu,
                };
//        NSLog(@"----------%@",dic);
        NSString *str;
        if ([self.navigationItem.title isEqualToString:@"新增"]) {
            str = @"servlet/equipment/equipmentsupplier/add";
        }else{
            str = @"servlet/equipment/equipmentsupplier/update";
        }
        [session POST:KURLNSString(str) parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
//            /NSLog(@"----------%@",dic);
                    if ([[dic objectForKey:@"code"] isEqualToString:@"success"]) {
                        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功" message:@"温馨提示" preferredStyle:1];
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            [weakSelf.navigationController popViewControllerAnimated:YES];
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
    
    
    UIBarButtonItem *bar = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(clicksave)];
    self.navigationItem.rightBarButtonItem = bar;
    
    
    scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 10, SCREEN_WIDTH-10, SCREEN_HEIGHT-10)];
    scrollview.backgroundColor = [UIColor colorWithWhite:.85 alpha:.3];
    [self.view addSubview:scrollview];
    
    NSArray *arr = @[@"维修商代码",@"维修商名称",@"维修商联系地址",@"维修商联系电话",@"维修商联系人",@"维修商联系人手机",@"开户银行",@"银行账户",@"银行账号",@"预计付款天数",@"状态"];
    for (int i = 0; i<arr.count; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+30*i+20*i, 135, 30)];
        lab.text = arr[i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:16];
        [scrollview addSubview:lab];
    }
    scrollview.contentSize = CGSizeMake(0, SCREEN_HEIGHT);
    
    
    for (int j = 0; j<arr.count; j++) {
        UITextField *textfield = [[UITextField alloc]initWithFrame:CGRectMake(150, 5+40*j+10*j, SCREEN_WIDTH-165, 40)];
        textfield.delegate = self;
        
        switch (j) {
            case 0:
                text1 = textfield;
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
                text4.text = _str4;
                break;
            case 4:
                text5 = textfield;
                text5.text = _str5;
                break;
                
            case 5:
                text6 = textfield;
                text6.text = _str6;
                break;
            case 6:
                text7 = textfield;
                text7.text = _str7;
                break;
            case 7:
                text8 = textfield;
                text8.text = _str8;
                break;
            case 8:
                text9 = textfield;
                text9.text = _str9;
                break;
            case 9:
                text10 = textfield;
                text10.text = _str10;
                break;
                
            case 10:
                text11 = textfield;
                text11.text = _str11;
                break;
            default:
                break;
        }
        textfield.borderStyle = UITextBorderStyleRoundedRect;
        [scrollview addSubview:textfield];
    }
    
    window = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    window.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clicktap:)];
    tap.delegate = self;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, SCREEN_HEIGHT-105, SCREEN_WIDTH, 50);
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setTitle:@"停用" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(ty) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, SCREEN_HEIGHT-156, SCREEN_WIDTH, 50);
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 setTitle:@"正常" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(zc) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:btn2];
    
    [window addGestureRecognizer:tap];
    window.backgroundColor = [UIColor colorWithWhite:.5 alpha:.5];
    [self.view addSubview:window];
    
 
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:text11]) {
        window.hidden = NO;
        return NO;
    }
    return YES;
}
- (void)clicktap:(UITapGestureRecognizer *)gesture{
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
- (void)ty{
    window.hidden = YES;
    text11.text = @"停用";
}
- (void)zc{
    window.hidden = YES;
    text11.text = @"正常";
}






@end

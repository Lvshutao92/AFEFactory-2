//
//  PaiDan_pdcs_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PaiDan_pdcs_ViewController.h"

@interface PaiDan_pdcs_ViewController ()<UITextFieldDelegate>
{
    NSString *strid;
}
@end

@implementation PaiDan_pdcs_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 108.3, SCREEN_WIDTH, 5)];
    lab.backgroundColor = RGBACOLOR(228, 228, 228, 1);
    [self.view addSubview:lab];
    
    self.text1.delegate = self;
    self.text2.delegate = self;
    self.text3.delegate = self;
    self.text4.delegate = self;
    self.text5.delegate = self;
    self.text1.keyboardType = UIKeyboardTypeNumberPad;
    self.text2.keyboardType = UIKeyboardTypeNumberPad;
    self.text3.keyboardType = UIKeyboardTypeNumberPad;
    self.text5.keyboardType = UIKeyboardTypeNumberPad;
    LRViewBorderRadius(self.btn, 5, 0, RGBACOLOR(32, 157, 149, 1.0));
    
    CGFloat height;
    if ([[[Manager sharedManager] iphoneType] isEqualToString:@"iPhone X"]) {
        height = 88;
        self.labtop.constant = 130+24;
        self.texttop.constant = 125+24;
    }else{
        height = 64;
        self.labtop.constant = 130;
        self.texttop.constant = 125;
    }
    
    [self lodinformation];
    
   
}



- (IBAction)clickButtonComitInformation:(id)sender {
    if (self.text1.text.length != 0 && self.text2.text.length != 0 && self.text3.text.length != 0 && self.text4.text.length != 0 && self.text5.text.length != 0) {
        AFHTTPSessionManager *session = [Manager returnsession];
        __weak typeof(self) weakSelf = self;
        NSDictionary *dic = [[NSDictionary alloc]init];
        dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
                @"id":strid,
                @"normalOutput":self.text1.text,
                @"overtimeOutput":self.text2.text,
                @"queueDay":self.text3.text,
                @"field1":self.text4.text,
                @"field2":self.text5.text,
                };
        [session POST:KURLNSString(@"servlet/production/productionconfig/add") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic = [Manager returndictiondata:responseObject];
            //NSLog(@"---%@",dic);
            if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存成功\n温馨提示：修改正常产量后，新增的单据会立即生效，如果需要所有单据都生效，请指定日期重新排单" message:nil preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存失败" message:@"" preferredStyle:1];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alert addAction:cancel];
                [weakSelf presentViewController:alert animated:YES completion:nil];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存失败" message:@"" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"所有信息均不能为空" message:@"温馨提示" preferredStyle:1];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}








- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.text4]) {
        [self.text1 resignFirstResponder];
        [self.text2 resignFirstResponder];
        [self.text3 resignFirstResponder];
        [self.text5 resignFirstResponder];
        KSDatePicker* picker = [[KSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        picker.appearance.radius = 5;
        picker.appearance.resultCallBack = ^void(KSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *str = [formatter stringFromDate:currentDate];
                self.text4.text = str;
            }
        };
        [picker show];
        return NO;
    }
    return YES;
}




- (void)lodinformation{
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            };
    [session POST:KURLNSString(@"servlet/production/productionconfig") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic  = [Manager returndictiondata:responseObject];
        if ([[dic objectForKey:@"result_code"]isEqualToString:@"success"]) {
             NSDictionary *dict = [[dic objectForKey:@"rows"] objectForKey:@"data"];
            
             weakSelf.text1.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"normalOutput"]];
             weakSelf.text2.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"overtimeOutput"]];
             weakSelf.text3.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"queueDay"]];
             weakSelf.text4.text = [dict objectForKey:@"field1"];
             weakSelf.text5.text = [dict objectForKey:@"field2"];
             strid = [dict objectForKey:@"id"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}






@end

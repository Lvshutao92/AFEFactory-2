//
//  LLPF_ViewController.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/23.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "LLPF_ViewController.h"

@interface LLPF_ViewController ()

@end

@implementation LLPF_ViewController

- (IBAction)clickbutton1:(id)sender {
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":self.idstr,
            @"score":@"多料",
            @"userId":[Manager redingwenjianming:@"userid.text"],
            };
    //NSLog(@"---%@",dic);
    [session POST:KURLNSString(@"servlet/production/productionorder/myorder/score") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
//                    NSLog(@"+++%@",dic);
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"评分成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
    
}

- (IBAction)clickbutton2:(id)sender {
    
  
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":self.idstr,
            @"score":@"少料",
            @"userId":[Manager redingwenjianming:@"userid.text"],
            };
    //NSLog(@"---%@",dic);
    [session POST:KURLNSString(@"servlet/production/productionorder/myorder/score") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //            NSLog(@"+++%@",dic);
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"评分成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
}

- (IBAction)clickbutton3:(id)sender {
    
    AFHTTPSessionManager *session = [Manager returnsession];
    __weak typeof(self) weakSelf = self;
    NSDictionary *dic = [[NSDictionary alloc]init];
    dic = @{@"businessId":[Manager redingwenjianming:@"bianhao.text"],
            @"id":self.idstr,
            @"score":@"正常",
            @"userId":[Manager redingwenjianming:@"userid.text"],
            };
    //NSLog(@"---%@",dic);
    [session POST:KURLNSString(@"servlet/production/productionorder/myorder/score") parameters:dic constructingBodyWithBlock:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [Manager returndictiondata:responseObject];
        //            NSLog(@"+++%@",dic);
        if ([[dic objectForKey:@"result_code"] isEqualToString:@"success"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"评分成功" message:@"温馨提示" preferredStyle:1];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }];
            [alert addAction:cancel];
            [weakSelf presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
    
}









@end

//
//  SYDJ_search_ViewController.h
//  Factory
//
//  Created by ilovedxracer on 2017/11/22.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYDJ_search_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labtop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *texttop;




@property (weak, nonatomic) IBOutlet UITextField *text1;

@property (weak, nonatomic) IBOutlet UITextField *text2;
@property (weak, nonatomic) IBOutlet UITextField *text3;
@property (weak, nonatomic) IBOutlet UITextField *text4;

@property (weak, nonatomic) IBOutlet UITextField *text5;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property(nonatomic,strong)NSString *str;
@end

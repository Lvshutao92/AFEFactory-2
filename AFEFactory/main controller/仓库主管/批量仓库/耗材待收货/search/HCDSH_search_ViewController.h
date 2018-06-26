//
//  HCDSH_search_ViewController.h
//  Factory
//
//  Created by ilovedxracer on 2017/11/24.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCDSH_search_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *text1;
@property (weak, nonatomic) IBOutlet UITextField *text2;
@property (weak, nonatomic) IBOutlet UITextField *text3;
@property (weak, nonatomic) IBOutlet UITextField *text4;

@property (weak, nonatomic) IBOutlet UITextField *text5;
@property (weak, nonatomic) IBOutlet UITextField *text6;



@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab1top;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *text1top;

@property(nonatomic,strong)NSString *str;
@end

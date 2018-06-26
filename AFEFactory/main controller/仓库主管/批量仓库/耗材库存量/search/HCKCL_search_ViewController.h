//
//  HCKCL_search_ViewController.h
//  Factory
//
//  Created by ilovedxracer on 2017/11/24.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCKCL_search_ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *text1;
@property (weak, nonatomic) IBOutlet UITextField *text2;

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labtop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *texttop;


@property(nonatomic,strong)NSString *str;



@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab1width;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab2width;

@end

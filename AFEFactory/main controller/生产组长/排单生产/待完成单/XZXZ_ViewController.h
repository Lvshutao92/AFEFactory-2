//
//  XZXZ_ViewController.h
//  Factory
//
//  Created by ilovedxracer on 2017/11/23.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XZXZ_ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *text;

@property (weak, nonatomic) IBOutlet UIButton *btn;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labtop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *texttop;


@property(nonatomic,strong)NSString *idstr;
@end

//
//  Edit_KuWei_ViewController.h
//  Factory
//
//  Created by ilovedxracer on 2017/11/28.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Edit_KuWei_ViewController : UIViewController
@property(nonatomic,strong)NSString *idstr;

@property(nonatomic,strong)NSString *lab1str;
@property(nonatomic,strong)NSString *lab2str;
@property(nonatomic,strong)NSString *lab3str;
@property(nonatomic,strong)NSString *lab4str;




@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;

@property (weak, nonatomic) IBOutlet UILabel *lab3;
@property (weak, nonatomic) IBOutlet UILabel *lab4;


@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labtop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *texttop;

@end

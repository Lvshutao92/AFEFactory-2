//
//  TimeZhou_Cell.h
//  DXRacerSupplierAFE
//
//  Created by ilovedxracer on 2017/11/8.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeZhou_Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;

@property (weak, nonatomic) IBOutlet UILabel *lab3;

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *line;




@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lab1height;

@property (weak, nonatomic) IBOutlet UILabel *lineheight;

@end

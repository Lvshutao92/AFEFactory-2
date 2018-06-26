//
//  PaiDanModel.m
//  Factory
//
//  Created by ilovedxracer on 2017/11/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "PaiDanModel.h"

@implementation PaiDanModel
+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"receivePerson_ed"]) propertyName = @"receivePerson";
    if ([propertyName isEqualToString:@"forkliftPerson_ed"]) propertyName = @"forkliftPerson";
    if ([propertyName isEqualToString:@"model_s"]) propertyName = @"model";
    if ([propertyName isEqualToString:@"equipmentSupplier_s"]) propertyName = @"equipmentSupplier";
    
    
    return propertyName;
}

@end


















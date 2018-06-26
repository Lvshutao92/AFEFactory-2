//
//  PaidanModel2.h
//  Factory
//
//  Created by ilovedxracer on 2017/11/21.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaidanModel2 : NSObject
@property(nonatomic,strong)NSString *abroadOrder;
@property(nonatomic,strong)NSString *containerId;
@property(nonatomic,strong)NSString *createTime;


@property(nonatomic,strong)NSString *currencyId;
@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *id;


@property(nonatomic,strong)NSString *order;
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *orderNote;


@property(nonatomic,strong)NSString *orderStatus;
@property(nonatomic,strong)NSString *orderStatusChildren;
@property(nonatomic,strong)NSString *orderTotalFee;


@property(nonatomic,strong)NSString *orderType;
@property(nonatomic,strong)NSString *productTotalFee;
@property(nonatomic,strong)NSString *purchaseOrderList;

@property(nonatomic,strong)NSString *purchasePlanNo;

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *stepName;
@property(nonatomic,strong)NSString *stepImg;

@end


//"modelCraftBom" : {
//
//    "modelCraftStep" : {
//        "stepName" : "领料",---------------------------
//        "stepImg" : "factory/10003/model/craft/13_null_1505564579421.png",---------------------------
//    },
//    "modelCraftProcedure" : {
//        "id" : 1,
//        "code" : "back",
//        "name" : "靠背",---------------------------
//    },
//    "modelCraftType" : {
//        "name" : "电竞椅",
//    }
//},


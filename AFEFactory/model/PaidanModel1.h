//
//  PaidanModel1.h
//  Factory
//
//  Created by ilovedxracer on 2017/11/21.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaidanModel2.h"
@interface PaidanModel1 : NSObject
@property(nonatomic,strong)NSString *abroadOrder;
@property(nonatomic,strong)NSString *actualDeliveryDate;
@property(nonatomic,strong)NSString *container;


@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *currency;
@property(nonatomic,strong)NSString *dealerName;


@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *loginName;


@property(nonatomic,strong)NSString *orderNo;
@property(nonatomic,strong)NSString *orderNote;
@property(nonatomic,strong)NSString *orderStatus;


@property(nonatomic,strong)NSString *orderStatusChildren;
@property(nonatomic,strong)NSString *orderTotalFee;
@property(nonatomic,strong)NSString *orderType;

@property(nonatomic,strong)NSString *paymentType;
@property(nonatomic,strong)NSString *planDeliveryDate;
@property(nonatomic,strong)NSString *productTotalFee;


//
@property(nonatomic,strong)NSString *partNo;
@property(nonatomic,strong)NSString *name;
//
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSString *file;
@property(nonatomic,strong)NSString *formalDate;
@property(nonatomic,strong)NSString *payStatus;
@property(nonatomic,strong)NSString *personCode;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *provinceName;
@property(nonatomic,strong)NSString *purchaseStockInCount;
@property(nonatomic,strong)NSString *realName;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *workstatus;
//
@property(nonatomic,strong)NSString *plateNumber;
@property(nonatomic,strong)NSString *planProductionDate;
//
@property(nonatomic,strong)NSString *supplierNo;
@property(nonatomic,strong)NSString *manual;
@property(nonatomic,strong)NSString *forkliftPerson;
@property(nonatomic,strong)NSString *sendTime;
@property(nonatomic,strong)NSString *forkliftPersonId;
//
@property(nonatomic,strong)NSString *confirmTime;
//
@property(nonatomic,strong)NSString *stencilNo;
@property(nonatomic,strong)NSString *stencilDesc;
@property(nonatomic,strong)NSDictionary *modelCraftType;
@property(nonatomic,strong)PaidanModel2 *modelCraftType_model;
//
@property(nonatomic,strong)NSDictionary *modelCraftStep;
@property(nonatomic,strong)PaidanModel2 *modelCraftStep_model;

@property(nonatomic,strong)NSDictionary *modelCraftProcedure;
@property(nonatomic,strong)PaidanModel2 *modelCraftProcedure_model;

@property(nonatomic,strong)NSString *personId;

@property(nonatomic,strong)NSString *purchaseOrderNo;




@property(nonatomic,strong)NSString *fieldType;

@property(nonatomic,strong)NSString *contactType;
@property(nonatomic,strong)NSString *supplierName;

@property(nonatomic,strong)NSString *equipmentNo;
@property(nonatomic,strong)NSString *equipmentName;
@property(nonatomic,strong)NSString *equipmentColor;



@property(nonatomic,strong)NSString *salaryMonth;
@property(nonatomic,strong)NSString *positionName;
@property(nonatomic,strong)NSString *departmentName;

@property(nonatomic,strong)NSString *actTotalResult;
@property(nonatomic,strong)NSString *performanceSalary;
@property(nonatomic,strong)NSString *performanceSalaryMonth;

@property(nonatomic,strong)NSString *type;

@property(nonatomic,strong)NSString *salary_total;
@property(nonatomic,strong)NSString *salary_type;

@property(nonatomic,strong)NSString *base_care_person;
@property(nonatomic,strong)NSString *pension_person;
@property(nonatomic,strong)NSString *unemployment_person;
@property(nonatomic,strong)NSString *base_care_company;
@property(nonatomic,strong)NSString *birth_company;
@property(nonatomic,strong)NSString *injury_company;
@property(nonatomic,strong)NSString *pension_company;
@property(nonatomic,strong)NSString *treatment_company;
@property(nonatomic,strong)NSString *unemployment_company;


@property(nonatomic,strong)NSString *salaryDayBase;
@property(nonatomic,strong)NSString *salaryDayDuty;
@property(nonatomic,strong)NSString *baseSalaryMonth;
@property(nonatomic,strong)NSString *postSalaryMonth;
@property(nonatomic,strong)NSString *workDay;
@end







//
//  PaiDanModel.h
//  Factory
//
//  Created by ilovedxracer on 2017/11/20.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaiDanModel.h"
#import "PaidanModel1.h"
#import "PaidanModel2.h"
@interface PaiDanModel : NSObject
@property(nonatomic,strong)NSString *companyId;
@property(nonatomic,strong)NSString *field1;
@property(nonatomic,strong)NSString *id;
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *orderNo;
@property(nonatomic,strong)NSString *planDate;
@property(nonatomic,strong)NSString *seq;
@property(nonatomic,strong)NSString *totalQuantity;

@property(nonatomic,strong)NSDictionary *order;
@property(nonatomic,strong)PaidanModel1 *oeder_model;

@property(nonatomic,strong)NSDictionary *purchasePlan;
@property(nonatomic,strong)PaidanModel2 *purchasePlan_model;



//
@property(nonatomic,strong)NSString *remark;
@property(nonatomic,strong)NSString *operator;
//
@property(nonatomic,strong)NSString *quantity;
@property(nonatomic,strong)NSDictionary *parts;
@property(nonatomic,strong)PaidanModel1 *parts_model;
//
@property(nonatomic,strong)NSString *productCode;
//
@property(nonatomic,strong)NSString *dealerName;
//
@property(nonatomic,strong)NSString *field4;
@property(nonatomic,strong)NSString *finishDate;
@property(nonatomic,strong)NSString *grabDate;
@property(nonatomic,strong)NSString *grabUser;
@property(nonatomic,strong)NSString *productionDate;
@property(nonatomic,strong)NSString *productionOrderNo;
@property(nonatomic,strong)NSString *resultCompanyName;
@property(nonatomic,strong)NSString *searchMaterialPerson;
@property(nonatomic,strong)NSString *searchMaterialScore;
@property(nonatomic,strong)NSString *searchMaterialStatus;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,strong)NSString *fcno;
//
@property(nonatomic,strong)NSString *craftName;
@property(nonatomic,strong)NSString *overtimePay;
@property(nonatomic,strong)NSString *unitPrice;
@property(nonatomic,strong)NSDictionary *person;
@property(nonatomic,strong)PaidanModel1 *person_model;
//
@property(nonatomic,strong)NSString *configName;
//
@property(nonatomic,strong)NSString *forkliftPerson;
@property(nonatomic,strong)NSString *receivePerson;
@property(nonatomic,strong)NSString *purchaseOrderNo;
@property(nonatomic,strong)NSString *stockInOrderNo;
@property(nonatomic,strong)NSString *stockInStatus;
@property(nonatomic,strong)NSString *stockInTime;
@property(nonatomic,strong)NSDictionary *purchaseOrder;
@property(nonatomic,strong)PaidanModel1 *purchaseOrder_model;
//
@property(nonatomic,strong)NSString *partNo;
//
@property(nonatomic,strong)NSString *locked_quantity;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *part_no;
@property(nonatomic,strong)NSString *picture;
@property(nonatomic,strong)NSString *usable_quantity;
@property(nonatomic,strong)NSString *max_storage_safe;
@property(nonatomic,strong)NSString *min_storage_safe;
//
@property(nonatomic,strong)NSString *consumablesNo;
@property(nonatomic,strong)NSString *createPersonName;
@property(nonatomic,strong)NSString *pickPersonName;
@property(nonatomic,strong)NSString *pickTime;
@property(nonatomic,strong)NSString *partName;

//
@property(nonatomic,strong)NSString *materialNo;
@property(nonatomic,strong)NSString *personName;
@property(nonatomic,strong)NSString *materialTime;
@property(nonatomic,strong)NSString *score;
@property(nonatomic,strong)NSString *outputTime;

//
@property(nonatomic,strong)NSString *productDate;
@property(nonatomic,strong)NSDictionary *receivePerson_ed;
@property(nonatomic,strong)PaidanModel1 *receivePerson_model;
@property(nonatomic,strong)NSDictionary *forkliftPerson_ed;
@property(nonatomic,strong)PaidanModel1 *forkliftPerson_model;
@property(nonatomic,strong)NSString *forkliftPersonId;

//
@property(nonatomic,strong)NSString *realName;
@property(nonatomic,strong)NSString *personCode;
//
@property(nonatomic,strong)NSString *location;
//
@property(nonatomic,strong)NSString *container;
@property(nonatomic,strong)NSString *orderStatus;
@property(nonatomic,strong)NSString *field7;
//
@property(nonatomic,strong)NSDictionary *purchasePaymentOrder;
@property(nonatomic,strong)PaidanModel1 *purchasePaymentOrder_model;
//
@property(nonatomic,strong)NSString *sku_no;
@property(nonatomic,strong)NSString *img_url;
//
@property(nonatomic,strong)NSDictionary *productSku;
@property(nonatomic,strong)PaidanModel1 *productSku_model;
@property(nonatomic,strong)NSString *productNameZh;

@property(nonatomic,strong)NSString *planDeliveryDate;
@property(nonatomic,strong)NSString *actualDeliveryDate;
//
@property(nonatomic,strong)NSString *holidayDay;
@property(nonatomic,strong)NSString *holidayWeek;
//
@property(nonatomic,strong)NSDictionary *modelCraftBomStencil;
@property(nonatomic,strong)PaidanModel1 *modelCraftBomStencil_model;
@property(nonatomic,strong)NSString *stencilDesc;
@property(nonatomic,strong)NSString *crafId;

//
@property(nonatomic,strong)NSDictionary *modelCraftBom;
@property(nonatomic,strong)PaidanModel1 *modelCraftBom_model;
@property(nonatomic,strong)NSDictionary *productionOrderPersonDetail;
@property(nonatomic,strong)PaidanModel1 *productionOrderPersonDetail_model;


//
@property(nonatomic,strong)NSString *purchasePlanNo;

@property(nonatomic,strong)NSArray *purchaseOrderList;


//
@property(nonatomic,strong)NSString *originalPurchaseOrderNo;
@property(nonatomic,strong)NSString *supplierNo;
@property(nonatomic,strong)NSString *planProductionDate;
@property(nonatomic,strong)NSString *sendTime;
@property(nonatomic,strong)NSString *plateNumber;
//
@property(nonatomic,strong)NSString *manual;
@property(nonatomic,strong)NSString *purchaseOrderType;
@property(nonatomic,strong)NSString *supplierPartNo;
//
@property(nonatomic,strong)NSString *exportNo;
@property(nonatomic,strong)NSString *planShipmentDate;
@property(nonatomic,strong)NSString *actualDate;
@property(nonatomic,strong)NSString *field8;
@property(nonatomic,strong)NSString *serviceCompanyName;
@property(nonatomic,strong)NSString *field15;
@property(nonatomic,strong)NSString *logistics;
@property(nonatomic,strong)NSString *cardNo;
@property(nonatomic,strong)NSString *field3;
@property(nonatomic,strong)NSString *shipmentNo;
//
@property(nonatomic,strong)NSString *storageNo;
@property(nonatomic,strong)NSString *pickOrderNo;
@property(nonatomic,strong)NSString *grabPersonName;
@property(nonatomic,strong)NSString *grabTime;
@property(nonatomic,strong)NSString *forkliftPersonName;
//
@property(nonatomic,strong)NSString *file;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *bqq;
@property(nonatomic,strong)NSString *enterpriseMailbox;


@property(nonatomic,strong)NSString *provinceName;
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSString *formalDate;
@property(nonatomic,strong)NSString *payStatus;


//
@property(nonatomic,strong)NSString *departmentName;
@property(nonatomic,strong)NSString *departmentCode;
@property(nonatomic,strong)NSString *positionName;

@property(nonatomic,strong)NSString *departmentId;
@property(nonatomic,strong)NSString *positionId;
@property(nonatomic,strong)NSString *enterDate;
@property(nonatomic,strong)NSString *idCard;



@property(nonatomic,strong)NSString *birthYear;
@property(nonatomic,strong)NSString *birthMonth;
@property(nonatomic,strong)NSString *birthDay;

@property(nonatomic,strong)NSString *graduationSchool;
@property(nonatomic,strong)NSString *graduationDate;
@property(nonatomic,strong)NSString *major;

@property(nonatomic,strong)NSString *education;
@property(nonatomic,strong)NSString *englishLevel;
@property(nonatomic,strong)NSString *historyCompany;


@property(nonatomic,strong)NSString *historyPosition;
@property(nonatomic,strong)NSString *marriage;
@property(nonatomic,strong)NSString *socialSecurityAccount;

@property(nonatomic,strong)NSString *accumulationFundAccount;
@property(nonatomic,strong)NSString *bankAccount;


@property(nonatomic,strong)NSDictionary *configCert;
@property(nonatomic,strong)PaidanModel1 *configCert_model;
@property(nonatomic,strong)NSString *fieldUrl;


@property(nonatomic,strong)NSDictionary *configContact;
@property(nonatomic,strong)PaidanModel1 *configContact_model;

@property(nonatomic,strong)NSString *startDate;
@property(nonatomic,strong)NSString *endDate;
@property(nonatomic,strong)NSString *code;


@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *district;
@property(nonatomic,strong)NSString *address;


@property(nonatomic,strong)NSString *dimissionTime;
@property(nonatomic,strong)NSString *contentType;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *contentReason;
@property(nonatomic,strong)NSString *isHire;
@property(nonatomic,strong)NSString *socialTime;
@property(nonatomic,strong)NSString *fundTime;
@property(nonatomic,strong)NSString *t_departmentPerson_status;

@property(nonatomic,strong)NSString *brand;
@property(nonatomic,strong)NSString *standard;
@property(nonatomic,strong)NSString *unit;
@property(nonatomic,strong)NSString *stock;


@property(nonatomic,strong)NSString *durable_type;
@property(nonatomic,strong)NSString *need_check;

@property(nonatomic,strong)NSString *model_s;
@property(nonatomic,strong)NSString *price;
@property(nonatomic,strong)NSString *goods_num;
@property(nonatomic,strong)NSString *serialNumber;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *goodsPicture;

@property(nonatomic,strong)NSString *itemPicture;
@property(nonatomic,strong)NSString *num;
@property(nonatomic,strong)NSString *takeTime;
@property(nonatomic,strong)NSString *takerName;
@property(nonatomic,strong)NSString *durableType;
@property(nonatomic,strong)NSString *finishTime;
@property(nonatomic,strong)NSString *goodsItemCode;


@property(nonatomic,strong)NSString *goodsItemId;
@property(nonatomic,strong)NSString *goodsId;
@property(nonatomic,strong)NSString *unitId;
@property(nonatomic,strong)NSString *businessId;
@property(nonatomic,strong)NSString *lastCheckTime;

@property(nonatomic,strong)NSString *needCheck;
@property(nonatomic,strong)NSString *field11;


@property(nonatomic,strong)NSString *subtotal;
@property(nonatomic,strong)NSString *totalPrice;




@property(nonatomic,strong)NSString *supplierCode;
@property(nonatomic,strong)NSString *supplierName;
@property(nonatomic,strong)NSString *supplierAddress;
@property(nonatomic,strong)NSString *supplierTel;
@property(nonatomic,strong)NSString *supplierConPerson;
@property(nonatomic,strong)NSString *supplierConPersonTel;

@property(nonatomic,strong)NSString *field2;
@property(nonatomic,strong)NSString *categoryName;



@property(nonatomic,strong)NSString *equipmentNo;
@property(nonatomic,strong)NSString *equipmentName;
@property(nonatomic,strong)NSString *equipmentColor;
@property(nonatomic,strong)NSString *equipmentCategoryId;
@property(nonatomic,strong)NSString *equipmentManager;
@property(nonatomic,strong)NSString *equipmentSupplierId;
@property(nonatomic,strong)NSString *equipmentUseTime;
@property(nonatomic,strong)NSString *equipmentStatus;

@property(nonatomic,strong)NSString *equipmentSupplier_s;

@property(nonatomic,strong)NSDictionary *equipmentSupplier;
@property(nonatomic,strong)PaidanModel1 *equipmentSupplier_model;


@property(nonatomic,strong)NSDictionary *departmentPerson;
@property(nonatomic,strong)PaidanModel1 *departmentPerson_model;


@property(nonatomic,strong)NSDictionary *equipmentCategory;
@property(nonatomic,strong)PaidanModel1 *equipmentCategory_model;

@property(nonatomic,strong)NSDictionary *equipment;
@property(nonatomic,strong)PaidanModel1 *equipment_model;

@property(nonatomic,strong)NSString *startTime;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *paymentStatus;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString *checkName;
@property(nonatomic,strong)NSString *total;
@property(nonatomic,strong)NSString *field5;
@property(nonatomic,strong)NSString *maintainNo;

@property(nonatomic,strong)NSString *mainContent;
@property(nonatomic,strong)NSString *cost;


@property(nonatomic,strong)NSDictionary *equipmentDetail;
@property(nonatomic,strong)PaidanModel1 *equipmentDetail_model;

@property(nonatomic,strong)NSString *username;


@property(nonatomic,strong)NSDictionary *card;
@property(nonatomic,strong)PaidanModel1 *card_model;


@property(nonatomic,strong)NSDictionary *departmentPersonSalay;
@property(nonatomic,strong)PaidanModel1 *departmentPersonSalay_model;

@property(nonatomic,strong)NSArray *detailList;


@property(nonatomic,strong)NSString *finish_date;
@property(nonatomic,strong)NSString *total_fee;
@property(nonatomic,strong)NSString *salaryMonth;

@property(nonatomic,strong)NSString *salaryDate;
@property(nonatomic,strong)NSString *salaryWeekday;
@property(nonatomic,strong)NSString *salaryType;
@property(nonatomic,strong)NSString *salary;

@property(nonatomic,strong)NSArray *detailJson;


@property(nonatomic,strong)NSString *planTotalFee;
@property(nonatomic,strong)NSString *actTotalFee;
@property(nonatomic,strong)NSString *tax;
@property(nonatomic,strong)NSString *accumulationFundPersosn;
@property(nonatomic,strong)NSString *accumulationFundCompany;

@property(nonatomic,strong)NSString *baseSalarySocialSecurity;

@property(nonatomic,strong)NSString *socialSecurityPerson;
@property(nonatomic,strong)NSString *socialSecurityCompany;



@property(nonatomic,strong)NSDictionary *socialSecurityPersonDetailMap;
@property(nonatomic,strong)PaidanModel1 *socialSecurityPersonDetailMap_model;

@property(nonatomic,strong)NSDictionary *socialSecurityCompanyDetailMap;
@property(nonatomic,strong)PaidanModel1 *socialSecurityCompanyDetailMap_model;




@property (nonatomic,assign) BOOL isSelect;
//@property (nonatomic,assign) NSInteger num;
@end

//"departmentTransferName" : "张强",
//"personnelTransferName" : "张强",
//"financialTransferName" : "张强",


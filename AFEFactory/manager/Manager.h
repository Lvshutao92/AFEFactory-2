//
//  Manager.h
//  Factory
//
//  Created by ilovedxracer on 2017/11/17.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

//首先导入头文件信息
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"


@interface Manager : NSObject


//声明单例方法
+ (Manager *)sharedManager;
//MD5加密
- (NSString *)md5:(NSString *)str;
//base加解密
+ (NSString*)encodeBase64String:(NSString*)input;
+ (NSString*)decodeBase64String:(NSString*)input;
+ (NSString*)encodeBase64Data:(NSData*)data;
+ (NSString*)decodeBase64Data:(NSData*)data;
//字典转json字符串
-(NSString *)convertToJsonData:(NSDictionary *)dict;
//金额转大写
+(NSString *)digitUppercase:(NSString *)numstr;
//存取数据
+ (void)writewenjianming:(NSString *)wenjianming content:(NSString *)content;
//读取数据
+ (NSString *)redingwenjianming:(NSString *)wenjianming;
//时间格式转化
+ (NSString *)timezhuanhuan:(NSString *)str;
//金额格式转换
+ (NSString *)jinegeshi:(NSString *)text;
+ (NSString *)usdjinegeshi:(NSString *)text;

+ (AFHTTPSessionManager *)returnsession;
+ (NSDictionary *)returndiction:(NSDictionary *)dic;
+ (NSDictionary *)returndictiondata:(NSData *)responseObject;

+ (UIButton *)returnButton;
+ (CGFloat )returnTiJi:(NSString *)longstr width:(NSString *)widthstr height:(NSString *)heightstr;
+ (NSString *)TimeCuoToTime:(NSString *)str;
+ (NSString *)TimeCuoToTimes:(NSString *)str;
//获取手机型号
- (NSString*)iphoneType;
//获取IP地址
- (NSString *)getIPAddress:(BOOL)preferIPv4;
//日期相减
+ (NSInteger)calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;

+ (UIImage *) imageFromURLString: (NSString *) urlstring;

@property(nonatomic,strong)NSMutableArray *Array1;
@property(nonatomic,strong)NSMutableArray *Array2;
@property(nonatomic,strong)NSString *PaiDanID;


@property(nonatomic,strong)NSString *orderid;
@property(nonatomic,strong)NSString *ids;
//存取person
@property(nonatomic,strong)NSDictionary *diction;


@property(nonatomic,assign)NSInteger searchIndex;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)NSInteger index_xh;
@property(nonatomic,assign)NSInteger index_sh;

@property(nonatomic,assign)NSInteger index_renshi;
@property(nonatomic,assign)NSInteger index_wupin;
@property(nonatomic,assign)NSInteger index_caigou;

@property(nonatomic,assign)NSInteger index_guonei;
@property(nonatomic,assign)NSInteger index_guowai;


@property(nonatomic,strong)NSMutableArray *wplyArr;
+(NSString*)getCurrentTimes;



@end

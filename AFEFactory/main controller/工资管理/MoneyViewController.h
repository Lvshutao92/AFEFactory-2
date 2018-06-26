//
//  MoneyViewController.h
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/10.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SecondeViewControllerChartType) {
    SecondeViewControllerChartTypeColumn =0,
    SecondeViewControllerChartTypeBar,
    SecondeViewControllerChartTypeArea,
    SecondeViewControllerChartTypeAreaspline,
    SecondeViewControllerChartTypeLine,
    SecondeViewControllerChartTypeSpline,
    SecondeViewControllerChartTypeScatter,
};

@interface MoneyViewController : UIViewController

@property (nonatomic, assign) SecondeViewControllerChartType chartType;
@property (nonatomic, copy  ) NSString  *receivedChartType;

@end

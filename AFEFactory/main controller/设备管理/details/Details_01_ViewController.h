//
//  Details_01_ViewController.h
//  AFEFactory
//
//  Created by ilovedxracer on 2018/1/24.
//  Copyright © 2018年 ilovedxracer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Details_01_ViewController : UIViewController<UIScrollViewDelegate>
{
    NSArray  *_JGVCAry;
    NSArray  *_JGTitleAry;
    UIView   *_JGLineView;
    UIScrollView *_MeScroolView;
}
- (instancetype)initWithAddVCARY:(NSArray*)VCS TitleS:(NSArray*)TitleS;

@end

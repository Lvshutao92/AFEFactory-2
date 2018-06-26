//
//  LookPictureViewController.m
//  DXRacerPCS
//
//  Created by ilovedxracer on 2017/7/26.
//  Copyright © 2017年 ilovedxracer. All rights reserved.
//

#import "LookPictureViewController.h"

@interface LookPictureViewController ()

@end

@implementation LookPictureViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"图片预览";
   
    
    NSLog(@"img =====%@",NSString(self.imgStr));
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    dispatch_async(dispatch_get_main_queue(), ^{
        [imageview sd_setImageWithURL:[NSURL URLWithString:NSString(self.imgStr)]];
    });
    imageview.contentMode = UIViewContentModeScaleAspectFit;
    imageview.userInteractionEnabled = YES;
    [self.view addSubview:imageview];
    
    
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)];
    [imageview addGestureRecognizer:pinchGestureRecognizer];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [imageview addGestureRecognizer:panGestureRecognizer];
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotateView:)];
    [imageview addGestureRecognizer:rotationGestureRecognizer];
    
    
}


- (void) rotateView:(UIRotationGestureRecognizer *)rotationGestureRecognizer
{
    UIView *view = rotationGestureRecognizer.view;
    if (rotationGestureRecognizer.state == UIGestureRecognizerStateBegan || rotationGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        view.transform = CGAffineTransformRotate(view.transform, rotationGestureRecognizer.rotation);
        [rotationGestureRecognizer setRotation:0];
    }
}
- (void) pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer

{
    UIView *view = pinchGestureRecognizer.view;
    if (pinchGestureRecognizer.state == UIGestureRecognizerStateBegan || pinchGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);          pinchGestureRecognizer.scale = 1;
    }
}

- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [panGestureRecognizer translationInView:view.superview];
        [view setCenter:(CGPoint){view.center.x + translation.x, view.center.y + translation.y}];
        [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
    }
}


@end

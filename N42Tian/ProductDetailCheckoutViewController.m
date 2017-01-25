//
//  ProductDetailCheckoutViewController.m
//  N42Tian
//
//  Created by apple on 22/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "ProductDetailCheckoutViewController.h"
#import "ProductDetailViewController.h"
#import "BackgroundView.h"

@interface ProductDetailCheckoutViewController ()

@end

@implementation ProductDetailCheckoutViewController
{
    UIView *_backgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ProductDetailViewController * controller = [[ProductDetailViewController alloc] init];
    self.view.frame = CGRectMake(0, 0, controller.view.bounds.size.width, controller.view.bounds.size.height);
    
    _productImageView.image = [UIImage imageNamed:@"1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self dismissFromParentViewController];
}

- (IBAction)smallModel:(id)sender {
}

- (IBAction)bigModel:(id)sender {
}

- (IBAction)addQty:(id)sender {
}

- (IBAction)minusQty:(id)sender {
}

- (void)presentInParentViewController:(UIViewController *)parentViewController
{
    _backgroundView = [[BackgroundView alloc] initWithFrame:parentViewController.view.bounds];
    [parentViewController.view addSubview:_backgroundView];
    
    self.view.frame = parentViewController.view.bounds;
    [parentViewController.view addSubview:self.view];
    [parentViewController addChildViewController:self];
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.duration = 0.4;
    moveAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height * 1.5)];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2)];
//    moveAnimation.delegate = self;
    [self.view.layer addAnimation:moveAnimation forKey:@"moveAnimation"];
    
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = @0.0f;
    fadeAnimation.toValue = @1.0f;
    fadeAnimation.duration = 0.3;
    [_backgroundView.layer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
}

- (void)dismissFromParentViewController
{
    [self willMoveToParentViewController:nil];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect = self.view.bounds;
        rect.origin.y += rect.size.height;
        self.view.frame = rect;
        _backgroundView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        
        [_backgroundView removeFromSuperview];
    }];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self didMoveToParentViewController:self.parentViewController];
}

@end

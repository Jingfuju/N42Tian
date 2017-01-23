//
//  ProductDetailCheckoutViewController.m
//  N42Tian
//
//  Created by apple on 22/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "ProductDetailCheckoutViewController.h"
#import "ProductDetailViewController.h"

@interface ProductDetailCheckoutViewController ()

@end

@implementation ProductDetailCheckoutViewController

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
    [self willMoveToParentViewController:nil];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}
@end

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
#import "HomeViewController.h"

@interface ProductDetailCheckoutViewController () <UIGestureRecognizerDelegate, UITextFieldDelegate>

@end

@implementation ProductDetailCheckoutViewController
{
    UIView *_backgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HomeViewController *hvController = [sb instantiateViewControllerWithIdentifier:@"HomeViewController"];
    self.managedObjectContext = hvController.managedObjectContext;
    
    ProductDetailViewController * controller = [[ProductDetailViewController alloc] init];
    self.view.frame = CGRectMake(0, 0, controller.view.bounds.size.width, controller.view.bounds.size.height);
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    gestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:gestureRecognizer];
    
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
    [self addOneMore];
}

- (void)addOneMore
{
    
}

- (IBAction)minusQty:(id)sender {
}

- (IBAction)setQty:(id)sender {
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

#pragma mark - gestureRecognizer delegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return (touch.view == self.view);
}

#pragma mark - UITextFieldDelegate

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    _productQty = textField;
//    return YES;
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
    
}

#pragma mark - keyboard Appear just below the textField

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHidden) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardFrame.origin.y;
    
    CGFloat textFieldBottomY = _productQty.frame.origin.y + _productQty.frame.size.height +  _productQty.superview.frame.origin.y;
    CGRect frame = self.view.frame;
    CGFloat newY = frame.origin.y + height - textFieldBottomY;

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:CGRectMake(0, newY, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (void)keyboardDidHidden
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end

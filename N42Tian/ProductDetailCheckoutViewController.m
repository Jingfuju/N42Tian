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
#import "ProductInfo.h"
#import "ProductInfoItem.h"
#import "CartProductInfo+CoreDataClass.h"

@interface ProductDetailCheckoutViewController () <UIGestureRecognizerDelegate, UITextFieldDelegate>

@end

@implementation ProductDetailCheckoutViewController
{
    UIView *_backgroundView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ProductDetailViewController * controller = [[ProductDetailViewController alloc] init];
    self.view.frame = CGRectMake(0, 0, controller.view.bounds.size.width, controller.view.bounds.size.height);
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    gestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:gestureRecognizer];

    [self loadDataWithIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadDataWithIndex
{
    ProductInfo *productInfo = [[ProductInfo alloc]init];
    ProductInfoItem *item = productInfo.items[self.productIndex];
    self.productName.text = item.productName;
    self.productImageView.image = [UIImage imageNamed:item.productImageName];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencySymbol:@"$"];
    
    self.productPrice.text = [numberFormatter stringFromNumber:item.productPrice];
    
    NSString *qty = [self getCartProductQty:item];
    self.productQty.text = qty;
    NSDecimalNumber * DNqty = [NSDecimalNumber decimalNumberWithString:qty];
    NSDecimalNumber * subtotal = [DNqty decimalNumberByMultiplyingBy:item.productPrice];
    
    self.productSubtotal.text = [numberFormatter stringFromNumber:subtotal];
}

- (NSString *)getCartProductQty:(ProductInfoItem *)item
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CartProductInfo" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", item.productName];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if ((request != nil) && ([result count]) && (error == nil)) {
        CartProductInfo *info = [result objectAtIndex:0];
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error: %@", error);
            abort();
        }
        return [NSString stringWithFormat:@"%d", info.quantity];
    } else {
        return @"0";
    }
}

- (IBAction)close:(id)sender {
    [self dismissFromParentViewController];
}

- (IBAction)smallModel:(id)sender {
    // add code for model choose
}

- (IBAction)bigModel:(id)sender {
    // add code for model choose
}

- (IBAction)addQty:(id)sender {
     ProductInfo *productInfo = [[ProductInfo alloc]init];
    [self addOneMore:productInfo.items[self.productIndex]];
}

- (void)addOneMore:(ProductInfoItem *)item
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CartProductInfo" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name == %@", item.productName];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if ((result != nil) && ([result count]) && (error == nil)) {
        CartProductInfo *info = [result objectAtIndex:0];
        info.quantity +=1;
        self.productQty.text = [NSString stringWithFormat:@"%hd", info.quantity];
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error: %@", error); abort();
        }
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setCurrencySymbol:@"$"];
        
        NSDecimalNumber * DNqty = [NSDecimalNumber decimalNumberWithString:self.productQty.text];
        NSDecimalNumber * subtotal = [DNqty decimalNumberByMultiplyingBy:item.productPrice];
        
        self.productSubtotal.text = [numberFormatter stringFromNumber:subtotal];
        return;
    } else {
        CartProductInfo *cartItem = [NSEntityDescription insertNewObjectForEntityForName:@"CartProductInfo" inManagedObjectContext:self.managedObjectContext];
        cartItem.name = item.productName;
        cartItem.quantity = 1;
        cartItem.price = [item.productPrice doubleValue]; //double to double
        cartItem.productImage = item.productImageName;
        self.productQty.text = @"1";
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error: %@", error);
            abort();
        }
        self.productSubtotal.text = self.productPrice.text;
    }
    return;
}

- (IBAction)minusQty:(id)sender {
    ProductInfo *productInfo = [[ProductInfo alloc]init];
    [self removeOneMore:productInfo.items[self.productIndex]];
}

- (void)removeOneMore:(ProductInfoItem *)item
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CartProductInfo" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name == %@", item.productName];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if ((result != nil) && ([result count]) && (error == nil)) {
        CartProductInfo *info = [result objectAtIndex:0];
        if (info.quantity >= 2) {
            info.quantity -= 1;
            self.productQty.text = [NSString stringWithFormat:@"%hd", info.quantity];
            
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
            [numberFormatter setCurrencySymbol:@"$"];
            
            NSDecimalNumber * DNqty = [NSDecimalNumber decimalNumberWithString:self.productQty.text];
            NSDecimalNumber * subtotal = [DNqty decimalNumberByMultiplyingBy:item.productPrice];
            self.productSubtotal.text = [numberFormatter stringFromNumber:subtotal];
        } else if (info.quantity == 1) {
            [self.managedObjectContext deleteObject:info];
            self.productQty.text = @"0";
            self.productSubtotal.text = self.productQty.text;
        }
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error: %@", error); abort();
        }
        return;
    } else {
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error: %@", error);
            abort();
        }
        self.productQty.text = @"0";
        self.productSubtotal.text = self.productQty.text;
        return;
    }
}

- (void)saveToCoreData
{
    NSError *error;
    if(![self.managedObjectContext save:&error]) {
        NSLog(@"FATAL_CORE_DATA_ERROR");
        abort();
    }
}

- (IBAction)setQty:(id)sender {
    ProductInfo *productInfo = [[ProductInfo alloc]init];
    [self setQuantity:productInfo.items[self.productIndex]];
    
}

- (void)setQuantity:(ProductInfoItem *)item
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CartProductInfo" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name == %@", item.productName];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if ((result != nil) && ([result count]) && (error == nil)) {
        CartProductInfo *info = [result objectAtIndex:0];
        info.quantity = [self.productQty.text intValue];
        self.productQty.text = [NSString stringWithFormat:@"%hd", info.quantity];
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error: %@", error); abort();
        }
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setCurrencySymbol:@"$"];
        
        NSDecimalNumber * DNqty = [NSDecimalNumber decimalNumberWithString:self.productQty.text];
        NSDecimalNumber * subtotal = [DNqty decimalNumberByMultiplyingBy:item.productPrice];
        
        self.productSubtotal.text = [numberFormatter stringFromNumber:subtotal];
        return;
    } else {
        CartProductInfo *cartItem = [NSEntityDescription insertNewObjectForEntityForName:@"CartProductInfo" inManagedObjectContext:self.managedObjectContext];
        cartItem.name = item.productName;
        cartItem.quantity = [self.productQty.text intValue];
        cartItem.price = [item.productPrice doubleValue]; //double to double
        cartItem.productImage = item.productImageName;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error: %@", error);
            abort();
        }
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setCurrencySymbol:@"$"];
        
        NSDecimalNumber * DNqty = [NSDecimalNumber decimalNumberWithString:self.productQty.text];
        NSDecimalNumber * subtotal = [DNqty decimalNumberByMultiplyingBy:item.productPrice];
        
        self.productSubtotal.text = [numberFormatter stringFromNumber:subtotal];
        return;
    }
}


- (void)presentInParentViewController:(UIViewController *)parentViewController
{
    _backgroundView = [[BackgroundView alloc] initWithFrame:parentViewController.view.bounds];
    [parentViewController.view addSubview:_backgroundView];
    
    self.view.frame = parentViewController.view.bounds;
    [parentViewController.view addSubview:self.view];
    [parentViewController addChildViewController:self];
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];               // setup the animation for the write coler view
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
    NSLog(@"%f", frame.origin.y);
    CGFloat newY = 0 + height - textFieldBottomY;

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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//
//- (void)keyboardWillShow:(NSNotification *)notification
//{
//    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGFloat height = keyboardFrame.origin.y;
//    CGFloat textFieldBottomY = _productQty.frame.origin.y + _productQty.frame.size.height;
//    CGRect frame = self.view.frame;
//    frame.origin.y = self.view.frame.origin.y - height + self.view.frame.size.height - textFieldBottomY;
//}
//
//- (void)keyboardWillHide:(NSNotification *)notification
//{
//    CGRect frame = self.view.frame;
//    frame.origin.y = 0;
//    self.view.frame = frame;
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

@end

//
//  ProductDetailCheckoutViewController.h
//  N42Tian
//
//  Created by apple on 22/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductInfo;

@interface ProductDetailCheckoutViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UITextField *productQty;
@property (weak, nonatomic) IBOutlet UILabel *productSubtotal;

- (IBAction)close:(id)sender;
- (IBAction)smallModel:(id)sender;
- (IBAction)bigModel:(id)sender;
- (IBAction)addQty:(id)sender;
- (IBAction)minusQty:(id)sender;
- (IBAction)setQty:(id)sender;
- (IBAction)continue:(id)sender;

- (void)presentInParentViewController:(UIViewController *)parentViewController;
- (void)dismissFromParentViewController;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property NSInteger productIndex;

@end

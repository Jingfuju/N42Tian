//
//  ProductDetailViewController.h
//  N42Tian
//
//  Created by apple on 18/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *smallScrollView;
@property (nonatomic, strong) IBOutlet UIScrollView *bigScrollView;
@property NSInteger productIndex;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;



- (IBAction)close:(id)sender;
- (IBAction)addToCart:(id)sender;
- (IBAction)goToCart:(id)sender;

@end

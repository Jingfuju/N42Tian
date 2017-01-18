//
//  ProductDetailViewController.h
//  N42Tian
//
//  Created by apple on 17/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UINavigationBarDelegate>

- (IBAction)cancel:(id)sender;
- (IBAction)quantityPicker:(id)sender;

@end

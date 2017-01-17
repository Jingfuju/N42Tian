//
//  SecondViewController.h
//  N42Tian
//
//  Created by Jingfu Ju on 1/11/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartTableViewCell.h"

@class CartViewController;
@protocol CartViewControllerDelegate <NSObject>

-(void)updateCartQuantityfrom:(CartViewController *)controller atIndexPath:(NSIndexPath *)indexPath;

@end


@interface CartViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CartTableViewCellDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, weak) id <CartViewControllerDelegate> delegate;

@end


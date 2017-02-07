//
//  SecondViewController.h
//  N42Tian
//
//  Created by Jingfu Ju on 1/11/17.
//  Copyright © 2017 N42Tian. All rights reserved.

// This file is not exactly same with CartViewController
//

#import <UIKit/UIKit.h>
#import "CartTableViewCell.h"
#import "CartProductInfo+CoreDataClass.h"
#import "QuantityPickerViewController.h"

@interface CartMirrorController : UIViewController <UITableViewDelegate, UITableViewDataSource, CartTableViewCellDelegate, UINavigationBarDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) IBOutlet UIToolbar *cartToolbar;
@property (nonatomic, weak) NSIndexPath *indexMentioned;
@property (nonatomic, weak) IBOutlet UIView *emptyCartView;
@property (nonatomic, weak) IBOutlet UILabel *totalPrice;
@property (nonatomic, weak) IBOutlet UILabel *totalQty;



//Added this method to header file, use other Controller involve it;
- (NSFetchedResultsController *) fetchedResultsController;
- (IBAction)checkout:(id)sender;
- (IBAction)close:(id)sender;

@end
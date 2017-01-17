//
//  SecondViewController.h
//  N42Tian
//
//  Created by Jingfu Ju on 1/11/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartTableViewCell.h"
#import "CartProductInfo+CoreDataClass.h"
#import "QuantityPickerViewController.h"

@interface CartViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CartTableViewCellDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

//Added this method to header file, use other Controller involve it;
-(NSFetchedResultsController *) fetchedResultsController;

@end


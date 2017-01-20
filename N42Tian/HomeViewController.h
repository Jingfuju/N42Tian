//
//  FirstViewController.h
//  N42Tian
//
//  Created by Jingfu Ju on 1/11/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductTableViewCell.h"

extern NSString * const ManagedObjectContextSaveDidFailNotification;

//#define FATAL_CORE_DATA_ERROR(__error__) \
//    NSLog(@"*** Fatal error in %s:%d\n%@\n%@",\
//        __FILE__, __LINE__, error, [error userInfo]);\
//        [[NSNotificationCenter defaultCenter] postNotificationName:\
//            ManagedObjectContextSaveDidFailNotification object:error];

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ProductTableViewCellDelegate, UINavigationBarDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


@end


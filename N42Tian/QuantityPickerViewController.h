//
//  QuantityPickerViewController.h
//  N42Tian
//
//  Created by Jingfu Ju on 1/17/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartViewController.h"

@class QuantityPickerViewController;
@protocol QuantityPickerViewControllerDelegate <NSObject>

-(void)updateQuantityFrom:(QuantityPickerViewController *)controller atIndexPath:(NSIndexPath *)NSIndexPath withNumber:(NSString *)quantity;

@end


@interface QuantityPickerViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, copy) NSIndexPath *indexPath;
@property (nonatomic, weak) id <QuantityPickerViewControllerDelegate> delegate;

-(IBAction)close:(id)sender;
-(IBAction)done:(id)sender;

@end

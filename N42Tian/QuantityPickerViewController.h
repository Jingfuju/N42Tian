//
//  QuantityPickerViewController.h
//  N42Tian
//
//  Created by Jingfu Ju on 1/17/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartViewController.h"

@interface QuantityPickerViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,CartTableViewCellDelegate>

@property (nonatomic, assign) NSInteger quantity;

-(IBAction)close:(id)sender;
-(IBAction)done:(id)sender;

@end

//
//  CartTableViewCell.h
//  N42Tian
//
//  Created by apple on 13/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cartImageView;
@property (weak, nonatomic) IBOutlet UILabel *cartItemName;
@property (weak, nonatomic) IBOutlet UILabel *cartItemPrice;
@property (weak, nonatomic) IBOutlet UILabel *cartSubTotalPrice;
@property (weak, nonatomic) IBOutlet UIButton *cartSubTotalQty;

- (IBAction)cartAddQty:(id)sender;
- (IBAction)cartMinusQty:(id)sender;

@end

//
//  CartTableViewCell.h
//  N42Tian
//
//  Created by apple on 13/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CartTableViewCell;
@protocol CartTableViewCellDelegate <NSObject>

-(void)addOneMore:(CartTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(void)removeOneMore:(CartTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(NSIndexPath *)getButtonIndexPath:(UIButton *) button;

@end

@interface CartTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cartImageView;
@property (weak, nonatomic) IBOutlet UILabel *cartItemName;
@property (weak, nonatomic) IBOutlet UILabel *cartItemPrice;
@property (weak, nonatomic) IBOutlet UILabel *cartSubTotalPrice;
@property (weak, nonatomic) IBOutlet UIButton *cartSubTotalQty;
@property (weak, nonatomic) IBOutlet UILabel *quantityLabel;


@property (weak,nonatomic) id <CartTableViewCellDelegate> delegate;

- (IBAction)cartAddQty:(id)sender;
- (IBAction)cartMinusQty:(id)sender;

@end

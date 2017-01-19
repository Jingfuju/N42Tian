//
//  ProductTableViewCell.h
//  N42Tian
//
//  Created by apple on 11/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ProductTableViewCell;

@protocol ProductTableViewCellDelegate <NSObject>

-(void)addToCart:(ProductTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
-(NSIndexPath *)getButtonIndexPath:(UIButton *) button;

@end



@interface ProductTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *productName;
@property (nonatomic, weak) IBOutlet UILabel *productPrice;
@property (nonatomic, weak) IBOutlet UIImageView *productImage;
@property (nonatomic, weak) IBOutlet UILabel *productSpec;
@property (nonatomic, weak) IBOutlet UILabel *productSales;

-(IBAction)addToCartButton:(id)sender;

@property (nonatomic, weak) id <ProductTableViewCellDelegate> delegate;

@end

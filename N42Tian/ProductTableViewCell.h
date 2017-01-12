//
//  ProductTableViewCell.h
//  N42Tian
//
//  Created by apple on 11/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *productName;
@property (nonatomic, weak) IBOutlet UILabel *productPrice;
@property (nonatomic, weak) IBOutlet UIImageView *productImage;
@property (nonatomic, weak) IBOutlet UIButton *addToCartButton;

@end

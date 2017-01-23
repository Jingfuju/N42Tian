//
//  ProductDetailTableViewCell.h
//  N42Tian
//
//  Created by apple on 21/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailTableViewCell : UITableViewCell <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productSpec;
@property (weak, nonatomic) IBOutlet UILabel *productSales;
@property (weak, nonatomic) IBOutlet UILabel *productInStore;
@property (weak, nonatomic) IBOutlet UILabel *productDescription;


+ (instancetype)productDetailTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
+ (CGFloat)productDetailTableViewCellWith:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
+ (NSInteger)productDetailTableViewCellCount;

@end

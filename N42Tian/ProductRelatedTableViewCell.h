//
//  ProductRelatedTableViewCell.h
//  N42Tian
//
//  Created by apple on 21/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductRelatedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *productRelatedImage;

+ (instancetype)productRelatedTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end

//
//  ProductReviewTableViewCell.m
//  N42Tian
//
//  Created by apple on 21/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "ProductReviewTableViewCell.h"

@implementation ProductReviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)productReviewTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    ProductReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productReviewTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductReviewTableViewCell" owner:self options:nil] firstObject];
    }
    return cell;
}

@end

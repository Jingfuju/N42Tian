//
//  ProductRelatedTableViewCell.m
//  N42Tian
//
//  Created by apple on 21/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "ProductRelatedTableViewCell.h"

@implementation ProductRelatedTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)productRelatedTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    ProductRelatedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"productRelatedTableViewCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductRelatedTableViewCell" owner:self options:nil] firstObject];
    }
    return cell;
}

@end

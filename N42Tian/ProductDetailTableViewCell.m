//
//  ProductDetailTableViewCell.m
//  N42Tian
//
//  Created by apple on 21/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "ProductDetailTableViewCell.h"

@interface ProductDetailTableViewCell ()

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@end

@implementation ProductDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width * 3, self.scrollView.bounds.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - static method

+ (instancetype)productDetailTableViewCellWith:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = @"";
    NSInteger index = 0;
    switch (indexPath.row) {
        case 0:
            identifier = @"productDetailTableViewCellFirst";
            index = 0;
            break;
        case 1:
            identifier = @"productDetailTableViewCellSecond";
            index = 1;
            break;
        case 2:
            identifier = @"productDetailTableViewCellThird";
            index = 2;
            break;
        default:
            break;
    }
    ProductDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailTableViewCell" owner:self options:nil] objectAtIndex:index];
    }
    return cell;
}

@end

//
//  ProductInfoViewController.m
//  N42Tian
//
//  Created by apple on 18/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "ProductInfoViewController.h"
#import "ProductDetailTableViewCell.h"
#import "ProductRelatedTableViewCell.h"
#import "ProductReviewTableViewCell.h"
#import "ProductInfo.h"
#import "ProductInfoItem.h"

@interface ProductInfoViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProductInfoViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(-36, 0, 0, 0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UITableView Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductInfo *productInfo = [[ProductInfo alloc]init];
    if (_index == 0) {
        NSLog(@"index Path is %ld",indexPath.row);
        ProductDetailTableViewCell *cell = [ProductDetailTableViewCell productDetailTableViewCellWith:tableView indexPath:indexPath];
        ProductInfoItem *item = productInfo.items[_productIndex];
        cell.productName.text = item.productName;
        NSDecimalNumber *itemPrice = item.productPrice;
        cell.productPrice.text = [itemPrice stringValue];
        return cell;
    } else if (_index == 1) {
        ProductRelatedTableViewCell *cell= [ProductRelatedTableViewCell productRelatedTableViewCellWith:tableView indexPath:indexPath];
        ProductInfoItem *item = productInfo.items[_productIndex];
        cell.productRelatedImage.image = [UIImage imageNamed:item.productImageName];
        return cell;
    } else {
        ProductReviewTableViewCell *cell = [ProductReviewTableViewCell productReviewTableViewCellWith:tableView indexPath:indexPath];
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_index) {
        case 0:
            return [ProductDetailTableViewCell productDetailTableViewCellCount];
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (_index) {
        case 0:
            return [ProductDetailTableViewCell productDetailTableViewCellWith:tableView heightForRowAtIndexPath:indexPath];
            break;
        case 1:
            return 300.f;
            break;
        case 2:
            return 80.f;
            break;
        default:
            break;
    }
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end

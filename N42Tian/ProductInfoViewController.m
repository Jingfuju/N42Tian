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
#import "productInfo.h"

@interface ProductInfoViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProductInfoViewController
{
    NSMutableArray *_productInfos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addProductInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addProductInfo
{
    _productInfos = [[NSMutableArray alloc] initWithCapacity:10];
    ProductInfo *item;
    item = [[ProductInfo alloc] init];
    item.productName = @"Millet1100g";
    item.productPrice = 55.0;
    item.productImageName = @"1";
    [_productInfos addObject:item];
    
    item = [[ProductInfo alloc] init];
    item.productName = @"Millet2200g";
    item.productPrice = 100.0;
    item.productImageName = @"2";
    [_productInfos addObject:item];
    
    item = [[ProductInfo alloc] init];
    item.productName = @"Millet3300g";
    item.productPrice = 150.0;
    item.productImageName = @"3";
    [_productInfos addObject:item];
}

#pragma mark - UITableView Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_index == 0) {
        ProductDetailTableViewCell *cell = [ProductDetailTableViewCell productDetailTableViewCellWith:tableView indexPath:indexPath];
        ProductInfo *item = _productInfos[_productIndex];
        cell.productName.text = item.productName;
        NSNumber *itemPrice = [NSNumber numberWithDouble:item.productPrice];
        cell.productPrice.text = [itemPrice stringValue];
        return cell;
    } else if (_index == 1) {
        ProductRelatedTableViewCell *cell= [ProductRelatedTableViewCell productRelatedTableViewCellWith:tableView indexPath:indexPath];
        ProductInfo *item = _productInfos[_productIndex];
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

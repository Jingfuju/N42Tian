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

@interface ProductInfoViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ProductInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_index == 0) {
        ProductDetailTableViewCell *cell = [ProductDetailTableViewCell productDetailTableViewCellWith:tableView indexPath:indexPath];
        return cell;
    } else if (_index == 1) {
        ProductRelatedTableViewCell *cell= [ProductRelatedTableViewCell productRelatedTableViewCellWith:tableView indexPath:indexPath];
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

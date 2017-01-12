//
//  FirstViewController.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/11/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "HomeViewController.h"
#import "ProductTableViewCell.h"
#import "productInfo.h"

static NSString * const ProductTableViewCellIdentifier = @"ProductTableViewCell";

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *productTableView;

@end

@implementation HomeViewController
{
    NSMutableArray *_productInfos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.productTableView.rowHeight = 200;
    
    UINib *cellNib = [UINib nibWithNibName:ProductTableViewCellIdentifier bundle:nil];
    [self.productTableView registerNib:cellNib forCellReuseIdentifier:ProductTableViewCellIdentifier];
    
    _productInfos = [[NSMutableArray alloc] initWithCapacity:10];
    productInfo *item;
    item = [[productInfo alloc] init];
    item.productName = @"millet1100g";
    item.productPrice = [NSDecimalNumber decimalNumberWithString:@"55.0"];
    item.productImageName = @"1";
    [_productInfos addObject:item];
    
    item = [[productInfo alloc] init];
    item.productName = @"millet2200g";
    item.productPrice = [NSDecimalNumber decimalNumberWithString:@"100.0"];
    item.productImageName = @"2";
    [_productInfos addObject:item];
    
    item = [[productInfo alloc] init];
    item.productName = @"millet3300g";
    item.productPrice = [NSDecimalNumber decimalNumberWithString:@"150.0"];
    item.productImageName = @"3";
    [_productInfos addObject:item];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductTableViewCellIdentifier];
    productInfo *item = _productInfos[indexPath.row];
    
    cell.productName.text = item.productName;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    cell.productPrice.text = [formatter stringFromNumber:item.productPrice];
    cell.productImage.image = [UIImage imageNamed:item.productImageName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

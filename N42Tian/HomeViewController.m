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
#import "ProductDetailViewController.h"
#import "CartProductInfo+CoreDataClass.h"


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
    
    UIImage* cartTabImage = [UIImage imageNamed:@"Cart"];
    [[self.tabBarController.tabBar.items objectAtIndex:2] setImage:cartTabImage];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductTableViewCellIdentifier];
    ProductInfo *item = _productInfos[indexPath.row];
    cell.delegate = self;   //ProductTableViewCell Delegate Definition
    
    cell.productName.text = item.productName;
    NSNumber *itemPrice = [NSNumber numberWithDouble:item.productPrice];
    cell.productPrice.text = [itemPrice stringValue];
    cell.productImage.image = [UIImage imageNamed:item.productImageName];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    controller.productIndex = indexPath.row;  // pass the cell index to ProductDetailViewController
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - ProductTableViewCell Delegate
-(void)addToCart:(ProductTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ProductInfo *item = _productInfos[indexPath.row];
    [self editCartForProduct:item];
    return;
}

-(void)editCartForProduct:(ProductInfo *)item {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CartProductInfo" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat: @"name == %@", item.productName];
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if ((result != nil) && ([result count]) && (error == nil)) {
        CartProductInfo *info = [result objectAtIndex:0];
        info.quantity +=1;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error: %@", error); abort();
        }
        return;
    } else {
        CartProductInfo *cartItem = [NSEntityDescription insertNewObjectForEntityForName:@"CartProductInfo" inManagedObjectContext:self.managedObjectContext];
        cartItem.name = item.productName;
        cartItem.quantity = 1;
        cartItem.price = item.productPrice; //double to double
        cartItem.productImage = item.productImageName;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error: %@", error);
            abort();
        }
    }
}


-(NSIndexPath *)getButtonIndexPath:(UIButton *) button {
    CGRect buttonFrame = [button convertRect:button.bounds toView:self.productTableView];
    return [self.productTableView indexPathForRowAtPoint:buttonFrame.origin];
}

#pragma mark - UINavigation bar delegate 
-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    NSLog(@"********  Personal Debug Info Below  ***********");
    return UIBarPositionTopAttached;
}

@end

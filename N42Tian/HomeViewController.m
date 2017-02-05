//
//  HomeViewController.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/11/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "HomeViewController.h"
#import "ProductTableViewCell.h"
#import "ProductInfo.h"
#import "ProductInfoItem.h"
#import "ProductDetailViewController.h"
#import "CartProductInfo+CoreDataClass.h"


static NSString * const ProductTableViewCellIdentifier = @"ProductTableViewCell";



@interface HomeViewController () 

@property (weak, nonatomic) IBOutlet UITableView *productTableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.productTableView.rowHeight = 200;
    self.title = @"Home";
    UINib *cellNib = [UINib nibWithNibName:ProductTableViewCellIdentifier bundle:nil];
    [self.productTableView registerNib:cellNib forCellReuseIdentifier:ProductTableViewCellIdentifier];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ProductInfo *productInfo = [[ProductInfo alloc]init];
    return [productInfo.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProductInfo *productInfo = [[ProductInfo alloc]init];
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductTableViewCellIdentifier];
    ProductInfoItem *item = productInfo.items[indexPath.row];
    cell.delegate = self;   //ProductTableViewCell Delegate Definition
    
    cell.productName.text = item.productName;
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencySymbol:@"$"];

    cell.productPrice.text = [numberFormatter stringFromNumber:item.productPrice];
    cell.productImage.image = [UIImage imageNamed:item.productImageName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    controller.productIndex = indexPath.row;                       // pass the cell index to ProductDetailViewController
    controller.managedObjectContext = self.managedObjectContext;   // pass the managedObjectContext reference to ProductDetailViewController
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark - ProductTableViewCell Delegate
-(void)addToCart:(ProductTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ProductInfo *productInfo = [[ProductInfo alloc]init];
    ProductInfoItem *item = productInfo.items[indexPath.row];
    [self editCartForProduct:item];
    return;
}

-(void)editCartForProduct:(ProductInfoItem *)item {
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
        cartItem.price = [item.productPrice doubleValue]; //double to double
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

    return UIBarPositionTopAttached;
}

@end

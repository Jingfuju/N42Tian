//
//  SecondViewController.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/11/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "CartViewController.h"
#import "CartTableViewCell.h"
#import "CartProductInfo+CoreDataClass.h"
#import "QuantityPickerViewController.h"
#import "ProductDetailViewController.h"
#import "HomeViewController.h"
#import "LoginViewController.h"

static NSString * const CartTableViewCellIdentifier = @"CartTableViewCell";

@interface CartViewController () <NSFetchedResultsControllerDelegate, QuantityPickerViewControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *cartTableView;


@end

@implementation CartViewController {
    NSFetchedResultsController *_fetchedResultsController;
    NSInteger _numberOfProducts;

}

-(NSFetchedResultsController *) fetchedResultsController {
    if (_fetchedResultsController == nil) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"CartProductInfo" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        [fetchRequest setFetchBatchSize:20];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"CartProductInfos"];
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self performFetch];
    
    
    self.cartTableView.rowHeight = 120;
    [self.cartToolbar setFrame:CGRectMake(0, self.view.frame.size.height-98, self.view.frame.size.width, 49)];
    
    UINib *cellNib = [UINib nibWithNibName:CartTableViewCellIdentifier bundle:nil];
    [self.cartTableView registerNib:cellNib forCellReuseIdentifier:CartTableViewCellIdentifier];    
}

-(void)performFetch {
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"FATAL_CORE_DATA_ERROR");
        abort();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)saveToCoreData{
    NSError *error;
    if(![self.managedObjectContext save:&error]) {
        NSLog(@"FATAL_CORE_DATA_ERROR");
        abort();
    }
}

-(IBAction)popHomeView:(id)sender {
    [self.tabBarController setSelectedIndex:0];
}

- (IBAction)checkout:(id)sender
{
    BOOL isLogin = YES;   // temporary determine the login states
    if (isLogin) {
        LoginViewController *controller = [[LoginViewController alloc] init];
        self.navigationController.navigationBar.hidden = YES;  // hide the system navigation bar
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

-(void)dealloc {
    NSLog(@"CartViewController is deallocated");
    _fetchedResultsController.delegate = nil;
}


- (void)decidedCartSubviewbyNumberofProducts {
    if (_numberOfProducts == 0) {
        [self.emptyCartView setHidden:NO];
        [self.cartTableView setHidden:YES];
    } else {
        [self.cartTableView setHidden:NO];
        [self.emptyCartView setHidden:YES];
    }
}

-(NSString *)badgeNumber {
    long totalQuantity = 0;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CartProductInfo" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSError *error;
    [request setEntity:entity];
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    for (NSManagedObject *object in result) {
        totalQuantity += [[object valueForKey:@"quantity"] intValue];
    }
    
    if (totalQuantity == 0) {
        return @"";
    } else {
        return [NSString stringWithFormat:@"%ld",totalQuantity];
    }
}

-(void)updateCartBadge {
    [self tabBarController].viewControllers[1].tabBarItem.badgeValue = [self badgeNumber];
}


#pragma mark - UITableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections] [section];
    _numberOfProducts = [sectionInfo numberOfObjects];
    [self decidedCartSubviewbyNumberofProducts];
    return _numberOfProducts;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CartTableViewCellIdentifier];
    cell.delegate = self;
    [self configureCell:cell atIndexPath:indexPath];
    [self calculateCheckoutBarItems];

    return cell;
}

#pragma mark - UITableView Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.3;
}

-(void)configureCell:(CartTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CartProductInfo *cartItem = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.cartItemName.text = cartItem.name;
    cell.quantityLabel.text = [NSString stringWithFormat:@"%d",cartItem.quantity];
    cell.cartItemPrice.text = [self formatMoneyNumberWithDoubleValue:cartItem.price]; //covert to
    cell.cartImageView.image = [UIImage imageNamed:cartItem.productImage];
    cell.cartSubTotalQty.titleLabel.text = @"";
    cell.cartSubTotalPrice.text = [self formatMoneyNumberWithDoubleValue:cartItem.price * cartItem.quantity];
}

- (void)calculateCheckoutBarItems
{
    // Monitor cart item changes all the time
    int totalQuantity = 0;
    double total = 0;
    int singleQuantity = 0;
    double subtotal = 0;
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections] [0];
    for (NSManagedObject *object in [sectionInfo objects]) {
        totalQuantity += [[object valueForKey:@"quantity"] intValue];
        singleQuantity = [[object valueForKey:@"quantity"] intValue];
        subtotal = [[object valueForKey:@"price"] floatValue] * singleQuantity;
        total += subtotal;
    }
    self.totalQty.text = [NSString stringWithFormat:@"%d", totalQuantity];
    self.totalPrice.text = [self formatMoneyNumberWithDoubleValue:total];

}

- (NSString *)formatMoneyNumberWithDoubleValue:(double)value {
    NSDecimalNumber *decimalValue = [NSDecimalNumber numberWithDouble:value];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setCurrencySymbol:@"$"];
    return [numberFormatter stringFromNumber:decimalValue];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithNibName:@"ProductDetailViewController" bundle:nil];
    controller.managedObjectContext = self.managedObjectContext;
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CartProductInfo *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:info];
        [self saveToCoreData];
    }
}

#pragma mark - NSFetchedResultsControllerDelegate
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
        [self.cartTableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(nonnull id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.cartTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeDelete:
            [self.cartTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.cartTableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            [self.cartTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.cartTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(nonnull id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.cartTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.cartTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.cartTableView endUpdates];
}



#pragma mark - CartTableViewCell Delegate
-(void)addOneMore:(CartTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CartProductInfo *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
    info.quantity +=1;
    
    [self saveToCoreData];
    [self updateCartBadge];
    return;
}

-(void)removeOneMore:(CartTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CartProductInfo *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if (info.quantity >= 2) {
        info.quantity -=1;
        [self saveToCoreData];
        [self updateCartBadge];
    } else if (info.quantity == 1) {

        self.indexMentioned = indexPath;
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Cart Management"
                                  message:@"Do you really want to remove this product from your cart?"
                                  delegate:nil
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles: @"Remove", nil];
        alertView.delegate = self;
        [alertView show];
    } else {
        NSLog(@"Error, YOU need to check the functionnality of your CoreData");
    }
    
    return;
}


#pragma mark - UIAlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        [alertView removeFromSuperview];
    } else {
        CartProductInfo *info = [self.fetchedResultsController objectAtIndexPath:self.indexMentioned];
        [self.managedObjectContext deleteObject:info];
        [self saveToCoreData];
    }
}


#pragma mark - QuantityPickerViewController Delegate
-(NSIndexPath *)getButtonIndexPath:(UIButton *)button {
    CGRect buttonFrame = [button convertRect:button.bounds toView:self.cartTableView];
    return [self.cartTableView indexPathForRowAtPoint:buttonFrame.origin];
}

-(void)popUpNumberPickerControlerFrom:(CartTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    QuantityPickerViewController *controller = [[QuantityPickerViewController alloc] initWithNibName:@"QuantityPickerViewController" bundle:nil];
    controller.indexPath = indexPath;
 
    controller.view.frame = self.view.bounds;
    [self.view addSubview:controller.view];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    controller.delegate = self;
}


-(void)updateQuantityFrom:(QuantityPickerViewController *)controller atIndexPath:(NSIndexPath *)indexPath withNumber:(NSString *)quantity {
    CartProductInfo *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
    info.quantity = [quantity intValue];
    
    [self saveToCoreData];
}

#pragma mark - UINavigationbar Delegate
-(UIBarPosition)positionForBar:(id<UIBarPositioning>)bar {
    return UIBarPositionTopAttached;
}



@end

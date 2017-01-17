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


static NSString * const CartTableViewCellIdentifier = @"CartTableViewCell";

@interface CartViewController () <NSFetchedResultsControllerDelegate, QuantityPickerViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableView *cartTableView;


@end

@implementation CartViewController {
    NSFetchedResultsController *_fetchedResultsController;
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

#pragma mark - UITableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections] [section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CartTableViewCellIdentifier];
    cell.delegate = self;
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableView Delegate

-(void)configureCell:(CartTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CartProductInfo *cartItem = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.cartItemName.text = cartItem.name;
    cell.quantityLabel.text = [NSString stringWithFormat:@"%d",cartItem.quantity];
    cell.cartItemPrice.text = [NSString stringWithFormat:@"%.2f",cartItem.price]; //covert to 
    
    cell.cartImageView.image = [UIImage imageNamed:@"1"];
    
    cell.cartSubTotalPrice.text = @"110";
    cell.cartSubTotalQty.titleLabel.text =@"";
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        CartProductInfo *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:info];
        
        NSError *error;
        if(![self.managedObjectContext save:&error]) {
            NSLog(@"FATAL_CORE_DATA_ERROR");
            abort();
        }
    }
}

#pragma mark - NSFetchedResultsControllerDelegate
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@"***Controller will change content");
    [self.cartTableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(nonnull id)anObject atIndexPath:(nullable NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(nullable NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            NSLog(@"**NSFetchedResultsChangeInsert (Object");
            [self.cartTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeDelete:
            NSLog(@"**NSFetchedResultsChangeDelete (object)");
            [self.cartTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeUpdate:
            NSLog(@"**NSFetchedResultsChangeUpdate (Object)");
            [self configureCell:[self.cartTableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
        case NSFetchedResultsChangeMove:
            NSLog(@"**NSFetchedResultsChangeMove (Object)");
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
            NSLog(@"**NSFetchedResultsChangeInsert (Section)");
            [self.cartTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            NSLog(@"**NSFetchedResultsChangeDelete (Section)");
            [self.cartTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    NSLog(@"** controllerDidChangeContent");
    [self.cartTableView endUpdates];
}

-(void)dealloc {
    NSLog(@"CartViewController is deallocated");
    _fetchedResultsController.delegate = nil;
}

#pragma mark - CartTableViewCell Delegate
-(void)addOneMore:(CartTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CartProductInfo *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
    info.quantity +=1;
    
    NSError *error;
    if(![self.managedObjectContext save:&error]) {
        NSLog(@"FATAL_CORE_DATA_ERROR");
        abort();
    }
    return;
}

-(void)removeOneMore:(CartTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    CartProductInfo *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
    if (info.quantity >= 2) {
        info.quantity -=1;
    } else if (info.quantity == 1) {
        NSLog(@"Product quantity is 1");
        [self removeProductAlert];
    } else {
        NSLog(@"Error, YOU need to check the functionnality of your CoreData");
    }
    
    NSError *error;
    if(![self.managedObjectContext save:&error]) {
        NSLog(@"FATAL_CORE_DATA_ERROR");
        abort();
    }
    return;
}

-(void)removeProductAlert {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Cart Management"
                              message:@"Do you really want to remove this product from your cart?"
                              delegate:nil
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles: @"Remove", nil];
    [alertView show];
}


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

#pragma mark - QuantityPickerViewController Delegate
-(void)updateQuantityFrom:(QuantityPickerViewController *)controller atIndexPath:(NSIndexPath *)indexPath withNumber:(NSString *)quantity {
    
    NSLog(@"Quantity number is %d",[quantity intValue]);
    CartProductInfo *info = [self.fetchedResultsController objectAtIndexPath:indexPath];
    info.quantity = [quantity intValue];
    
    NSError *error;
    if(![self.managedObjectContext save:&error]) {
        NSLog(@"FATAL_CORE_DATA_ERROR");
        abort();
    }
}


@end

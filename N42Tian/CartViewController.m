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

static NSString * const CartTableViewCellIdentifier = @"CartTableViewCell";

@interface CartViewController ()

@property (nonatomic, weak) IBOutlet UITableView *CartTableView;



@end

@implementation CartViewController {
    NSArray *_cartProductInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.CartTableView.rowHeight = 120;
    
    UINib *cellNib = [UINib nibWithNibName:CartTableViewCellIdentifier bundle:nil];
    [self.CartTableView registerNib:cellNib forCellReuseIdentifier:CartTableViewCellIdentifier];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"CartProductInfo" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *foundObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error]; if (foundObjects == nil) {
        NSLog(@"FATAL_CORE_DATA_ERROR");
        abort();
    }
    
    _cartProductInfo = foundObjects;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Data Source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   NSLog(@"%d",[_cartProductInfo count]);
    return [_cartProductInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CartTableViewCellIdentifier];
    CartProductInfo *cartItem = _cartProductInfo[indexPath.row];
    
    cell.cartItemName.text = cartItem.name;
    cell.cartImageView.image = [UIImage imageNamed:@"1"];
    cell.cartItemPrice.text = @"55";
    cell.cartSubTotalQty.titleLabel.text = @"2";
    cell.cartSubTotalPrice.text = @"110";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)dealloc {
    NSLog(@"CartViewController is deallocated");
}

@end

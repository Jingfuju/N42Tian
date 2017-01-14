//
//  SecondViewController.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/11/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "CartViewController.h"
#import "CartTableViewCell.h"

static NSString * const CartTableViewCellIdentifier = @"CartTableViewCell";

@interface CartViewController ()

@property (nonatomic, weak) IBOutlet UITableView *CartTableView;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.CartTableView.rowHeight = 120;
    
    UINib *cellNib = [UINib nibWithNibName:CartTableViewCellIdentifier bundle:nil];
    [self.CartTableView registerNib:cellNib forCellReuseIdentifier:CartTableViewCellIdentifier];
    
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
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CartTableViewCellIdentifier];
    
    cell.cartItemName.text = @"millet";
    cell.cartImageView.image = [UIImage imageNamed:@"1"];
    cell.cartItemPrice.text = @"55";
    cell.cartSubTotalQty.titleLabel.text = @"2";
    cell.cartSubTotalPrice.text = @"110";
    
    return cell;
}

@end

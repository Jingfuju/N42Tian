//
//  FirstViewController.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/11/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "HomeViewController.h"
#import "ProductTableViewCell.h"

static NSString * const ProductTableViewCellIdentifier = @"ProductTableViewCell";

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *productTableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.productTableView.rowHeight = 200;
    
    UINib *cellNib = [UINib nibWithNibName:ProductTableViewCellIdentifier bundle:nil];
    [self.productTableView registerNib:cellNib forCellReuseIdentifier:ProductTableViewCellIdentifier];
    
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
    cell.productName.text = @"Rice";
    cell.productPrice.text = @"1000";
    
    return cell;
}

@end

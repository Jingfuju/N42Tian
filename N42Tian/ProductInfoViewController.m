//
//  ProductInfoViewController.m
//  N42Tian
//
//  Created by apple on 18/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "ProductInfoViewController.h"
#import "ProductDetailTableViewCell.h"

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
    ProductDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailTableViewCell"];
    cell = [[[NSBundle mainBundle] loadNibNamed:@"ProductDetailTableViewCell" owner:self options:nil] lastObject];
    switch (_index) {
        case 0:            
            return cell;
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
    return nil;
    
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (_index) {
        case 0:
            return 1;
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }

    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.f;
}

@end

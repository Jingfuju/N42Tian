//
//  QuantityPickerViewController.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/17/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "QuantityPickerViewController.h"

@interface QuantityPickerViewController ()

@end

@implementation QuantityPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

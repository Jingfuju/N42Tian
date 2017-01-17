//
//  QuantityPickerViewController.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/17/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "QuantityPickerViewController.h"
#import "CartProductInfo+CoreDataClass.h"

@interface QuantityPickerViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *picker;


@end

@implementation QuantityPickerViewController {
    NSArray *_pickerData;
    NSString *_result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickerData = @[@"1", @"2", @"3", @"4", @"5", @"6"];
    self.picker.dataSource = self;
    self.picker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)close:(id)sender {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

-(IBAction)done:(id)sender {
    
}

-(void)dealloc {
    NSLog(@"QuantityPickerViewController is dealloced");
}

#pragma mark - UIPickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _result = _pickerData[row];
    return;
}

#pragma mark - CartViewController Delegate

-(void)updateCartQuantityfrom:(CartViewController *)controller atIndexPath:(NSIndexPath *)indexPath {
    
}

@end

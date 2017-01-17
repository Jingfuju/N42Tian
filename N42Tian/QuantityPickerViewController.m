//
//  QuantityPickerViewController.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/17/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "QuantityPickerViewController.h"
#import "CartViewController.h"

@interface QuantityPickerViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;


@end

@implementation QuantityPickerViewController {
    NSArray *_pickerData;
    NSString *_pickerQuantity;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pickerData = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",@"10"];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close:)];
    gestureRecognizer.cancelsTouchesInView = NO;
    gestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:gestureRecognizer];
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
    [self.delegate updateQuantityFrom:self atIndexPath:self.indexPath withNumber:_pickerQuantity];
    NSLog(@"Quantitiy number in controller is %@",_pickerQuantity);
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
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
    _pickerQuantity = _pickerData[row];

    return;
}


#pragma mark - UIGestureRecognizer Delegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return (touch.view == self.view);
}



@end

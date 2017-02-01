//
//  CartTableViewCell.m
//  N42Tian
//
//  Created by apple on 13/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "CartTableViewCell.h"

@implementation CartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cartAddQty:(id)sender {
    NSIndexPath *indexPath = [self.delegate getButtonIndexPath:sender];
    [self.delegate addOneMore:self atIndexPath:indexPath];
}

- (IBAction)cartMinusQty:(id)sender {
    NSIndexPath *indexPath = [self.delegate getButtonIndexPath:sender];
    [self.delegate removeOneMore:self atIndexPath:indexPath];
    
}

-(IBAction)pickerController:(id)sender {
    NSIndexPath *indexPath = [self.delegate getButtonIndexPath:sender];
    [self.delegate popUpNumberPickerControlerFrom:self atIndexPath:indexPath];
}

@end

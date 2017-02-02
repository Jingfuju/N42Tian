//
//  EmptyCartTableViewCell.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/21/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "EmptyCartTableViewCell.h"
#import "HomeViewController.h"

@implementation EmptyCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)shopNow:(id)sender {
    [self.delegate popHomeViewPage];
}

@end

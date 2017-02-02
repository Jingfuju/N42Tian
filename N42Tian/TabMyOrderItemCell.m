//
//  TabMyOrderItemCell.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/27/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "TabMyOrderItemCell.h"
#import "View+MASAdditions.h"
#import "common_macro.h"
#import "UIColor+hexColor.h"

@interface TabMyOrderItemCell() {
    UIImageView *_vPenddingImage;
    UILabel *_vPenddingLabel;
    
    UIImageView *_vShippingImage;
    UILabel *_vShippingLabel;
    
    UIImageView *_vSuccessImage;
    UILabel *_vSuccessLabel;
}

@end

@implementation TabMyOrderItemCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat gridWidth = self.frame.size.width / 3;
    UIButton *grid1 = [UIButton new];
    UIButton *grid2 = [UIButton new];
    UIButton *grid3 = [UIButton new];
    
    [self addSubview:grid1];
    [self addSubview:grid2];
    [self addSubview:grid3];
    
    
    //Put underlying button at the section
    [grid1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(gridWidth);
        make.height.equalTo(self);
    }];
    
    [grid2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grid1.mas_right);
        make.top.equalTo(self);
        make.width.mas_equalTo(gridWidth);
        make.height.equalTo(self);
    }];
    
    [grid3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(grid2.mas_right);
        make.top.equalTo(self);
        make.width.mas_equalTo(gridWidth);
        make.height.equalTo(self);
    }];
    
    
    //Add the Waiting for Payment icon
    _vPenddingImage = [UIImageView new];
    _vPenddingImage.image = [UIImage imageNamed:@"icon_my_wallet"];
    [grid1 addSubview:_vPenddingImage];
    [_vPenddingImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid1);
        make.top.equalTo(grid1).with.offset(4);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    
    _vPenddingLabel = [UILabel new];
    _vPenddingLabel.text = @"Payment";
    _vPenddingLabel.font = [UIFont systemFontOfSize:12];
    _vPenddingLabel.textColor = kColorMainGrey;
    [grid1 addSubview:_vPenddingLabel];
    [_vPenddingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid1);
        make.top.equalTo(_vPenddingImage.mas_bottom).with.offset(2);
    }];
    NSLog(@"Waiting for Payment done");
    
    
    //Add the Waiting for Shipping Icon
    _vShippingImage = [UIImageView new];
    _vShippingImage.image = [UIImage imageNamed:@"icon_my_car"];
    [grid2 addSubview:_vShippingImage];
    [_vShippingImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid2);
        make.top.equalTo(grid2).with.offset(4);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    
    _vShippingLabel = [UILabel new];
    _vShippingLabel.text = @"Shipping";
    _vShippingLabel.font = [UIFont systemFontOfSize:12];
    _vShippingLabel.textColor = kColorMainGrey;
    [grid2 addSubview:_vShippingLabel];
    [_vShippingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid2);
        make.top.equalTo(_vPenddingLabel);
    }];
    

    //Add the Tranction Done
    _vSuccessImage = [UIImageView new];
    _vSuccessImage.image = [UIImage imageNamed:@"icon_my_review"];
    [grid3 addSubview:_vSuccessImage];
    [_vSuccessImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid3);
        make.top.equalTo(grid3).with.offset(4);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    
    _vSuccessLabel = [UILabel new];
    _vSuccessLabel.text = @"Done";
    _vSuccessLabel.font = [UIFont systemFontOfSize:12];
    _vSuccessLabel.textColor = kColorMainGrey;
    [grid3 addSubview:_vSuccessLabel];
    [_vSuccessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(grid3);
        make.top.equalTo(_vSuccessImage.mas_bottom).with.offset(2);
    }];
    
    [grid1 addTarget:self action:@selector(clickGrid1) forControlEvents:UIControlEventTouchUpInside];
    [grid2 addTarget:self action:@selector(clickGrid2) forControlEvents:UIControlEventTouchUpInside];
    [grid3 addTarget:self action:@selector(clickGrid3) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

-(void)clickGrid1 {
    
}

-(void)clickGrid2 {
    
}

-(void)clickGrid3 {
    
}


@end

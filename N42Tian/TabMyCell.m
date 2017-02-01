//
//  TabMyCell.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/27/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "TabMyCell.h"
#import "View+MASAdditions.h"

@interface TabMyCell() {
    UIImageView *_vImage;
    UILabel *_vTitle;
}
@end

@implementation TabMyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier imageNamed:(NSString *)imageNamed title:(NSString *)title {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _vImage = [UIImageView new];
    _vImage.image = [UIImage imageNamed:imageNamed];
    [self addSubview:_vImage];
    [_vImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(16);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    
    _vTitle = [UILabel new];
    _vTitle.text = title;
    [self addSubview:_vTitle];
    [_vTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_vImage.mas_right).with.offset(10);
        make.centerY.equalTo(self);
    }];
    return self;
}

@end

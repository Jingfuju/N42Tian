//
//  TabMyHeadCell.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/26/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "TabMyHeadCell.h"
#import "View+MASAdditions.h"



@implementation TabMyHeadCell {
      UIImageView *_vImage;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(CGFloat)height {
    return 140;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //Created Head Background ImageView
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"personal_bkg"];
    
    //Load Head BackGround Image
    [self setBackgroundView:imageView];
    
    CGFloat vImageWidth = 60;
    CGFloat vImageHeight = 60;
    _vImage = [UIImageView new];
    _vImage.image = [UIImage imageNamed:@"head"];
    [self addSubview:_vImage];
    [_vImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(20);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(vImageWidth);
        make.height.mas_equalTo(vImageHeight);
    }];

    
    
    return self;
}

@end

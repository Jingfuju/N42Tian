//
//  TabMyHeadCell.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/26/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "TabMyHeadCell.h"



@implementation TabMyHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+(CGFloat)height {
    return 120;
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
    
    //
    
    
    return self;
}

@end

//
//  CategoryLabel.m
//  N42Tian
//
//  Created by apple on 19/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "CategoryLabel.h"

@interface CategoryLabel ()

@property (strong, nonatomic) UIView *lineView;

@end

@implementation CategoryLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:15];
        self.userInteractionEnabled = YES;
        self.scale = 0.0;
        self.lineView = [[UIView alloc] init];
        [self.lineView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.lineView];
    }
    return self;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1.0];
    [[self.subviews lastObject] setBackgroundColor:[UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:scale]];
    CGFloat minScale = 1;
    CGFloat trueScale = minScale + (1 - minScale)*scale;
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

- (void)setContent:(NSString *)content
{
    self.text = content;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName, nil];
    CGSize fontSize = [self.text sizeWithAttributes:dic];
    CGRect frame = self.lineView.frame;
    frame = CGRectMake(fabs(90 - fontSize.width)/2, 43, fontSize.width, 1);
    self.lineView.frame = frame;
}

@end

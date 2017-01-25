//
//  BackgroundView.m
//  N42Tian
//
//  Created by apple on 23/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "BackgroundView.h"

@implementation BackgroundView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.5f];
    }
    return self;
}

@end


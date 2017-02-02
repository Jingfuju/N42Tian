//
//  UIColor+hexColor.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/31/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "UIColor+hexColor.h"

@implementation UIColor (hexColor)

+ (UIColor *)hexColor:(NSString *)hexStr {
    if (hexStr.length < 6) {
        return nil;
    }
    
    unsigned int red_, green_, blue_;
    NSRange exceptionRange;
    exceptionRange.length = 2;
    
    //red
    exceptionRange.location = 0;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&red_];
    
    //green
    exceptionRange.location = 2;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&green_];
    
    //blue
    exceptionRange.location = 4;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&blue_];
    
    UIColor *resultColor = RGB(red_, green_, blue_);
    
    return resultColor;
}

@end

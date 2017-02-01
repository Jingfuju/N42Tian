//
//  UIColor+hexColor.h
//  N42Tian
//
//  Created by Jingfu Ju on 1/31/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r,g,b) [UIColor colorWithRed: r/255. green: g/255. blue: b/255. alpha:1];

@interface UIColor (hexColor)

+ (UIColor *)hexColor:(NSString *)hexStr;

@end

//
//  DrawView.m
//  N42Tian
//
//  Created by Jingfu Ju on 2/1/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//
//Note: Change ProductDetailViewController.xib's identity inspector to DrawView;


#import "DrawView.h"
#import "common_macro.h"

@implementation DrawView

- (void) drawRect:(CGRect)rect
{
    
    //Get the CGContext from this view
    CGContextRef context = UIGraphicsGetCurrentContext();

    //Set the stroke (pen) color
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    //Set the width of the pen mark
    CGContextSetLineWidth(context, 0.03);

    // Draw a line
    //Start at this point
    CGContextMoveToPoint(context, 0, kScreenHeight - 44);

    //Give instructions to the CGContext
    //(move "pen" around the screen)
    CGContextAddLineToPoint(context, kScreenWidth, kScreenHeight - 44);
    //CGContextAddLineToPoint(context, 310.0, 90.0);
    //CGContextAddLineToPoint(context, 10.0, 90.0);

    //Draw it
    CGContextStrokePath(context);
        
    //Get the CGContext from this view
    CGContextRef contextBottom = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextBottom, [UIColor whiteColor].CGColor);
        //Define a rectangle
    CGContextAddRect(contextBottom, CGRectMake(0, kScreenHeight - 44, kScreenWidth, 44));
    
    CGContextFillPath(contextBottom);

    CGContextRef contextTop = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contextTop, [UIColor whiteColor].CGColor);
    CGContextAddRect(contextTop, CGRectMake(0, 0, kScreenWidth, 64));
    CGContextFillPath(contextTop);
    
}
@end

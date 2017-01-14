//
//  cartProductInfo.h
//  N42Tian
//
//  Created by apple on 13/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cartProductInfo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSDecimalNumber *price;
@property (nonatomic, assign) NSInteger quantity;
@property (nonatomic, assign) BOOL checked;

@end

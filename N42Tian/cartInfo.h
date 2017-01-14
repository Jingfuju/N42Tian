//
//  cartInfo.h
//  N42Tian
//
//  Created by apple on 13/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cartProductInfo.h"

@interface cartInfo : NSObject

@property (nonatomic, copy) cartProductInfo *cartProduct;
@property (nonatomic, assign) NSInteger totalQuantity;
@property (nonatomic, copy) NSDecimalNumber *totalPrice;

@end

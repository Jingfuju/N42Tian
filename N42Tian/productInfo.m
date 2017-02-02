//
//  productInfo.m
//  N42Tian
//
//  Created by apple on 12/1/2017.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "ProductInfo.h"
#import "ProductInfoItem.h"

@implementation ProductInfo

- (id)init {
    if ((self = [super init])) {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
        
        ProductInfoItem *item;
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setCurrencySymbol:@"$"];
        
        item = [[ProductInfoItem alloc] init];
        item.productName = @"Millet1100g";
        item.productPrice = [NSDecimalNumber decimalNumberWithString:@"9.00"];
        item.productImageName = @"1";
        [self.items addObject:item];
        
        item = [[ProductInfoItem alloc] init];
        item.productName = @"Millet2200g";
        item.productPrice = [NSDecimalNumber decimalNumberWithString:@"13.00"];
        item.productImageName = @"2";
        [self.items addObject:item];
        
        item = [[ProductInfoItem alloc] init];
        item.productName = @"Millet3300g";
        item.productPrice = [NSDecimalNumber decimalNumberWithString:@"21.00"];
        item.productImageName = @"3";
        [self.items addObject:item];
    }
    return self;
}

@end

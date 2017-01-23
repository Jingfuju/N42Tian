//
//  CartProductInfo+CoreDataProperties.m
//  N42Tian
//
//  Created by Jingfu Ju on 1/22/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "CartProductInfo+CoreDataProperties.h"

@implementation CartProductInfo (CoreDataProperties)

+ (NSFetchRequest<CartProductInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CartProductInfo"];
}

@dynamic data;
@dynamic name;
@dynamic price;
@dynamic quantity;
@dynamic productImage;

@end

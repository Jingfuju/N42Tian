//
//  CartProductInfo+CoreDataProperties.m
//  
//
//  Created by apple on 21/1/2017.
//
//  This file was automatically generated and should not be edited.
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

@end

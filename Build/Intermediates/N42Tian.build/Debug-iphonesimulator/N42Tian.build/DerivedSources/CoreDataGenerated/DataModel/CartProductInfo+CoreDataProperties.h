//
//  CartProductInfo+CoreDataProperties.h
//  
//
//  Created by apple on 17/1/2017.
//
//  This file was automatically generated and should not be edited.
//

#import "CartProductInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CartProductInfo (CoreDataProperties)

+ (NSFetchRequest<CartProductInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *data;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) double price;
@property (nonatomic) int16_t quantity;

@end

NS_ASSUME_NONNULL_END

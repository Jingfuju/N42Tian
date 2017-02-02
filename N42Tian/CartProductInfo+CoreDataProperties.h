//
//  CartProductInfo+CoreDataProperties.h
//  N42Tian
//
//  Created by Jingfu Ju on 1/22/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "CartProductInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CartProductInfo (CoreDataProperties)

+ (NSFetchRequest<CartProductInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *data;
@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) double price;
@property (nonatomic) int16_t quantity;
@property (nullable, nonatomic, copy) NSString *productImage;

@end

NS_ASSUME_NONNULL_END

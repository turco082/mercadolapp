//
//  MLProduct.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Installments.h"
#import "Address.h"
#import "Shipping.h"
#import "SellerAddress.h"

@interface MLProduct : NSObject

@property (nonatomic, strong) NSString* productId;
@property (nonatomic, strong) NSString* siteId;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* subtitle;
@property (nonatomic, strong) NSNumber* price;
@property (nonatomic, strong) NSString* currencyId;
@property (nonatomic, strong) NSNumber* availableQuantity;
@property (nonatomic, strong) NSNumber* soldQuantity;
@property (nonatomic, strong) NSString* buyingMode;
@property (nonatomic, strong) NSString* lintingTypeId;
@property (nonatomic, strong) NSDate* stopTime;
@property (nonatomic, strong) NSString* condition;
@property (nonatomic, strong) NSString* permalink; // link para compartir
@property (nonatomic, strong) NSString* thumbnail;
@property (nonatomic, assign) BOOL acceptsMercadoPago;

// objects
@property (nonatomic, strong) Installments* installments;
@property (nonatomic, strong) Address* address;
@property (nonatomic, strong) Shipping* shipping;
@property (nonatomic, strong) SellerAddress* sellerAddress;

@property (nonatomic, strong) NSMutableArray* picturesArray;


- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

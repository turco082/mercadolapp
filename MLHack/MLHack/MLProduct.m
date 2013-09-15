//
//  MLProduct.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "MLProduct.h"
#import "Pictures.h"

@implementation MLProduct

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self != nil) {
        // [dictionary objectForKey:@""]
        self.productId = [dictionary objectForKey:@"id"];
        self.siteId = [dictionary objectForKey:@"site_id"];
        NSString* titleString = [dictionary objectForKey:@"title"];
        if (![titleString isKindOfClass:[NSNull class]]) {
            self.title = titleString;
        }
        
        NSString* subtitleString = [dictionary objectForKey:@"subtitle"];
        if (![subtitleString isKindOfClass:[NSNull class]]) {
            self.subtitle = subtitleString;
        }
        
        self.price = [dictionary objectForKey:@"price"];
        self.currencyId = [dictionary objectForKey:@"currency_id"];
        self.availableQuantity = [dictionary objectForKey:@"available_quantity"];
        self.soldQuantity = [dictionary objectForKey:@"sold_quantity"];
        self.buyingMode = [dictionary objectForKey:@"buying_mode"];
        self.lintingTypeId = [dictionary objectForKey:@"listing_type_id"];
        self.stopTime = [dictionary objectForKey:@"stop_time"];
        self.condition = [dictionary objectForKey:@"condition"];
        self.permalink = [dictionary objectForKey:@"permalink"];
        self.thumbnail = [dictionary objectForKey:@"thumbnail"];
        self.acceptsMercadoPago = [[dictionary objectForKey:@"accepts_mercadopago"] boolValue];
        
        NSDictionary* installmentsDic = [dictionary objectForKey:@"installments"];
        if (![installmentsDic isKindOfClass:[NSNull class]]) {
            self.installments = [[Installments alloc] initWithDictionary:installmentsDic];
        }
        
        NSDictionary* addressDic = [dictionary objectForKey:@"address"];
        if (![addressDic isKindOfClass:[NSNull class]]) {
            self.address = [[Address alloc] initWithDictionary:addressDic];
        }
        
        NSDictionary* shippingDic = [dictionary objectForKey:@"shipping"];
        if (![shippingDic isKindOfClass:[NSNull class]]) {
            self.shipping = [[Shipping alloc] initWithDictionary:shippingDic];
        }
        
        NSDictionary* sellerAddressDic = [dictionary objectForKey:@"seller_address"];
        if (![sellerAddressDic isKindOfClass:[NSNull class]]) {
            self.sellerAddress = [[SellerAddress alloc] initWithDictionary:sellerAddressDic];
        }
        
        NSArray* pictures = [dictionary objectForKey:@"pictures"];
        if (![pictures isKindOfClass:[NSNull class]] && pictures != nil) {
            
            self.picturesArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary* picturesDic in pictures) {
                Pictures* picture = [[Pictures alloc] initWithDictionary:picturesDic];
                [self.picturesArray addObject:picture];
            }
        }
        
        
    }
    return self;
}

@end

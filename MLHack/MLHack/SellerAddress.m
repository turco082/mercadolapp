//
//  SellerAddress.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "SellerAddress.h"

@implementation SellerAddress

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self != nil) {
        self.sellerAddressId = [dictionary objectForKey:@"id"];
        self.comment = [dictionary objectForKey:@"comment"];
        self.addressLine = [dictionary objectForKey:@"address_line"];
        self.zipCode = [dictionary objectForKey:@"zip_code"];
        self.country = [[Country alloc] initWithDictionary:[dictionary objectForKey:@"country"]];
        self.state = [[State alloc] initWithDictionary:[dictionary objectForKey:@"state"]];
        self.city = [[City alloc] initWithDictionary:[dictionary objectForKey:@"city"]];
        
        self.latitude = [dictionary objectForKey:@"latitude"];
        self.longitude = [dictionary objectForKey:@"longitude"];
    }
    return self;
}

@end

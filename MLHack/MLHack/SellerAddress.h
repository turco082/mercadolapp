//
//  SellerAddress.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Country.h"
#import "State.h"
#import "City.h"

@interface SellerAddress : NSObject

@property (nonatomic, strong) NSString* sellerAddressId;
@property (nonatomic, strong) NSString* comment;
@property (nonatomic, strong) NSString* addressLine;
@property (nonatomic, strong) NSString* zipCode;
@property (nonatomic, strong) Country* country;
@property (nonatomic, strong) State* state;
@property (nonatomic, strong) City* city;
@property (nonatomic, strong) NSString* latitude;
@property (nonatomic, strong) NSString* longitude;


- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

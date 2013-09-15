//
//  Installments.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "Installments.h"

@implementation Installments

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self != nil) {
        self.quantity = [dictionary objectForKey:@"quantity"];
        self.amount = [dictionary objectForKey:@"amount"];
        self.currencyId = [dictionary objectForKey:@"currency_id"];
    }
    return self;
}

@end

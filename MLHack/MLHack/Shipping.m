//
//  Shipping.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "Shipping.h"

@implementation Shipping

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self != nil) {
        self.freeShipping = [[dictionary objectForKey:@"free_shipping"] boolValue];
        self.mode = [dictionary objectForKey:@"mode"];
    }
    return self;
}

@end

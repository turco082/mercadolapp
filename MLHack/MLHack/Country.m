//
//  Country.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "Country.h"

@implementation Country

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self != nil) {
        self.countryId = [dictionary objectForKey:@"id"];
        self.name = [dictionary objectForKey:@"name"];
    }
    return self;
}

@end

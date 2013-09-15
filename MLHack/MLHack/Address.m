//
//  Address.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "Address.h"

@implementation Address

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self != nil) {
        self.stateId = [dictionary objectForKey:@"state_id"];
        self.stateName = [dictionary objectForKey:@"state_name"];
        self.cityId = [dictionary objectForKey:@"city_id"];
        self.cityName = [dictionary objectForKey:@"city_name"];
    }
    return self;
}

@end

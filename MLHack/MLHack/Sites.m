//
//  Sites.m
//  MLHack
//
//  Created by Ramiro Ponce on 14/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "Sites.h"

@implementation Sites

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self != nil) {
        self.siteId = [dictionary objectForKey:@"id"];
        self.name = [dictionary objectForKey:@"name"];
    }
    return self;
}

@end

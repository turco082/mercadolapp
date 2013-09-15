//
//  Category.m
//  MLHack
//
//  Created by Ramiro Ponce on 14/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "Category.h"

@implementation Category

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self != nil) {
        self.categoryId = [dictionary objectForKey:@"id"];
        self.name = [dictionary objectForKey:@"name"];
        self.isSeleted = NO;
    }
    return self;
}

@end

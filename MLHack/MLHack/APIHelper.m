//
//  APIHelper.m
//  MLHack
//
//  Created by Ramiro Ponce on 14/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "APIHelper.h"

@implementation APIHelper

static APIHelper* _instance = nil;

+ (APIHelper*) sharedInstance
{
    
    @synchronized([APIHelper class])
    {
        if (! _instance) {
            [[self alloc] init];
        }
        return _instance;
    }
    return nil;
}

+ (id) alloc{
    @synchronized([APIHelper class])
    {
        NSAssert(_instance == nil, @"Attempted to allocate a second instance of the APIHelper singleton");
        _instance = [super alloc];
        return _instance;
    }
}

- (id) init{
    self = [super init];
    if (self != nil) {
    }
    return self;
}

@end

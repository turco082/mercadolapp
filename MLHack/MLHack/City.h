//
//  City.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic, strong) NSString* cityId;
@property (nonatomic, strong) NSString* name;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

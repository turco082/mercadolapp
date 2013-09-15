//
//  Address.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Address : NSObject

@property (nonatomic, strong) NSString* stateId;
@property (nonatomic, strong) NSString* stateName;
@property (nonatomic, strong) NSString* cityId;
@property (nonatomic, strong) NSString* cityName;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

//
//  Shipping.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shipping : NSObject

@property (nonatomic, assign) BOOL freeShipping;
@property (nonatomic, strong) NSString* mode;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

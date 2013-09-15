//
//  Installments.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Installments : NSObject

@property (nonatomic, strong) NSNumber* quantity;
@property (nonatomic, strong) NSNumber* amount;
@property (nonatomic, strong) NSString* currencyId;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

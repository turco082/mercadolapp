//
//  Country.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic, strong) NSString* countryId;
@property (nonatomic, strong) NSString* name;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

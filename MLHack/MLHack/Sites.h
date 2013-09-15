//
//  Sites.h
//  MLHack
//
//  Created by Ramiro Ponce on 14/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sites : NSObject

@property (nonatomic, strong) NSString* siteId;
@property (nonatomic, strong) NSString* name;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

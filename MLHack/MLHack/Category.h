//
//  Category.h
//  MLHack
//
//  Created by Ramiro Ponce on 14/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject

@property (nonatomic, strong) NSString* categoryId;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, assign) BOOL isSeleted;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

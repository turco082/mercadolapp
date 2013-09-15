//
//  MLAPI.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLAPI : NSObject

+ (void) getProductsBySearch:(NSString*)stringTosearch limit:(int)limit site:(NSString*)site block:(void(^)(NSArray* responseArray))responseBlock;

+ (void) getCategorySearch:(NSString*)category limit:(int)limit site:(NSString*)site block:(void(^)(NSArray* responseArray)) responseBlock;

+ (void) getProductById:(NSString*)productId site:(NSString*)site block:(void(^)(id responseObject))responseBlock;

@end

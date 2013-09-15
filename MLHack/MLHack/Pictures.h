//
//  Pictures.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pictures : NSObject

@property (nonatomic, strong) NSString* pictureId;
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* secureUrl;
@property (nonatomic, strong) NSString* size;
@property (nonatomic, strong) NSString* maxSize;
@property (nonatomic, strong) NSString* quality;

- (id) initWithDictionary:(NSDictionary*)dictionary;

@end

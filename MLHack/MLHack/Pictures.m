//
//  Pictures.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "Pictures.h"

@implementation Pictures

//@property (nonatomic, strong) NSString* pictureId;
//@property (nonatomic, strong) NSString* url;
//@property (nonatomic, strong) NSString* secureUrl;
//@property (nonatomic, strong) NSString* size;
//@property (nonatomic, strong) NSString* maxSize;
//@property (nonatomic, strong) NSString* quality;

- (id) initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self != nil) {
        self.pictureId = [dictionary objectForKey:@"id"];
        self.url = [dictionary objectForKey:@"url"];
        self.secureUrl = [dictionary objectForKey:@"secure_url"];
        self.size = [dictionary objectForKey:@"size"];
        self.maxSize = [dictionary objectForKey:@"max_size"];
        self.quality = [dictionary objectForKey:@"quality"];
        
    }
    return self;
}

@end

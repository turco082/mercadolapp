//
//  MLAPI.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "MLAPI.h"
#import "Category.h"

@implementation MLAPI

+ (void) getProductsBySearch:(NSString*)stringTosearch limit:(int)limit site:(NSString*)site block:(void(^)(NSArray* responseArray))responseBlock
{
    //https:// api.mercadolibre.com/sites/MLA/search?q=condones
    NSString* searchParam = [NSString stringWithFormat:@"search?q=%@",stringTosearch];
    NSString* limitParam = [NSString stringWithFormat:@"limit=%i",limit];
    
    NSString* urlString = [NSString stringWithFormat:@"%@%@/%@&%@",ML_BASE_URL, site,searchParam,limitParam];
    NSLog(@"URL STring: %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray* respArray = [JSON objectForKey:@"results"];
        responseBlock(respArray);
    } failure:nil];
    
    [operation start];
}

+ (void) getCategorySearch:(NSString*)category limit:(int)limit site:(NSString*)site block:(void(^)(NSArray* responseArray)) responseBlock
{
    
    NSString* categoryParam = [NSString stringWithFormat:@"category=%@",category];
    NSString* limitParam = [NSString stringWithFormat:@"limit=%i",limit];
    
    NSString* urlString = [NSString stringWithFormat:@"%@%@/search?%@&%@",ML_BASE_URL, site,categoryParam,limitParam];
    NSLog(@"URL: %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray* respArray = [JSON objectForKey:@"results"];
        responseBlock(respArray);
    } failure:nil];
    
    [operation start];
}

+ (void) getProductById:(NSString*)productId site:(NSString*)site block:(void(^)(id responseObject))responseBlock{
    NSString* productParam = [NSString stringWithFormat:@"items/%@", productId];
    NSString* urlString = [NSString stringWithFormat:@"%@%@",ML_BASE_URL_PRODUCT, productParam];
    NSLog(@"URL: %@", urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        responseBlock(JSON);
    } failure:nil];
    
    [operation start];
}

@end

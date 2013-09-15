//
//  ProductViewController.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "ProductViewController.h"
#import "Pictures.h"
#import "UIImageView+AFNetworking.h"
#import "FlatUIKit.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.product = nil;
    currentPictureIndex = 0;
    maxPictures = 0;
    
    CGRect imageFrame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, 130.0);
    self.currentImage = [[UIImageView alloc] initWithFrame:imageFrame];
    self.nextImage = [[UIImageView alloc] initWithFrame:imageFrame];
    
    [self.view addSubview:self.currentImage];
    [self.view addSubview:self.nextImage];
    
    [self.currentImage setAlpha:0.0];
    [self.nextImage setAlpha:0.0];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [MLAPI getProductById:self.productId site:[APIHelper sharedInstance].siteId block:^(id responseObject){
        NSDictionary* productDic = (NSDictionary*)responseObject;
        self.product = [[MLProduct alloc] initWithDictionary:productDic];
        
        if ([self.product.title isKindOfClass:[NSNull class]]) {
            self.product.title = @"";
        }
        
        self.titleLabel.text = self.product.title;
        self.titleLabel.font = [UIFont boldFlatFontOfSize:15];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        if ([self.product.title isKindOfClass:[NSNull class]]) {
            self.product.subtitle = @"";
        }
        
        self.subtitleLabel.text = self.product.subtitle;
        self.subtitleLabel.font = [UIFont flatFontOfSize:15];
        self.subtitleLabel.backgroundColor = [UIColor clearColor];
        
        if ([self.product.price isKindOfClass:[NSNull class]]) {
            self.product.price = [NSNumber numberWithInt:0];
        }
        
        self.priceLabel.text = [NSString stringWithFormat:@"$%i",[self.product.price intValue]];
        self.priceLabel.font = [UIFont flatFontOfSize:20];
        self.priceLabel.backgroundColor = [UIColor clearColor];
        
        
        maxPictures = [self.product.picturesArray count];
        
        [self runPictureAnimation:currentPictureIndex];
        
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark private methods

- (void) runPictureAnimation:(int)idx
{
    Pictures* picture = [self.product.picturesArray objectAtIndex:currentPictureIndex];
    int nextIndex = currentPictureIndex+1;
    if (nextIndex >= maxPictures) {
        nextIndex = 0;
    }
    
    Pictures* nextPicture = [self.product.picturesArray objectAtIndex:nextIndex];
    
    [self.currentImage setImageWithURL:[NSURL URLWithString:picture.url] placeholderImage:nil];
    [self.nextImage setImageWithURL:[NSURL URLWithString:nextPicture.url] placeholderImage:nil];
    
    // Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
    [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
        // Animate the alpha value of your imageView from 1.0 to 0.0 here
        self.currentImage.alpha = 1.0f;
        self.nextImage.alpha = 0.0;
    } completion:^(BOOL finished) {
        // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
        
        [UIView animateWithDuration:2.0 delay:0.0 options:0 animations:^{
            self.currentImage.alpha = 0.0f;
            self.nextImage.alpha = 1.0;
        } completion:^(BOOL finished){
            currentPictureIndex = nextIndex;
            [self runPictureAnimation:currentPictureIndex];
        }];
    }];
    
    
}

@end

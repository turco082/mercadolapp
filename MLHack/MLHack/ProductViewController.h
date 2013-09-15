//
//  ProductViewController.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLProduct.h"

@interface ProductViewController : UIViewController{
    int currentPictureIndex;
    int maxPictures;
}

@property (nonatomic, strong) IBOutlet UILabel* titleLabel;
@property (nonatomic, strong) IBOutlet UILabel* subtitleLabel;
@property (nonatomic, strong) IBOutlet UILabel* priceLabel;

@property (nonatomic, strong) UIImageView* currentImage;
@property (nonatomic, strong) UIImageView* nextImage;

@property (nonatomic, strong) MLProduct* product;

@property (nonatomic, strong) NSString* productId;

@end

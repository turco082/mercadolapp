//
//  UICollectionViewWaterfallCell.h
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface CHTCollectionViewWaterfallCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView* thumbnailImageView;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *subtitleLabel;
@property (nonatomic, strong) IBOutlet UILabel* priceLabel;
@property (nonatomic, strong) IBOutlet UIView* backgroundView;

@property (nonatomic, copy) NSString* titleString;
@property (nonatomic, copy) NSString* subtitleString;
@property (nonatomic, copy) NSString* thumbnailImageName;
@property (nonatomic, copy) NSString* priceString;

@property (nonatomic, strong) UIImage* thumbnailImage;



@end

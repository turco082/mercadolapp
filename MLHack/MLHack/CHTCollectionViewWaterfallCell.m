//
//  UICollectionViewWaterfallCell.m
//  Demo
//
//  Created by Nelson on 12/11/27.
//  Copyright (c) 2012年 Nelson. All rights reserved.
//

#import "CHTCollectionViewWaterfallCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+AFNetworking.h"
#import "FlatUIKit.h"

#define LBL_MAX 999

@interface CHTCollectionViewWaterfallCell ()
@end

@implementation CHTCollectionViewWaterfallCell

#pragma mark - Accessors

- (UIImageView*)thumbnailImageView
{
    if (!_thumbnailImageView) {
        _thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10.0,
                                                                            5.0,
                                                                            118.0,
                                                                            90.0)];
        [_thumbnailImageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _thumbnailImageView;
}

- (UILabel*)titleLabel
{
    if (!_titleLabel) {
        
        CGRect frame = CGRectMake(5.0, 105.0, 118.0, 20);
		_titleLabel = [[UILabel alloc] initWithFrame:frame];
		_titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		_titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
		_titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont boldFlatFontOfSize:11];
        _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	}
    return _titleLabel;
}

- (UILabel*)subtitleLabel
{
    if (!_subtitleLabel) {
		_subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 164.0, 118.0, 20)];
		_subtitleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		_subtitleLabel.backgroundColor = [UIColor clearColor];
        _subtitleLabel.textColor = [UIColor blackColor];
		_subtitleLabel.textAlignment = NSTextAlignmentLeft;
        _subtitleLabel.numberOfLines = 0;
        _subtitleLabel.font = [UIFont flatFontOfSize:11];
        _subtitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
	}
    return _subtitleLabel;
}

- (UILabel*)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 234.0, 104, 24.0)];
        _priceLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		_priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textColor = [UIColor blackColor];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.numberOfLines = 1;
        _priceLabel.font = [UIFont boldFlatFontOfSize:13];
    }
    
    return _priceLabel;
}

- (void) setTitleString:(NSString *)titleString
{
    if (![_titleString isEqualToString:titleString]) {
        _titleString = [titleString copy];
        self.titleLabel.text = _titleString;
        
        CGSize maximumLabelSize = CGSizeMake(129, LBL_MAX);
        CGSize expectedLabelSize = [_titleString sizeWithFont:self.titleLabel.font constrainedToSize:maximumLabelSize lineBreakMode:self.titleLabel.lineBreakMode];
        CGRect newFrame = self.titleLabel.frame;
        newFrame.size.height = expectedLabelSize.height;
        self.titleLabel.frame = newFrame;
    }
}

- (void) setSubtitleString:(NSString *)subtitleString
{
    if (![_subtitleString isEqualToString:subtitleString]) {
        _subtitleString = [subtitleString copy];
        self.subtitleLabel.text = _subtitleString;
        
        CGSize maximumLabelSize = CGSizeMake(129, LBL_MAX);
        CGSize expectedLabelSize = [_subtitleString sizeWithFont:self.subtitleLabel.font constrainedToSize:maximumLabelSize lineBreakMode:self.subtitleLabel.lineBreakMode];
        
        CGRect titleFrame = self.titleLabel.frame;
        CGRect newFrame = self.subtitleLabel.frame;
        newFrame.origin.y = titleFrame.origin.y + titleFrame.size.height + 5;
        newFrame.size.height = expectedLabelSize.height;
        self.subtitleLabel.frame = newFrame;
        
    }
}

- (void) setPriceString:(NSString *)priceString
{
    if (![_priceString isEqualToString:priceString]) {
        _priceString = [priceString copy];
        self.priceLabel.text = _priceString;
        
        CGRect subtitleFrame = self.subtitleLabel.frame;
        CGRect newFrame = self.subtitleLabel.frame;
        newFrame.origin.y = subtitleFrame.origin.y + subtitleFrame.size.height + 5;
        self.priceLabel.frame = newFrame;
        
        CGRect bgFrame = self.backgroundView.frame;
        bgFrame.size.height = self.priceLabel.frame.origin.y + self.priceLabel.frame.size.height + 5;
        self.backgroundView.frame = bgFrame;
    }
}

- (void)setThumbnailImage:(UIImage *)thumbnailImage{
    if (!_thumbnailImage) {
        _thumbnailImage = thumbnailImage;
        self.thumbnailImageView.image = thumbnailImage;
    }
}

#pragma mark - Life Cycle
- (void)dealloc {
    [_thumbnailImageView removeFromSuperview];
    _thumbnailImageView = nil;
    
    [_titleLabel removeFromSuperview],
    _titleLabel = nil;
    
    
    [_subtitleLabel removeFromSuperview];
    _subtitleLabel = nil;
    
    [_priceLabel removeFromSuperview];
    _priceLabel = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
}

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
        
        // Initialization code
		self.backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        [self.backgroundView setBackgroundColor:[UIColor whiteColor]];
        self.backgroundView.layer.cornerRadius = 5;
        self.backgroundView.layer.masksToBounds = YES;
        
        self.backgroundView.layer.borderWidth = 3;
        self.backgroundView.layer.borderColor = [[UIColor skyeBlueColor] CGColor];
        
        [self addSubview:self.backgroundView];
        
        [self.backgroundView addSubview:self.titleLabel];
        [self.backgroundView addSubview:self.subtitleLabel];
        [self.backgroundView addSubview:self.thumbnailImageView];
        [self.backgroundView addSubview:self.priceLabel];
	}
	return self;
}

@end

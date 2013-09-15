//
//  MMProfileSideDrawerTableViewCell.m
//  SlideMenuTest
//
//  Created by Ramiro Ponce on 09/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "MMProfileSideDrawerTableViewCell.h"

@implementation MMProfileSideDrawerTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // do something
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    
    CGRect frame = CGRectMake(self.textLabel.frame.origin.x + 50,
                              self.textLabel.frame.origin.y,
                              size.width,
                              size.height);
    self.textLabel.frame =  frame;
    self.textLabel.contentMode = UIViewContentModeScaleAspectFit;
    
    CGRect imageFrame = CGRectMake(0.0,
                                   0.0,
                                   39.0, 39.0);
    self.imageView.frame = imageFrame;
    [self.imageView setContentMode:UIViewContentModeScaleToFill];
    [self.imageView setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin];
    [self.imageView setAutoresizesSubviews:YES];
    
}

@end

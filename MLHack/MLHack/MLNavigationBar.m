//
//  MLNavigationBar.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "MLNavigationBar.h"

@interface MLNavigationBar ()

@property (nonatomic, assign) CGRect coloredBoxRect;
@property (nonatomic, assign) CGRect paperRect;

@end

@implementation MLNavigationBar

- (id) init
{
    self = [super init];
    if (self != nil) {
        
        self.frame = CGRectMake(0.0, 0.0, 320.0, 54.0);
        
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.opaque = NO;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldFlatFontOfSize:15];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        _titleLabel.shadowOffset = CGSizeMake(0, 0);
        [self addSubview:_titleLabel];
        
        //_lightColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0];
        _lightColor = [UIColor skyeBlueColor];
        //_lightColor = [UIColor colorWithRed:78.0/255.0 green:156.0/255.0 blue:206/255.0 alpha:1.0];
        _darkColor = [UIColor colorWithRed:21.0/255.0f green:92.0/255.0f blue:136.0/255.0f alpha:1.0];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setFrame:CGRectMake(5.0, 0.0, 44.0, 44.0)];
        [_backButton setImage:[UIImage imageNamed:@"backbutton.png"] forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backButton];
        
        _doneButton = [[FUIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50.0, 9.0, 40.0, 28.0)];
        _doneButton.buttonColor = [UIColor peterRiverColor];
        _doneButton.shadowColor = [UIColor belizeHoleColor];
        _doneButton.shadowHeight = 1.0f;
        _doneButton.cornerRadius = 6.0f;
        _doneButton.titleLabel.font = [UIFont boldFlatFontOfSize:12];
        [_doneButton setTitle:@"done" forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_doneButton addTarget:self action:@selector(doneButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_doneButton];
        
    }
    return self;
}

- (void) layoutSubviews
{
    CGFloat coloredBoxMargin = 0.0;
    CGFloat coloredBoxHeight = 44.0;
    
    self.coloredBoxRect = CGRectMake(coloredBoxMargin, coloredBoxMargin, self.bounds.size.width - coloredBoxMargin*2, coloredBoxHeight);
    
    CGFloat paperMargin = 0.0;
    self.paperRect = CGRectMake(paperMargin, CGRectGetMaxY(self.coloredBoxRect), self.bounds.size.width-paperMargin*2, self.bounds.size.height-CGRectGetMaxY(self.coloredBoxRect));
    
    self.titleLabel.frame = self.coloredBoxRect;
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor* whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.0];
    UIColor* shadowColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.5];
    
    CGContextSetFillColorWithColor(context, whiteColor.CGColor);
    CGContextFillRect(context, _paperRect);
    
    CGContextSaveGState(context);
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 3.0, shadowColor.CGColor);
    CGContextSetFillColorWithColor(context, self.lightColor.CGColor);
    CGContextFillRect(context, self.coloredBoxRect);
    CGContextRestoreGState(context);
    
}

#pragma mark -
#pragma mark private action methods

- (void) backButtonAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(backButtonPressed)])
    {
        [self.delegate performSelector:@selector(backButtonPressed)];
    }
}

- (void) doneButtonAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(doneButtonPressed)])
    {
        [self.delegate performSelector:@selector(doneButtonPressed)];
    }
}

@end

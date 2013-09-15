//
//  MLNavigationBar.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatUIKit.h"
#import "FUIButton.h"

@protocol MLNavigationBarDelegate <NSObject>

@optional

- (void) backButtonPressed;
- (void) doneButtonPressed;

@end

@interface MLNavigationBar : UIView

@property (nonatomic, assign) id <MLNavigationBarDelegate> delegate;

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIColor* lightColor;
@property (nonatomic, strong) UIColor* darkColor;

@property (nonatomic, weak) UIButton* backButton;
@property (nonatomic, strong) FUIButton* doneButton;

@end

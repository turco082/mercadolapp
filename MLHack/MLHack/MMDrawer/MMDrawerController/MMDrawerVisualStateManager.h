//
//  MMDrawerVisualStateManager.h
//  SlideMenuTest
//
//  Created by Ramiro Ponce on 09/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMDrawerVisualState.h"

typedef NS_ENUM(NSInteger, MMDrawerAnimationType)
{
    MMDrawerAnimationTypeNone,
    MMDrawerAnimationTypeSlide,
    MMDrawerAnimationTypeSlideAndScale,
    MMDrawerAnimationTypeSwingingDoor,
    MMDrawerAnimationTypeParallax,
};

@interface MMDrawerVisualStateManager : NSObject

@property (nonatomic, assign) MMDrawerAnimationType leftDrawerAnimationType;

+ (MMDrawerVisualStateManager*) sharedManager;

- (MMDrawerControllerDrawerVisualStateBlock)drawerVisualStateBlockForDrawerSide:(MMDrawerSide)drawerSide;

@end

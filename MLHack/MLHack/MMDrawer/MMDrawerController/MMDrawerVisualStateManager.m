//
//  MMDrawerVisualStateManager.m
//  SlideMenuTest
//
//  Created by Ramiro Ponce on 09/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "MMDrawerVisualStateManager.h"
#import <QuartzCore/QuartzCore.h>

@implementation MMDrawerVisualStateManager

+ (MMDrawerVisualStateManager*) sharedManager
{
    static MMDrawerVisualStateManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[MMDrawerVisualStateManager alloc] init];
        [_sharedManager setLeftDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
    });
    
    return _sharedManager;
}

- (MMDrawerControllerDrawerVisualStateBlock) drawerVisualStateBlockForDrawerSide:(MMDrawerSide)drawerSide{
    MMDrawerAnimationType animationType;
    
    animationType = self.leftDrawerAnimationType;
    
    MMDrawerControllerDrawerVisualStateBlock visualStateBlock = nil;
    switch (animationType) {
        case MMDrawerAnimationTypeSlide:
            visualStateBlock = [MMDrawerVisualState slideVisualStateBlock];
            break;
        case MMDrawerAnimationTypeSlideAndScale:
            visualStateBlock = [MMDrawerVisualState slideAndScaleVisualStateBlock];
            break;
        case MMDrawerAnimationTypeParallax:
            visualStateBlock = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
            break;
        case MMDrawerAnimationTypeSwingingDoor:
            visualStateBlock = [MMDrawerVisualState swingingDoorVisualStateBlock];
            break;
        default:
            visualStateBlock = ^(MMDrawerController* drawerController, MMDrawerSide drawerSide, CGFloat percentVisible){
                
                UIViewController* sideDrawerViewController;
                CATransform3D transform;
                CGFloat maxDrawerWidth;
                
                sideDrawerViewController = drawerController.leftDrawerViewController;
                maxDrawerWidth = drawerController.maximumLeftDrawerWidth;
                
                if (percentVisible > 1.0)
                {
                    transform = CATransform3DMakeScale(percentVisible, 1.f, 1.f);
                    transform = CATransform3DTranslate(transform,
                                                       maxDrawerWidth*(percentVisible - 1.f)/2,
                                                       0.f,
                                                       0.f);
                }else
                {
                    transform = CATransform3DIdentity;
                }
                [sideDrawerViewController.view.layer setTransform:transform]; 
                
            };
            break;
    }
    return visualStateBlock;
}

@end

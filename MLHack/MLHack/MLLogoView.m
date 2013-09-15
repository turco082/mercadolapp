//
//  MLLogoView.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "MLLogoView.h"

@implementation MLLogoView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIImageView* logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mercadolibre.png"]];
        [logoView setContentMode:UIViewContentModeScaleAspectFit];
        CGRect imageFrame = CGRectMake(0.0, 0.0, frame.size.width * 1.2, frame.size.height * 1.2);
        [logoView setFrame:imageFrame];
        [self addSubview:logoView];
    }
    return self;
}

/*-(void)drawRect:(CGRect)rect
{
    
}*/

@end

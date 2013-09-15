//
//  CategorySelectionViewController.h
//  MLHack
//
//  Created by Ramiro Ponce on 14/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLNavigationBar.h"

@interface CategorySelectionViewController : UIViewController <MLNavigationBarDelegate>

@property (nonatomic, strong) UIScrollView* scroll;
@property (nonatomic, strong) NSMutableArray* categories;
@property (nonatomic, strong) NSMutableArray* categories_aux;

@end

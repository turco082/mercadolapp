//
//  HomeCenterViewController.h
//  SlideMenuTest
//
//  Created by Ramiro Ponce on 09/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallLayout.h"

@interface HomeCenterViewController : UIViewController <UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>{
    int categorySelectedIndex;
}

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic) CGFloat cellWidth;
@property (nonatomic, strong) NSMutableArray* personalContent;

@end

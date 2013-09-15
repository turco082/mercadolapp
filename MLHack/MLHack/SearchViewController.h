//
//  SearchViewController.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallCell.h"
#import "CHTCollectionViewWaterfallLayout.h"

@interface SearchViewController : UIViewController <UISearchBarDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>{
}

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic) CGFloat cellWidth;
@property (nonatomic, strong) NSMutableArray* personalContent;

@end

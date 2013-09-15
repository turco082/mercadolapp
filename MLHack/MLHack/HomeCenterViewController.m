//
//  HomeCenterViewController.m
//  SlideMenuTest
//
//  Created by Ramiro Ponce on 09/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "HomeCenterViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

#import "SplashViewController.h"
#import "MLLogoView.h"

#import "Category.h"
#import "MLProduct.h"
#import "UIImageView+AFNetworking.h"
#import "MLLoginViewController.h"
#import "ProductViewController.h"

#define kHomeLimitPerCategory 25
#define CELL_WIDTH 129
#define CELL_IDENTIFIER @"WaterfallCell"

typedef NS_ENUM(NSInteger, MMCenterViewControllerSection){
    MMCenterViewcontrollerSectionLeftViewState,
    MMCenterViewcontrollerSectionDrawerAnimation
};

@interface HomeCenterViewController ()
@property (nonatomic, strong) NSMutableArray *cellHeights;
@end

@implementation HomeCenterViewController

- (id) init
{
    self = [super init];
    if (self) {
        [self setRestorationIdentifier:@"CenterNavigationControllerRestorationKey"];
        self.cellWidth = CELL_WIDTH;
    }
    return self;
}

#pragma mark - Accessors
- (UICollectionView *)collectionView {
	if (!_collectionView) {
		CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
		layout.sectionInset = UIEdgeInsetsMake(9, 9, 9, 9);
		layout.delegate = self;
        
		_collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
		_collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		_collectionView.dataSource = self;
		_collectionView.delegate = self;
		_collectionView.backgroundColor = [UIColor blackColor];
		[_collectionView registerClass:[CHTCollectionViewWaterfallCell class]
		    forCellWithReuseIdentifier:CELL_IDENTIFIER];
	}
	return _collectionView;
}

- (NSMutableArray *)cellHeights {
	if (!_cellHeights) {
		_cellHeights = [NSMutableArray arrayWithCapacity:[_personalContent count]];
		for (NSInteger i = 0; i < [_personalContent count]; i++) {
			_cellHeights[i] = @(arc4random() % 100 * 2 + 100);
		}
	}
	return _cellHeights;
}

/*- (NSMutableArray *)cellHeights {
	if (!_cellHeights) {
		_cellHeights = [NSMutableArray arrayWithCapacity:CELL_COUNT];
		for (NSInteger i = 0; i < CELL_COUNT; i++) {
			_cellHeights[i] = @(arc4random() % 100 * 2 + 100);
		}
	}
	return _cellHeights;
}*/

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor beigeColor]];
    
    categorySelectedIndex = 0;
    
    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    [self setupLeftMenuButton];
    
    [self.navigationController.navigationBar setTintColor:[UIColor skyeBlueColor]];
    //[self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:78.0/255.0 green:156.0/255.0 blue:206/255.0 alpha:1.0]];
    [self.view setBackgroundColor:[UIColor colorWithRed:208.0/255.0
                                                  green:208.0/255.0
                                                   blue:208.0/255.0
                                                  alpha:1.0]];
    
    MLLogoView * logo = [[MLLogoView alloc] initWithFrame:CGRectMake(0, 0, 29, 31)];
    [self.navigationItem setTitleView:logo];
    [self.navigationController.view.layer setCornerRadius:10.0f];
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"firstLoad"] == 1) {
        SplashViewController* welcome = [[SplashViewController alloc] init];
        UINavigationController* welcomeNavController = [[UINavigationController alloc] initWithRootViewController:welcome];
        welcomeNavController.navigationBarHidden = YES;
        [self presentViewController:welcomeNavController animated:NO completion:nil];
        
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"firstLoad"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [self.collectionView setBackgroundColor:[UIColor beigeColor]];
    [self.view addSubview:self.collectionView];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"Center will appear");
}

/*- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"Center did appear");
    
    _personalContent = [NSMutableArray arrayWithCapacity:0];
    
    for (Category* category in [APIHelper sharedInstance].categories) {
        [MLAPI getCategorySearch:category.categoryId limit:kHomeLimitPerCategory site:[APIHelper sharedInstance].siteId block:^(NSArray* responseArray)
         {
             //NSLog(@"response: %@",responseArray);
             for (NSDictionary* productDictionary in responseArray) {
                 MLProduct* product = [[MLProduct alloc] initWithDictionary:productDictionary];
                 
                 NSLog(@"Title: %@",product.title);
                 NSLog(@"Subtitle: %@",product.subtitle);
                 NSLog(@"Thumbnail: %@", product.thumbnail);
                 [_personalContent addObject:product];
             }
             //NSLog(@"----------------------------------------------------------------------");
             //NSLog(@"%@",_personalContent);
             [self updateLayout];
             [_collectionView reloadData];
         }];
    }
}*/

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"Center did appear");
    
    _personalContent = [NSMutableArray arrayWithCapacity:0];
    [self loadSelectedCategories];
}

- (void) loadSelectedCategories
{
    if (categorySelectedIndex < [APIHelper sharedInstance].categories.count) {
        
        Category* category = [[APIHelper sharedInstance].categories objectAtIndex:categorySelectedIndex];
        
        [MLAPI getCategorySearch:category.categoryId limit:kHomeLimitPerCategory site:[APIHelper sharedInstance].siteId block:^(NSArray* responseArray)
         {
             for (NSDictionary* productDictionary in responseArray) {
                 MLProduct* product = [[MLProduct alloc] initWithDictionary:productDictionary];
                 
                 if ([product.title isKindOfClass:[NSNull class]]) {
                     product.title = @"";
                 }
                 
                 if ([product.subtitle isKindOfClass:[NSNull class]]) {
                     product.subtitle = @"";
                 }
                 
                 if ([product.thumbnail isKindOfClass:[NSNull class]]) {
                     product.thumbnail = @"";
                 }
                 
                 if ([product.price isKindOfClass:[NSNull class]]) {
                     product.price = [NSNumber numberWithInt:0];
                 }
                 
                 NSLog(@"Title: %@",product.title);
                 NSLog(@"Subtitle: %@",product.subtitle);
                 NSLog(@"Thumbnail: %@", product.thumbnail);
                 [_personalContent addObject:product];
             }
         
             categorySelectedIndex++;
             [self loadSelectedCategories];
         }];
    }else{
        [self updateLayout];
        [_collectionView reloadData];
    }
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"Center will disappear");
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"Center did disappear");
    
    categorySelectedIndex = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupLeftMenuButton
{
    MMDrawerBarButtonItem* leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

#pragma mark -
#pragma mark Button handlers

- (void) leftDrawerButtonPress:(id)sender
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void) doubleTap:(UITapGestureRecognizer*)gesture
{
    [self.mm_drawerController  bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}

#pragma mark -
#pragma mark collectionview

- (void)updateLayout {
	CHTCollectionViewWaterfallLayout *layout =
    (CHTCollectionViewWaterfallLayout *)self.collectionView.collectionViewLayout;
	layout.columnCount = self.collectionView.bounds.size.width / self.cellWidth;
	//layout.itemWidth = self.cellWidth;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [_personalContent count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	CHTCollectionViewWaterfallCell *cell =
    (CHTCollectionViewWaterfallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                                forIndexPath:indexPath];
    
	//cell.displayString = [NSString stringWithFormat:@"%d", indexPath.row];
    
    MLProduct* product = [_personalContent objectAtIndex:indexPath.row];
    cell.titleString = product.title;
    cell.subtitleString = product.subtitle;
    cell.thumbnailImageName = product.thumbnail;
    cell.priceString = [NSString stringWithFormat:@"$%i",[product.price intValue]];
    [cell.thumbnailImageView setImageWithURL:[NSURL URLWithString:product.thumbnail] placeholderImage:nil];
    //cell.thumbnailImage = [UIImage imageNamed:@"1.jpeg"];
	return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductViewController* productVC = [[ProductViewController alloc] initWithNibName:@"ProductViewController" bundle:nil];
    
    MLProduct* product = [_personalContent objectAtIndex:indexPath.row];
    productVC.productId = product.productId;
    
    [self.navigationController pushViewController:productVC animated:YES];
}

#pragma mark - UICollectionViewWaterfallLayoutDelegate

- (CGFloat) getHeightForItem:(int) index
{
    MLProduct* product = [_personalContent objectAtIndex:index];
    UIView* backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, CELL_WIDTH, 200)];
    
    CGRect frame = CGRectMake(5.0, 105.0, 118.0, 0);
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:frame];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont boldSystemFontOfSize:11];
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UILabel* subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 164.0, 118.0, 0)];
    subtitleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    subtitleLabel.backgroundColor = [UIColor clearColor];
    subtitleLabel.textColor = [UIColor black75PercentColor];
    subtitleLabel.textAlignment = NSTextAlignmentLeft;
    subtitleLabel.numberOfLines = 0;
    subtitleLabel.font = [UIFont systemFontOfSize:11];
    subtitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    UILabel* priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 234.0, 104, 24.0)];
    priceLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.textColor = [UIColor blackColor];
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.numberOfLines = 1;
    priceLabel.font = [UIFont boldSystemFontOfSize:13];
    
    [backgroundView addSubview:titleLabel];
    [backgroundView addSubview:subtitleLabel];
    [backgroundView addSubview:priceLabel];
    
    CGSize maximumLabelSize = CGSizeMake(129, 999);
    CGSize expectedLabelSize = [product.title sizeWithFont:titleLabel.font constrainedToSize:maximumLabelSize lineBreakMode:titleLabel.lineBreakMode];
    CGRect newFrame = titleLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    titleLabel.frame = newFrame;
    //---
    
    CGSize maximumSubtitleSize = CGSizeMake(129, 999);
    CGSize expectedSubtitleLabelSize = [product.subtitle sizeWithFont:subtitleLabel.font constrainedToSize:maximumSubtitleSize lineBreakMode:subtitleLabel.lineBreakMode];
    CGRect titleFrame = titleLabel.frame;
    CGRect newSubtitleFrame = subtitleLabel.frame;
    newSubtitleFrame.origin.y = titleFrame.origin.y + titleFrame.size.height + 5;
    newSubtitleFrame.size.height = expectedSubtitleLabelSize.height;
    subtitleLabel.frame = newSubtitleFrame;
    
    // ---
    
    CGRect subtitleFrame = subtitleLabel.frame;
    CGRect newPriceFrame = subtitleLabel.frame;
    newPriceFrame.origin.y = subtitleFrame.origin.y + subtitleFrame.size.height + 10;
    priceLabel.frame = newPriceFrame;
    
    return priceLabel.frame.origin.y + priceLabel.frame.size.height + 7;
}

- (CGFloat)   collectionView:(UICollectionView *)collectionView
                      layout:(CHTCollectionViewWaterfallLayout *)collectionViewLayout
    heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self getHeightForItem:indexPath.row];
    
    //return 235.0;
	//return [self.cellHeights[indexPath.item] floatValue];
}

@end

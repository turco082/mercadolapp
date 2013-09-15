//
//  SearchViewController.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "SearchViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

#import "Category.h"
#import "MLProduct.h"
#import "UIImageView+AFNetworking.h"
#import "MLLogoView.h"

#import "ProductViewController.h"

#define kHomeLimitPerCategory 25
#define CELL_WIDTH 129
#define CELL_IDENTIFIER @"WaterfallCell"

@interface SearchViewController ()
@property (nonatomic, strong) NSMutableArray *cellHeights;
@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.cellWidth = CELL_WIDTH;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self.view setBackgroundColor:[UIColor beigeColor]];
    
    //UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToResign)];
    //[singleTap setNumberOfTapsRequired:1];
    //[self.view addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer* doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToResign)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
    
    [self setupLeftMenuButton];
    
    [self.navigationController.navigationBar setTintColor:[UIColor skyeBlueColor]];
    
    MLLogoView * logo = [[MLLogoView alloc] initWithFrame:CGRectMake(0, 0, 29, 31)];
    [self.navigationItem setTitleView:logo];
    [self.navigationController.view.layer setCornerRadius:10.0f];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 44.0)];
    [_searchBar sizeToFit];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"Search";
    [self.view addSubview:_searchBar];
    
    
    [self.collectionView setBackgroundColor:[UIColor beigeColor]];
    [self.view addSubview:self.collectionView];
    
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
#pragma mark private methods

- (void) tapToResign{
    [self.searchBar resignFirstResponder];
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

#pragma searchbar delegate methods

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    _personalContent = [NSMutableArray arrayWithCapacity:0];
    
    [MLAPI getProductsBySearch:searchBar.text limit:kHomeLimitPerCategory site:[APIHelper sharedInstance].siteId block:^(NSArray* responseArray){
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
        
        [self updateLayout];
        [_collectionView reloadData];
    }];
    
}

#pragma mark - Accessors
- (UICollectionView *)collectionView {
	if (!_collectionView) {
		CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        
		layout.sectionInset = UIEdgeInsetsMake(9, 9, 9, 9);
		layout.delegate = self;
        
        CGRect frame = CGRectMake(0.0, 44.0, self.view.bounds.size.width, self.view.bounds.size.height - 44);
		_collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
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

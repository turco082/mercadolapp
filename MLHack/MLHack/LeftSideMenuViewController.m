//
//  LeftSideMenuViewController.m
//  SlideMenuTest
//
//  Created by Ramiro Ponce on 09/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "LeftSideMenuViewController.h"

#import "MMSideDrawerTableViewCell.h"

#import "MMSideDrawerSectionHeaderView.h"
#import "MMProfileSideDrawerTableViewCell.h"
#import "SearchViewController.h"
#import "HomeCenterViewController.h"

@interface LeftSideMenuViewController ()

@end

@implementation LeftSideMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // dummy content
    _dummyContent = @[@"My Account", @"Your Home",@"Categories", @"Bookmarks", @"Search"];
    
    CGRect tableFrame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, 250);
    _tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setBounces:NO];
    [self.view addSubview:self.tableView];
    
    [self.tableView setAutoresizesSubviews:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:49.0/255.0
                                                      green:54.0/255.0
                                                       blue:57.0/255.0
                                                      alpha:1.0]];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:77.0/255.0
                                                       green:79.0/255.0
                                                        blue:80.0/255.0
                                                       alpha:1.0]];
    self.drawerWidths = @[@(160),@(200),@(240),@(280)];
    
    [self.view setBackgroundColor:[UIColor colorWithRed:77.0/255.0
                                                  green:79.0/255.0
                                                   blue:80.0/255.0
                                                  alpha:1.0]];

}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    int idx = [[NSUserDefaults standardUserDefaults] integerForKey:@"LeftSideIndexSelected"];
    
    NSIndexPath *ip = [NSIndexPath indexPathForRow:idx inSection:0];
    [self.tableView selectRowAtIndexPath:ip animated:NO scrollPosition:UITableViewScrollPositionNone];
    //[self.tableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.tableView.numberOfSections-1)] withRowAnimation:UITableViewRowAnimationNone];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark search bar delegate methods

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // only show the status bar's cancel button while in edit mode
    //searchBar.showsCancelButton = YES;
    
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    //searchBar.showsCancelButton = NO;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) aSearchBar {
    [aSearchBar resignFirstResponder];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    //if we only try and resignFirstResponder on textField or searchBar,
    //the keyboard will not dissapear (at least not on iPad)!
    return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case MMDrawerSectionOne:
            return [_dummyContent count];
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    MMSideDrawerTableViewCell* cell = (MMSideDrawerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[MMSideDrawerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }
    UIImage* image;
    switch (indexPath.row) {
        case 0:
            image = [UIImage imageNamed:@"MyAccountTabBar.png"];
            break;
        case 1:
            image = [UIImage imageNamed:@"yourHome.png"];
            break;
        case 2:
            image = [UIImage imageNamed:@"CategoriesTabBar.png"];
            break;
        case 3:
            image = [UIImage imageNamed:@"BookmarksTabBar.png"];
            break;
        case 4:
            image = [UIImage imageNamed:@"SearchTabBar.png"];
            break;
        default:
            image = nil;
            break;
    }
    
    if (image) {
        cell.imageView.image = image;
    }
    [cell.textLabel setText:[_dummyContent objectAtIndex:indexPath.row]];
    
    return cell;
}

//- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    MMSideDrawerSectionHeaderView* headerView = [[MMSideDrawerSectionHeaderView alloc]
//                                                 initWithFrame:CGRectMake(0.0,
//                                                                          0.0,
//                                                                          CGRectGetWidth(tableView.bounds),
//                                                                          20.0f)];
//    [headerView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
//    [headerView setTitle:[tableView.dataSource tableView:tableView titleForHeaderInSection:section]];
//    return headerView;
//}
//
//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 23.0;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

#pragma mark - 
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"LeftSideIndexSelected"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // do something
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row) {
        case 1:
        {
            HomeCenterViewController* home = [[HomeCenterViewController alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:home];
            [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
            if(indexPath.row%2==0){
                
            }
        }
            break;
        case 4:
        {
            SearchViewController* search = [[SearchViewController alloc] init];
            UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:search];
            [self.mm_drawerController setCenterViewController:nav withCloseAnimation:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

@end

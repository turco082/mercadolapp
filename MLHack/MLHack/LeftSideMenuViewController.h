//
//  LeftSideMenuViewController.h
//  SlideMenuTest
//
//  Created by Ramiro Ponce on 09/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MMDrawerController.h"

typedef NS_ENUM(NSInteger, MMDrawerSection){
    MMDrawerSectionOne,
    MMDrawerSectionTwo,
    MMDrawerSectionThree,
    MMDrawerSectionFour,
    MMDrawerSectionFive,
    MMDrawerSectionSix,
    MMDrawerSectionSeven,
};

@interface LeftSideMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate ,UITextFieldDelegate>{
    
    NSArray* _dummyContent;
}

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray* drawerWidths;

@end

//
//  SplashViewController.m
//  MLHack
//
//  Created by Ramiro Ponce on 14/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "SplashViewController.h"
#import "CountriesSelectionViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

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
    self.navigationController.navigationBarHidden = YES;
    [self.view setBackgroundColor:[UIColor beigeColor]];
    
    [self performSelector:@selector(runCountrySelection) withObject:nil afterDelay:3.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark private methods

- (void) runCountrySelection
{
    CountriesSelectionViewController* countriesSelection = [[CountriesSelectionViewController alloc] initWithNibName:@"CountriesSelectionViewController" bundle:nil];
    [self.navigationController pushViewController:countriesSelection animated:YES];
}


@end

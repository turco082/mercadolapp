//
//  TestViewController.m
//  MLHack
//
//  Created by Ramiro Ponce on 14/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "TestViewController.h"
#import "SplashViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

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
	
    /*UIApplication *ourApplication = [UIApplication sharedApplication];
    NSString *ourPath = @"https://auth.mercadolibre.com.ar/authorization?response_type=token&client_id=4627455326974502";
    NSURL *ourURL = [NSURL URLWithString:ourPath];
    [ourApplication openURL:ourURL];*/
    
    //SplashViewController* splash = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
    //UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:splash];
    //[self presentViewController:navController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

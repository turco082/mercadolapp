//
//  MLLoginViewController.m
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "MLLoginViewController.h"

@interface MLLoginViewController ()

@end

@implementation MLLoginViewController

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
    
    self.registerButton.buttonColor = [UIColor nephritisColor];
    self.registerButton.shadowColor = [UIColor emerlandColor];
    self.registerButton.shadowHeight = 3.0f;
    self.registerButton.cornerRadius = 6.0f;
    self.registerButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.registerButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.logInButton.buttonColor = [UIColor sunflowerColor];
    self.logInButton.shadowColor = [UIColor belizeHoleColor];
    self.logInButton.shadowHeight = 3.0f;
    self.logInButton.cornerRadius = 6.0f;
    self.logInButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.logInButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.logInButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.getStartedButton.buttonColor = [UIColor peterRiverColor];
    self.getStartedButton.shadowColor = [UIColor belizeHoleColor];
    self.getStartedButton.shadowHeight = 3.0f;
    self.getStartedButton.cornerRadius = 6.0f;
    self.getStartedButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.getStartedButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.getStartedButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark action methods

- (IBAction)registerButtonAction:(id)sender
{
    // do something
}

- (IBAction)logInButtonAction:(id)sender
{
    UIApplication *ourApplication = [UIApplication sharedApplication];
    NSString *ourPath = @"https://auth.mercadolibre.com.ar/authorization?response_type=token&client_id=4627455326974502";
    NSURL *ourURL = [NSURL URLWithString:ourPath];
    [ourApplication openURL:ourURL];
}

- (IBAction)getStartedButtonAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

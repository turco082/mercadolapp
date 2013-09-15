//
//  MLLoginViewController.h
//  MLHack
//
//  Created by Ramiro Ponce on 15/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatUIKit.h"
#import "FUIButton.h"

@interface MLLoginViewController : UIViewController

@property (nonatomic, weak) IBOutlet FUIButton* registerButton;
@property (nonatomic, weak) IBOutlet FUIButton* logInButton;
@property (nonatomic, weak) IBOutlet FUIButton* getStartedButton;

- (IBAction)registerButtonAction:(id)sender;
- (IBAction)logInButtonAction:(id)sender;
- (IBAction)getStartedButtonAction:(id)sender;

@end

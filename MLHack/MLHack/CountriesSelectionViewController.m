//
//  CountriesSelectionViewController.m
//  MLHack
//
//  Created by Ramiro Ponce on 14/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "CountriesSelectionViewController.h"
#import "Sites.h"
#import "CategorySelectionViewController.h"

@interface CountriesSelectionViewController ()

@end

@implementation CountriesSelectionViewController

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
    
    MLNavigationBar* navBar = [[MLNavigationBar alloc] init];
    navBar.titleLabel.text = @"Select your country";
    navBar.backButton.hidden = YES;
    navBar.doneButton.hidden = YES;
    [self.view addSubview:navBar];
    
    [self.view setBackgroundColor:[UIColor beigeColor]];
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 44.0, self.view.bounds.size.width, self.view.bounds.size.height - 44)];
    [self.view addSubview:_scroll];
    
    //[self testLlamadaTurco];
    
    NSURL *url = [NSURL URLWithString:ML_BASE_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    self.sites = [[NSMutableArray alloc] init];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for (NSDictionary* dic in JSON) {
            Sites* site = [[Sites alloc] initWithDictionary:dic];
            [self.sites addObject:site];
        }
        [self createButtons];
    } failure:nil];
    
    [operation start];
    
}

- (void) testLlamadaTurco
{
    NSString* stringURL = @"http://turdev.host56.com/getitemfromcategories.php?param1=MLA5726&param2=MLA5726&param3=MLA5726&param4=MLA5726&param5=MLA5726&sites=MLA";
    
    NSLog(@"stringURL: %@",stringURL);
    
    NSURL *url = [NSURL URLWithString:stringURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"JSON: %@", JSON);
    } failure:nil];
    [operation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
#pragma mark private methods

- (void)flagButtonAction:(id)sender
{
    UIButton* button = (UIButton*)sender;
    NSLog(@"Button Tag: %i", button.tag);
    
    Sites* site = [self.sites objectAtIndex:button.tag];
    [APIHelper sharedInstance].siteId = site.siteId;
    [APIHelper sharedInstance].siteName = site.name;
    
    CategorySelectionViewController* category = [[CategorySelectionViewController alloc] initWithNibName:@"CategorySelectionViewController" bundle:nil];
    [self.navigationController pushViewController:category animated:YES];
}

- (void)labelAction:(id)sender
{
    UILabel* label = (UILabel*)sender;
    NSLog(@"Label Tag: %i", label.tag);
}

- (void) createButtons
{
    CGFloat xPos = 15.0;
    CGFloat yPos = 15.0;
    for (int i = 0 ; i < [self.sites count]; i++)
    {
        Sites* site = [self.sites objectAtIndex:i];
        UIButton* flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [flagButton setFrame:CGRectMake(xPos, yPos, 32.0, 32.0)];
        flagButton.tag = i;
        [flagButton addTarget:self action:@selector(flagButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [flagButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",site.siteId]] forState:UIControlStateNormal];
        [_scroll addSubview:flagButton];
        
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos + flagButton.bounds.size.width + 10,
                                                                  yPos + 10 , 100.0, 20.0)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        [nameLabel setFont:[UIFont boldSystemFontOfSize:12]];
        nameLabel.text = site.name;
        
        //[nameLabel setUserInteractionEnabled:YES];
        //UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelAction:)];
        //tap.numberOfTapsRequired = 1;
        //[nameLabel addGestureRecognizer:tap];
        
        [_scroll addSubview:nameLabel];
        
        if ((i + 1) % 2 == 0) {
            xPos = 15.0;
            yPos = yPos + 64;
        }else
            xPos = 175;
    }
    
    [_scroll setContentSize:CGSizeMake(self.view.bounds.size.width, yPos + 20)];
}

@end

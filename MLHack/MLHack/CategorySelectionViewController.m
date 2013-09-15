//
//  CategorySelectionViewController.m
//  MLHack
//
//  Created by Ramiro Ponce on 14/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "CategorySelectionViewController.h"
#import "FlatUIKit.h" 
#import "FUIButton.h"
#import "Category.h"
#import "MLLoginViewController.h"

@interface CategorySelectionViewController ()

@end

@implementation CategorySelectionViewController

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
    navBar.titleLabel.text = @"Select your fav categories";
    navBar.delegate = self;
    [self.view addSubview:navBar];
    
    [self.view setBackgroundColor:[UIColor beigeColor]];
    
    UISwipeGestureRecognizer* swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    [self.view addGestureRecognizer:swipe];
    
    _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 44.0, self.view.bounds.size.width, self.view.bounds.size.height - 44)];
    [self.view addSubview:_scroll];
    
    self.categories = [[NSMutableArray alloc] init];
    
    NSString* urlString = [NSString stringWithFormat:@"%@%@/categories",ML_BASE_URL, [APIHelper sharedInstance].siteId];
    NSLog(@"URL STRING: %@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        //NSLog(@"JSON: %@",JSON);
        
        for (NSDictionary* dic in JSON) {
            Category* category = [[Category alloc] initWithDictionary:dic];
            [self.categories addObject:category];
        }
        
        self.categories_aux = [[NSMutableArray alloc] initWithArray:self.categories];
        [self createButtons];
        
        //NSLog(@"A verga: %@", [JSON valueForKeyPath:@"origin"]);
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

- (void) saveCategoryItem:(int)categoryIdx
{
    
}

- (void) removeCategoryItem:(int)categoryIdx
{
    
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)buttonAction:(id)sender{
    FUIButton* button = (FUIButton*)sender;
    [button setSelected:!button.isSelected];
    
    Category* category = [self.categories_aux objectAtIndex:button.tag];
    
    if (button.isSelected) {
        category.isSeleted = YES;
        button.buttonColor = [UIColor turquoiseColor];
        button.shadowColor = [UIColor greenSeaColor];
    }else{
        category.isSeleted = NO;
        button.buttonColor = [UIColor silverColor];
        button.shadowColor = [UIColor concreteColor];
    }
    
    [self.categories_aux removeObjectAtIndex:button.tag];
    [self.categories_aux insertObject:category atIndex:button.tag];
}

- (void) createButtons
{
    
    CGFloat xPos = 15.0;
    CGFloat yPos = 15.0;
    for (int i = 0 ; i < [self.categories count]; i++){
        Category* category = [self.categories objectAtIndex:i];
        FUIButton* button = [[FUIButton alloc] initWithFrame:CGRectMake(xPos, yPos, 130.0, 44.0)];
        button.tag = i;
        button.buttonColor = [UIColor silverColor];
        button.shadowColor = [UIColor concreteColor];
        button.shadowHeight = 3.0f;
        button.cornerRadius = 6.0f;
        [button.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
        button.titleLabel.numberOfLines = 0;
        button.titleLabel.font = [UIFont boldFlatFontOfSize:13];
        [button setTitle:category.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [button setSelected:NO];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_scroll addSubview:button];
        if ((i + 1) % 2 == 0) {
            xPos = 15.0;
            yPos = yPos + 64;
        }else
            xPos = 175;
    }
    
    [_scroll setContentSize:CGSizeMake(self.view.bounds.size.width, yPos + 20)];
}

#pragma mark -
#pragma mark MLNavigationBarDelegate methods

- (void) backButtonPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) doneButtonPressed
{
    NSMutableArray* categoriesSelected = [NSMutableArray arrayWithCapacity:0];
    
    for (Category* category in self.categories_aux) {
        if (category.isSeleted == YES) {
            [categoriesSelected addObject:category];
        }
    }
    
    [APIHelper sharedInstance].categories = [[NSArray alloc] initWithArray:categoriesSelected];
    
    // imprimos los selecionados
    NSLog(@"Categorias seleccionadas:");
    for (Category* category in categoriesSelected) {
        NSLog(@"id: %@ | name: %@",category.categoryId, category.name);
    }
    
    MLLoginViewController* loginVC = [[MLLoginViewController alloc]
                                      initWithNibName:@"MLLoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end

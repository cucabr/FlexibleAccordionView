//
//  ViewController.m
//  FlexibleAccordionView
//
//  Created by André Augusto Estevão on 7/20/17.
//  Copyright © 2017 André Augusto. All rights reserved.
//

#import "ViewController.h"

#import "ItemHeader.h"
#import "ItemPanel.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize accordionView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [accordionView setAllowsMultipleSelection:NO];
    //[accordionView setAllowsEmptySelection:NO];
    [accordionView setStartsClosed:YES];
    
    [accordionView setDelegate:self];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateViewConstraints];
    
    // don't forget to set NO in "Under Top Bars" and "Under Bottom Bars" in View Controller
    for(int i = 0; i <= 10; i++) {
        [self addItem1];
        [self addItem2];
    }
}

- (void)addItem1
{
    ItemHeader *headerView = [[ItemHeader alloc] init];
    [headerView customInit:@"green"];
    
    ItemPanel *panelView = [[ItemPanel alloc] init];
    [panelView.title setText:@"Panel 1"];
    
    [accordionView addHeader:headerView withView:panelView];
}

- (void)addItem2
{
    ItemHeader *headerView = [[ItemHeader alloc] init];
    [headerView customInit:@"red"];
    
    ItemPanel *panelView = [[ItemPanel alloc] init];
    [panelView.title setText:@"Panel 2"];
    
    [accordionView addHeader:headerView withView:panelView];
}

- (void)accordion:(FlexibleAccordionView *)accordion didChangeSelection:(NSIndexSet *)selection openOrClosed:(BOOL)openOrClosed
{
    //
}

@end

//
//  Item2Header.m
//  FlexibleAccordionView
//
//  Created by André Augusto Estevão on 7/20/17.
//  Copyright © 2017 André Augusto. All rights reserved.
//

#import "ItemHeader.h"
#import "FlexibleAccordionView.h"

@implementation ItemHeader

@synthesize borderColorValue, innerView, openAndClose, title;

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self = [self initializeSubviews];
    }
    return self;
}

-(instancetype)initializeSubviews {
    id view =   [[[NSBundle mainBundle] loadNibNamed:@"ItemHeader"  owner:self options:nil] firstObject];
    
    return view;
}

-(void)customInit:(NSString *)color
{
    if([color isEqualToString:@"red"]) {
        borderColorValue = [UIColor colorWithRed:0.73 green:0.01 blue:0.01 alpha:1.0];
    } else if([color isEqualToString:@"green"]) {
        borderColorValue = [UIColor colorWithRed:0.13 green:0.41 blue:0.01 alpha:1.0];
        
    }
    
    innerView.layer.borderColor = borderColorValue.CGColor;
    innerView.layer.borderWidth = 2.3f;
    
    openAndClose.image = [openAndClose.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [openAndClose setTintColor:borderColorValue];
    
    [title setTextColor:borderColorValue];
}

- (IBAction)touchDown:(id)sender {
    [((FlexibleAccordionView*)self.superview.superview) buttonClick:self completion:^(NSString *openOrClosed) {
        NSLog(@"here");
        
        if([openOrClosed isEqualToString:@"opened"]) {
            innerView.backgroundColor = borderColorValue;
            [title setTextColor:[UIColor whiteColor]];
            
            [openAndClose setImage:[UIImage imageNamed:@"accordion_minus"]];
            openAndClose.image = [openAndClose.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [openAndClose setTintColor:[UIColor whiteColor]];
        } else {
            innerView.backgroundColor =  [UIColor whiteColor];
            [title setTextColor:borderColorValue];
            
            
            [openAndClose setImage:[UIImage imageNamed:@"accordion_plus"]];
            openAndClose.image = [openAndClose.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            [openAndClose setTintColor:borderColorValue];
        }
    }];
     
     
}

@end

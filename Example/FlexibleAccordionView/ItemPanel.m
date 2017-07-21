//
//  Item2Panel.m
//  FlexibleAccordionView
//
//  Created by André Augusto Estevão on 7/20/17.
//  Copyright © 2017 André Augusto. All rights reserved.
//

#import "ItemPanel.h"

@implementation ItemPanel

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
    id view =   [[[NSBundle mainBundle] loadNibNamed:@"ItemPanel"  owner:self options:nil] firstObject];
    
    return view;
}

@end

//
//  UIScrollView+AutoLayout.m
//  FlexibleAccordionView
//
//  Created by André Augusto Estevão on 7/20/17.
//  Copyright © 2017 André Augusto. All rights reserved.
//

#import "UIScrollView+AutoLayout.h"

@implementation UIScrollView(AutoLayout)

+ (UIScrollView *)autoLayoutScrollView {
    UIScrollView* view = [[UIScrollView alloc] init];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

- (void) adjustConstraints
{
    NSDictionary* views = @{@"scrollView": self};
    NSString* format = @"H:|[scrollView]|";
    NSArray* constraints = [NSLayoutConstraint constraintsWithVisualFormat:format
                                                                   options:0
                                                                   metrics:nil
                                                                     views:views];
    [self.superview addConstraints:constraints];
    
    format = @"V:|[scrollView]|";
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:format
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    [self.superview addConstraints:constraints];
}

@end

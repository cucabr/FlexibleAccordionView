//
//  UIScrollView+AutoLayout.h
//  FlexibleAccordionView
//
//  Created by André Augusto Estevão on 7/20/17.
//  Copyright © 2017 André Augusto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView(AutoLayout)

+ (UIScrollView *)autoLayoutScrollView;

- (void) adjustConstraints;

@end

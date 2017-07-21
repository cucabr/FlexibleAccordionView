//
//  ViewController.h
//  FlexibleAccordionView
//
//  Created by André Augusto Estevão on 7/20/17.
//  Copyright © 2017 André Augusto. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FlexibleAccordionView.h"

@interface ViewController : UIViewController<FlexibleAccordionViewDelegate>

@property (nonatomic, retain) IBOutlet FlexibleAccordionView *accordionView;

@end


//
//  Item2Header.h
//  FlexibleAccordionView
//
//  Created by André Augusto Estevão on 7/20/17.
//  Copyright © 2017 André Augusto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemHeader : UIView

@property (nonatomic) UIColor *borderColorValue;

@property (nonatomic, retain) IBOutlet UIView *innerView;

@property (nonatomic, retain) IBOutlet UIImageView *openAndClose;

@property (nonatomic, retain) IBOutlet UILabel *title;

-(void)customInit:(NSString *)color;

@end

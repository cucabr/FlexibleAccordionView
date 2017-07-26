//
//  FlexibleAccordionView.h
//  FlexibleAccordionView
//
//  Created by André Augusto Estevão on 7/20/17.
//  Copyright © 2017 André Augusto. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIScrollView+AutoLayout.h"

@class FlexibleAccordionView;

@protocol FlexibleAccordionViewDelegate <NSObject>
@optional
- (void)accordion:(FlexibleAccordionView *)accordion didChangeSelection:(NSIndexSet *)selection openOrClosed:(BOOL)openOrClosed;
@end

@interface FlexibleAccordionView : UIView <UIScrollViewDelegate> {
    NSMutableArray *views;
    NSMutableArray *headers;
    NSMutableArray *originalSizes;
}

typedef void (^ButtonClickCompletionBlock)(NSString *openOrClosed);
    
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSIndexSet *selectionIndexes;
@property (nonatomic, assign) BOOL startsClosed;
@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, assign) BOOL autoScrollToTopOnSelect;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) UIViewAnimationCurve animationCurve;
@property (nonatomic, strong) id <FlexibleAccordionViewDelegate> delegate;

- (id)addHeader:(UIView *)aHeader withView:(id)aView;
- (void)buttonClick:(id)sender completion:(ButtonClickCompletionBlock)completion;

@end

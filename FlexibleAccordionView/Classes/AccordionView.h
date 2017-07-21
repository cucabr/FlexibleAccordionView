/*
    AccordionView.h

    Modified by Andre
*/

#import <UIKit/UIKit.h>

#import "UIScrollView+AutoLayout.h"


@class AccordionView;
@protocol AccordionViewDelegate <NSObject>
@optional
- (void)accordion:(AccordionView *)accordion didChangeSelection:(NSIndexSet *)selection;
@end

typedef void (^AccordionCompletionBlock)(NSString *openAndClosed);

@interface AccordionView : UIView <UIScrollViewDelegate> {
    NSMutableArray *views;
    NSMutableArray *headers;
    NSMutableArray *originalSizes;
}

- (unsigned long)addHeader:(UIView *)aHeader withView:(id)aView;
- (void)removeHeaderAtIndex:(NSInteger)index;
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView;
- (void)setSelectionIndexes:(NSIndexSet *)aSelectionIndexes; //modificado por Andre
- (void)buttonClick:(id)sender completion:(AccordionCompletionBlock)completion;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (readonly) BOOL isHorizontal;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) UIViewAnimationCurve animationCurve;
@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, strong) NSIndexSet *selectionIndexes;
@property (nonatomic, strong) id <AccordionViewDelegate> delegate;
@property (nonatomic, assign) BOOL startsClosed;
@property (nonatomic, assign) BOOL allowsEmptySelection;
@property (nonatomic, assign) BOOL autoScrollToTopOnSelect;

@end

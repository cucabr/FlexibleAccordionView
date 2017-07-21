//
//  FlexibleAccordionView.m
//  FlexibleAccordionView
//
//  Created by André Augusto Estevão on 7/20/17.
//  Copyright © 2017 André Augusto. All rights reserved.
//

#import "FlexibleAccordionView.h"

@implementation FlexibleAccordionView

@synthesize scrollView, allowsMultipleSelection, startsClosed, selectionIndexes, animationCurve, animationDuration, delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initAccordion];
    }
    
    return self;
}
/***
 NIB constructor
 **/
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initAccordion];
    }
    
    return self;
}

-(void)initAccordion
{
    views = [NSMutableArray new];
    headers = [NSMutableArray new];
    originalSizes = [NSMutableArray new];
    
    scrollView = [UIScrollView autoLayoutScrollView];
    scrollView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:scrollView];
    [scrollView adjustConstraints];
    
    self.userInteractionEnabled = YES;
    
    animationDuration = 0.3;
    animationCurve = UIViewAnimationCurveEaseIn;
    
    scrollView.userInteractionEnabled = YES;
    scrollView.autoresizesSubviews = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    self.allowsMultipleSelection = NO;
    self.startsClosed = NO;
    //self.allowsEmptySelection = YES;
}

- (unsigned long)addHeader:(UIView *)aHeader withView:(id)aView {
    if ((aHeader != nil) && (aView != nil)) {
        [headers addObject:aHeader];
        [views addObject:aView];
        [originalSizes addObject:[NSValue valueWithCGSize:[aView frame].size]];
        
        [aView setAutoresizingMask:UIViewAutoresizingNone];
        [aView setClipsToBounds:YES];
        
        CGRect frame = [aHeader frame];
        
        frame.origin.x = 0;
        frame.size.width = [self frame].size.width;
        [aHeader setFrame:frame];
        
        frame = [aView frame];
        frame.origin.x = 0;
        frame.size.width = [self frame].size.width;
        [aView setFrame:frame];
        
        [scrollView addSubview:aView];
        [scrollView addSubview:aHeader];
       
        [aHeader setTag:[headers count] - 1];
        
        if (!self.startsClosed && [selectionIndexes count] == 0) {
            [self setSelectedIndex:0];
        }
        
        [self setNeedsLayout];
    }
    
    return 0;
}

- (void)removeHeaderAtIndex:(NSInteger)index {
    if (index > [headers count] - 1) return;
    
    NSMutableIndexSet *cleanIndexes = [NSMutableIndexSet new];
    [selectionIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (idx == index) return;
        if (idx > index) idx--;
        
        [cleanIndexes addIndex:idx];
    }];
    
    for (UIView *aHeader in headers) {
        if (aHeader.tag > index) {
            aHeader.tag--;
        }
    }
    UIView *aHeader = [headers objectAtIndex:index];
    [aHeader removeFromSuperview];
    [headers removeObjectAtIndex:index];
    
    
    UIView *aView = [views objectAtIndex:index];
    [aView removeFromSuperview];
    [views removeObjectAtIndex:index];
    
    [originalSizes removeObjectAtIndex:index];
    
    [self setSelectionIndexes:cleanIndexes];
}

- (void)setSelectionIndexes:(NSIndexSet *)aSelectionIndexes {
    if ([headers count] == 0) return;
    if (!allowsMultipleSelection && [aSelectionIndexes count] > 1) {
        aSelectionIndexes = [NSIndexSet indexSetWithIndex:[aSelectionIndexes firstIndex]];
    }
    
    NSMutableIndexSet *cleanIndexes = [NSMutableIndexSet new];
    [aSelectionIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (idx > [headers count] - 1) return;
        
        [cleanIndexes addIndex:idx];
    }];
    
    selectionIndexes = cleanIndexes;
    [self setNeedsLayout];
    
    if ([delegate respondsToSelector:@selector(accordion:didChangeSelection:openOrClosed:)]) {
        [delegate accordion:self didChangeSelection:self.selectionIndexes openOrClosed:YES];
    }
}

- (void)setSelectedIndex:(NSInteger)aSelectedIndex {
    [self setSelectionIndexes:[NSIndexSet indexSetWithIndex:aSelectedIndex]];
}

- (NSInteger)selectedIndex {
    return [selectionIndexes firstIndex];
}

- (void)setOriginalSize:(CGSize)size forIndex:(NSUInteger)index {
    if (index >= [views count]) return;
    
    [originalSizes replaceObjectAtIndex:index withObject:[NSValue valueWithCGSize:size]];
    
    if ([selectionIndexes containsIndex:index]) [self setNeedsLayout];
}

- (void)setStartsClosed:(BOOL)itStartsClosed {
    if (itStartsClosed) {
        [self setSelectionIndexes:[NSIndexSet indexSet]];
    }
    
    startsClosed = itStartsClosed;
}

- (void)animationDone {
    for (int i=0; i<[views count]; i++) {
        if (![selectionIndexes containsIndex:i]) [[views objectAtIndex:i] setHidden:YES];
    }
}

- (void)layoutSubviews {
    int height = 0;
    for (int i=0; i<[views count]; i++) {
        id aHeader = [headers objectAtIndex:i];
        id aView = [views objectAtIndex:i];
        
        CGSize originalSize = [[originalSizes objectAtIndex:i] CGSizeValue];
        CGRect viewFrame = [aView frame];
        CGRect headerFrame = [aHeader frame];
        headerFrame.origin.y = height;
        height += headerFrame.size.height;
        viewFrame.origin.y = height;
        
        if ([selectionIndexes containsIndex:i]) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:self.animationDuration];
            [UIView setAnimationCurve:self.animationCurve];
            [UIView setAnimationBeginsFromCurrentState:YES];
            viewFrame.size.height = originalSize.height;
            [aView setFrame:CGRectMake(0, viewFrame.origin.y, [self frame].size.width, 0)];
            [aView setHidden:NO];
            [UIView commitAnimations];
        } else {
            viewFrame.size.height = 0;
        }
        
        height += viewFrame.size.height;
        
        if (!CGRectEqualToRect([aHeader frame], headerFrame) || !CGRectEqualToRect([aView frame], viewFrame)) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(animationDone)];
            [UIView setAnimationDuration:self.animationDuration];
            [UIView setAnimationCurve:self.animationCurve];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [aHeader setFrame:headerFrame];
            [aView setFrame:viewFrame];
            [UIView commitAnimations];
        }
    }
    
    CGPoint offset = scrollView.contentOffset;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:self.animationDuration];
    [UIView setAnimationCurve:self.animationCurve];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [scrollView setContentSize:CGSizeMake([self frame].size.width, height)];
    [UIView commitAnimations];
    
    
    if (offset.y + scrollView.frame.size.height > height) {
        offset.y = height - scrollView.frame.size.height;
        if (offset.y < 0) {
            offset.y = 0;
        }
    }
    
    if ([selectionIndexes firstIndex] && [selectionIndexes firstIndex] < headers.count && self.autoScrollToTopOnSelect)
    {
        offset = ((UIButton *)headers[[selectionIndexes firstIndex]]).frame.origin;
    }
    
    [scrollView setContentOffset:offset animated:YES];
    [self scrollViewDidScroll:scrollView];
}

#pragma mark UIScrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    int i = 0;
    for (UIView *view in views) {
        if (view.frame.size.height > 0) {
            UIView *header = [headers objectAtIndex:i];
            CGRect content = view.frame;
            content.origin.y -= header.frame.size.height;
            content.size.height += header.frame.size.height;
            
            CGRect frame = header.frame;
            if (CGRectContainsPoint(content, aScrollView.contentOffset)) {
                if (aScrollView.contentOffset.y < content.origin.y + content.size.height - frame.size.height) {
                    frame.origin.y = aScrollView.contentOffset.y;
                } else {
                    frame.origin.y = content.origin.y + content.size.height - frame.size.height;
                }
                
            } else {
                frame.origin.y = view.frame.origin.y - frame.size.height;
            }
            header.frame = frame;
        }

        i++;
    }
}

#pragma button click

- (void)buttonClick:(id)sender completion:(ButtonClickCompletionBlock)completion {
    NSIndexSet *aSelectionIndexes =  [NSIndexSet indexSetWithIndex:[sender tag]];
    
    __block BOOL openOrClosed = false;
    
    if ([headers count] == 0) return;
    if (!allowsMultipleSelection && [aSelectionIndexes count] > 1) {
        aSelectionIndexes = [NSIndexSet indexSetWithIndex:[aSelectionIndexes firstIndex]];
    }
    
    NSMutableIndexSet *cleanIndexes = [NSMutableIndexSet new];
    [aSelectionIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (idx > [headers count] - 1) return;
        
        openOrClosed = [selectionIndexes containsIndex:idx];
        
        if (!openOrClosed) {
            completion(@"opened");
            [cleanIndexes addIndex:idx];
        } else {
            completion(@"closed");
        }
    }];
    
    selectionIndexes = cleanIndexes;
    
    if ([delegate respondsToSelector:@selector(accordion:didChangeSelection:openOrClosed:)]) {
        [delegate accordion:self didChangeSelection:self.selectionIndexes openOrClosed:openOrClosed];
    }
    
    [self setNeedsLayout];
}

@end

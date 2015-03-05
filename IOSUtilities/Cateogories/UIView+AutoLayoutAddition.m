//
//  UIView+AutoLayoutAddition.m
//  P2MSDropdown
//
//  Created by PYAE PHYO MYINT SOE on 2/2/15.
//  Copyright (c) 2015 P2MS. All rights reserved.
//

#import "UIView+AutoLayoutAddition.h"

@implementation UIView (AutoLayoutAddition)

+(id)autolayoutView
{
    UIView *view = [self new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

- (NSLayoutConstraint *)addPaddingWithVisualFormat:(NSString *)visualFormat options:(NSLayoutFormatOptions)option padding:(NSNumber *)padding views:(NSDictionary *)views{
    if (padding) {
        NSDictionary *metrics = @{@"padding": padding };
        visualFormat = [visualFormat stringByReplacingOccurrencesOfString:@"%1" withString:@"padding"];
        NSArray *curConstraints = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:option metrics:metrics views:views];
        [self addConstraints:curConstraints];
        return [curConstraints firstObject];
    }
    return nil;
}

- (NSArray *)setPaddingToSubView:(UIView *)subView left:(NSNumber *)leftPadding right:(NSNumber *)rightPadding top:(NSNumber *)topPadding bottom:(NSNumber *)bottomPadding{
    NSDictionary *views = NSDictionaryOfVariableBindings(subView);
    NSMutableArray *constraintsToReturn = [NSMutableArray array];
    
    //left
    NSLayoutConstraint *leftConstraint = [self addPaddingWithVisualFormat:@"H:|-(%1)-[subView]" options:NSLayoutFormatAlignAllLeading padding:leftPadding views:views];
    if (leftConstraint) {
        [constraintsToReturn addObject:leftConstraint];
    }
    
    //right
    NSLayoutConstraint *rightConstraint = [self addPaddingWithVisualFormat:@"H:[subView]-(%1)-|" options:NSLayoutFormatAlignAllTrailing padding:rightPadding views:views];
    if (rightConstraint) {
        [constraintsToReturn addObject:rightConstraint];
    }
    
    //top
    NSLayoutConstraint *topConstraint = [self addPaddingWithVisualFormat:@"V:|-(%1)-[subView]" options:NSLayoutFormatAlignAllTrailing padding:rightPadding views:views];
    if (topConstraint) {
        [constraintsToReturn addObject:topConstraint];
    }
    
    //bottom
    NSLayoutConstraint *bottomConstraint = [self addPaddingWithVisualFormat:@"V:[subView]-(%1)-|" options:NSLayoutFormatAlignAllTrailing padding:rightPadding views:views];
    if (bottomConstraint) {
        [constraintsToReturn addObject:bottomConstraint];
    }
    return constraintsToReturn;
}

- (NSLayoutConstraint *)setEqualWidthToView:(UIView *)view1 andView:(UIView *)view2{
    NSLayoutConstraint *equalWidthConstraint =[NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    [self addConstraint:equalWidthConstraint];
    return equalWidthConstraint;
}

- (NSLayoutConstraint *)setEqualHeightToView:(UIView *)view1 andView:(UIView *)view2{
    NSLayoutConstraint *equalHeightConstraint =[NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self addConstraint:equalHeightConstraint];
    return equalHeightConstraint;
}

#pragma mark - layout centering in container view
- (NSLayoutConstraint *)setCenterVerticalInContainerForSubView:(UIView *)subView{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f];
    [self addConstraint:constraint];
    return constraint;
}

- (NSLayoutConstraint *)setCenterHorizontalInContainerForSubView:(UIView *)subView{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:subView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f];
    [self addConstraint:constraint];
    return constraint;
}


@end

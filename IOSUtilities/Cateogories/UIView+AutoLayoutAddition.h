//
//  UIView+AutoLayoutAddition.h
//  P2MSDropdown
//
//  Created by PYAE PHYO MYINT SOE on 2/2/15.
//  Copyright (c) 2015 P2MS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AutoLayoutAddition)

+(id)autolayoutView;

- (NSArray *)setPaddingToSubView:(UIView *)subView left:(NSNumber *)leftPadding right:(NSNumber *)rightPadding top:(NSNumber *)topPadding bottom:(NSNumber *)bottomPadding;

- (NSLayoutConstraint *)setEqualWidthToView:(UIView *)view1 andView:(UIView *)view2;
- (NSLayoutConstraint *)setEqualHeightToView:(UIView *)view1 andView:(UIView *)view2;

- (NSLayoutConstraint *)setCenterVerticalInContainerForSubView:(UIView *)subView;
- (NSLayoutConstraint *)setCenterHorizontalInContainerForSubView:(UIView *)subView;

@end

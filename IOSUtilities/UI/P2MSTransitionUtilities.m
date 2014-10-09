//
//  P2MSTransitionUtilities.m
//  IOSUtilities
//
//  Created by PYAE PHYO MYINT SOE on 18/6/14.
//  Copyright (c) 2014 P2MS. All rights reserved.
//

#import "P2MSTransitionUtilities.h"

@implementation P2MSTransitionUtilities

+ (CGRect)convertRect:(CGRect)rect containerRect:(CGRect)containerRect toInterfaceOrientation:(UIInterfaceOrientation)orientation{
    CGRect frame;
    switch (orientation)
    {
        case UIInterfaceOrientationLandscapeRight:
            frame = CGRectMake(containerRect.size.width-rect.origin.y-rect.size.height, rect.origin.x, rect.size.height, rect.size.width); break;
            
        case UIInterfaceOrientationLandscapeLeft:
            frame = CGRectMake(rect.origin.y, (containerRect.size.height-rect.origin.x-rect.size.width), rect.size.height, rect.size.width); break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            frame = CGRectMake(containerRect.size.width-rect.origin.x-rect.size.width, containerRect.size.height-rect.origin.y-rect.size.height, rect.size.width, rect.size.height); break;
            
        case UIInterfaceOrientationPortrait:
            frame = rect; break;
            
        default:
            break;
    }
    return frame;
}

@end

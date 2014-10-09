//
//  P2MSTransitionUtilities.h
//  IOSUtilities
//
//  Created by PYAE PHYO MYINT SOE on 18/6/14.
//  Copyright (c) 2014 P2MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface P2MSTransitionUtilities : NSObject

+ (CGRect)convertRect:(CGRect)rect containerRect:(CGRect)containerRect toInterfaceOrientation:(UIInterfaceOrientation)orientation;

@end

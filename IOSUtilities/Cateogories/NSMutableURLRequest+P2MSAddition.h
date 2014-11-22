//
//  NSMutableURLRequest+P2MSAddition.h
//  IOSUtilities
//
//  Created by PYAE PHYO MYINT SOE on 22/11/14.
//  Copyright (c) 2014 P2MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (P2MSAddition)


- (void)appendUserAgentString:(NSString *)appendString;
- (void)setUserAgentString:(NSString *)appendString;


@end

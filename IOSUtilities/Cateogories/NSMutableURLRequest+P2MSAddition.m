//
//  NSMutableURLRequest+P2MSAddition.m
//  IOSUtilities
//
//  Created by PYAE PHYO MYINT SOE on 22/11/14.
//  Copyright (c) 2014 P2MS. All rights reserved.
//

#import "NSMutableURLRequest+P2MSAddition.h"
#import "NSURLRequest+P2MSAddition.h"

@implementation NSMutableURLRequest (P2MSAddition)


- (void)appendUserAgentString:(NSString *)appendString{
    NSString *defaultUserAgentStr = [NSURLRequest defaultUserAgentString];
    [self setValue:[NSString stringWithFormat:@"%@%@", defaultUserAgentStr, appendString] forHTTPHeaderField:@"User-Agent"];
}

- (void)setUserAgentString:(NSString *)userAgentString{
    [self setValue:userAgentString forHTTPHeaderField:@"User-Agent"];
}

@end

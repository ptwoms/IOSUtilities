//
//  P2MSUserAgentHelper.m
//  IOSUtilities
//
//  Created by PYAE PHYO MYINT SOE on 20/11/14.
//  Copyright (c) 2015 P2MS. All rights reserved.
//

#import "P2MSUserAgentHelper.h"
#import <sys/utsname.h>
#import <net/if.h>
#import <sys/stat.h>

@implementation P2MSUserAgentHelper

+ (NSString *)getUserAgentString{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *systemName = [NSString stringWithCString:systemInfo.sysname encoding:NSUTF8StringEncoding];
    NSString *systemVersion = [NSString stringWithCString:systemInfo.release encoding:NSUTF8StringEncoding];
    NSString *machine = [[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding] lowercaseString];
    NSLog(@"Machine name %@", machine);
    //app info
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *appName = [mainBundle objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey];
    NSString *appBuildNumber = [mainBundle objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    
    return [NSString stringWithFormat:@"%@/%@ %@/%@ %@",[appName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], appBuildNumber, systemName, systemVersion, machine];
}

@end

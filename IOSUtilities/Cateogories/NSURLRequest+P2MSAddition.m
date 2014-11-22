//
//  NSURLRequest+P2MSAddition.m
//  IOSUtilities
//
//  Created by PYAE PHYO MYINT SOE on 22/11/14.
//  Copyright (c) 2014 P2MS. All rights reserved.
//

#import "NSURLRequest+P2MSAddition.h"
#import <sys/utsname.h>


@implementation NSURLRequest (P2MSAddition)

+ (NSString *)defaultUserAgentString{
    //app info
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *appName = [mainBundle objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey];
    NSString *appBuildNumber = [mainBundle objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];

    //CFNetwork info
    NSBundle *cfNetworkBundle = [NSBundle bundleWithIdentifier:@"com.apple.CFNetwork"];
    NSString *cfNetworkBundleVersion = [cfNetworkBundle objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    NSString *cfNetworkBundleName = [cfNetworkBundle objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey];

    //system info
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *systemName = [NSString stringWithCString:systemInfo.sysname encoding:NSUTF8StringEncoding];
    NSString *systemVersion = [NSString stringWithCString:systemInfo.release encoding:NSUTF8StringEncoding];
    
    return [NSString stringWithFormat:@"%@/%@ %@/%@ %@/%@",[appName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], appBuildNumber, cfNetworkBundleName, cfNetworkBundleVersion, systemName, systemVersion];
}

@end

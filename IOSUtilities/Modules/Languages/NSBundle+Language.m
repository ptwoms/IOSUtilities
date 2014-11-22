//
//  NSBundle+Language.m
//  IOSUtilities
//
//  Created by PYAE PHYO MYINT SOE on 14/10/14.
//  Copyright (c) 2014 P2MS. All rights reserved.
//

#import "NSBundle+Language.h"
#import <objc/runtime.h>

static const char _bundle = 0;

//http://stackoverflow.com/questions/1669645/how-to-force-nslocalizedstring-to-use-a-specific-language/20257557#20257557
//https://medium.com/ios-apprentice/working-with-localization-905e4052b9de

@interface BundleEx : NSBundle
@end

@implementation BundleEx

-(NSString*)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName
{
    NSBundle* bundle=objc_getAssociatedObject(self, &_bundle);
    return bundle ? [bundle localizedStringForKey:key value:value table:tableName] : [super localizedStringForKey:key value:value table:tableName];
}

@end


@implementation NSBundle (Language)

+(void)setLanguage:(NSString*)language
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      object_setClass([NSBundle mainBundle],[BundleEx class]);
                  });
    objc_setAssociatedObject([NSBundle mainBundle], &_bundle, language ? [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:language ofType:@"lproj"]] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

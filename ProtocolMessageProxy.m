//
//  ProtocolMessageProxy.m
//  IOSUtilities
//
//  Created by Pyae Phyo Myint Soe on 4/3/15.
//  Copyright (c) 2015 P2MS. All rights reserved.
//

#import "ProtocolMessageProxy.h"
#import <objc/runtime.h>

@interface ProtocolMessageProxy()

@property (nonatomic, strong) NSMutableArray * interceptedProtocols;

@end

@implementation ProtocolMessageProxy

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    if ([self.proxyToDelegate respondsToSelector:aSelector] &&
        [self isSelectorBelongsToInterceptedProtocols:aSelector]){
        return [self.proxyToDelegate methodSignatureForSelector:aSelector];
    }
    if ([self.originalProtocolDelegate respondsToSelector:aSelector])
        [self.originalProtocolDelegate methodSignatureForSelector:aSelector];
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL aSelector = [anInvocation selector];
    //proxy is invoked first, allow overwriting the behavior in user's class
    if ([self.proxyToDelegate respondsToSelector:aSelector] &&
        [self isSelectorBelongsToInterceptedProtocols:aSelector]){
        [anInvocation invokeWithTarget:self.proxyToDelegate];
    }
    if ([self.originalProtocolDelegate respondsToSelector:aSelector])
        [anInvocation invokeWithTarget:self.originalProtocolDelegate];
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([self.proxyToDelegate respondsToSelector:aSelector] &&
        [self isSelectorBelongsToInterceptedProtocols:aSelector])
        return YES;
    
    if ([self.originalProtocolDelegate respondsToSelector:aSelector])
        return YES;
    
    return [super respondsToSelector:aSelector];
}

+ (instancetype)proxyWithInterceptedProtocol:(Protocol *)interceptedProtocol
{
    ProtocolMessageProxy *proxyObj = [[self alloc] init];
    if (proxyObj) {
        proxyObj.interceptedProtocols = [@[interceptedProtocol]mutableCopy];
    }
    return proxyObj;
}

+ (instancetype)proxyWithArrayOfInterceptedProtocols:(NSArray *)arrayOfInterceptedProtocols
{
    ProtocolMessageProxy *proxyObj = [[self alloc] init];
    if (proxyObj) {
        proxyObj.interceptedProtocols = [arrayOfInterceptedProtocols mutableCopy];
    }
    return proxyObj;
}

- (BOOL)isSelectorBelongsToInterceptedProtocols:(SEL)aSelector
{
    __block BOOL isSelectorContainedInInterceptedProtocols = NO;
    [self.interceptedProtocols enumerateObjectsUsingBlock:^(Protocol * protocol, NSUInteger idx, BOOL *stop) {
        isSelectorContainedInInterceptedProtocols = [self isSelector:aSelector belongsToProtocol:protocol];
        *stop = isSelectorContainedInInterceptedProtocols;
    }];
    return isSelectorContainedInInterceptedProtocols;
}

- (BOOL)isSelector:(SEL)selector belongsToProtocol:(Protocol *)protocol{
    
    for (int optionCount = 0; optionCount < 4; optionCount++) {
        //https://gist.github.com/numist/3838169
        BOOL required = optionCount & 1;//00&01 01&01 10&01 11&01 -  N Y N Y
        BOOL instance = !(optionCount & 2);//00&10 01&10 10&10 11&10 - N N Y Y
        struct objc_method_description hasMethod = protocol_getMethodDescription(protocol, selector, required, instance);
        if (hasMethod.name || hasMethod.types) {
            return YES;
        }
    }
    
    return NO;
}

@end
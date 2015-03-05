//
//  ProtocolMessageProxy.h
//  IOSUtilities
//
//  Created by Pyae Phyo Myint Soe on 4/3/15.
//  Copyright (c) 2015 P2MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProtocolMessageProxy : NSObject

@property (nonatomic, weak) id proxyToDelegate;
@property (nonatomic, weak) id originalProtocolDelegate;


+ (instancetype)proxyWithInterceptedProtocol:(Protocol *)interceptedProtocol;
+ (instancetype)proxyWithArrayOfInterceptedProtocols:(NSArray *)arrayOfInterceptedProtocols;

@end

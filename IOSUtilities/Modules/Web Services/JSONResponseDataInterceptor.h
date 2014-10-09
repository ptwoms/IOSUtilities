//
//  JSONResponseDataInterceptor.h
//  IOSUtilities
//
//  Created by PYAE PHYO MYINT SOE on 8/10/14.
//  Copyright (c) 2014 P2MS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONResponseDataInterceptor : NSObject

+ (NSData *)processWebServiceTag:(NSString *)webServiceTag responseData:(NSData *)responseData;

@end

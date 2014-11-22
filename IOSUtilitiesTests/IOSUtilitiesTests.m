//
//  IOSUtilitiesTests.m
//  IOSUtilitiesTests
//
//  Created by PYAE PHYO MYINT SOE on 18/6/14.
//  Copyright (c) 2014 P2MS. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSMutableURLRequest+P2MSAddition.h"
#import "NSURLRequest+P2MSAddition.h"

@interface IOSUtilitiesTests : XCTestCase

@end

@implementation IOSUtilitiesTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNSURLRequestUserAgent
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
    NSMutableURLRequest *newRequest = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.google.com"]];
    NSString *userAgentString = [NSURLRequest defaultUserAgentString];
    [newRequest appendUserAgentString:@" myAppendedString"];
}



@end

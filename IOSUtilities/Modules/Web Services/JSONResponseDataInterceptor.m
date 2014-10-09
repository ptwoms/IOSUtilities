//
//  JSONResponseDataInterceptor.m
//  IOSUtilities
//
//  Created by PYAE PHYO MYINT SOE on 8/10/14.
//  Copyright (c) 2014 P2MS. All rights reserved.
//

#import "JSONResponseDataInterceptor.h"


@implementation JSONResponseDataInterceptor


//reconstruct the object
+ (NSObject *)processDataObject:(NSObject *)dataObject refDictionary:(NSDictionary *)refDictionay{
    if ([dataObject isKindOfClass:[NSArray class]]) {
        NSArray *arrayObject = (NSArray *)dataObject;
        NSMutableArray *newArr = [NSMutableArray arrayWithCapacity:arrayObject.count];
        for (NSObject *curObj in arrayObject) {
            NSObject *tempCurObj = curObj;
            [newArr addObject:[self processDataObject:tempCurObj refDictionary:refDictionay]];
        }
        return newArr;
    }else if ([dataObject isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *newDict = [NSMutableDictionary dictionary];
        NSDictionary *dictionaryObject = (NSDictionary *)dataObject;
        for (NSString *key in dictionaryObject) {
            NSString *refValue = [refDictionay objectForKey:key];
            NSString *keyValue = [dictionaryObject objectForKey:key];
            if (!refValue) {//search for key-value pair
                NSString *keyValPair = [NSString stringWithFormat:@"%@-%@", key, keyValue];
                refValue = [refDictionay objectForKey:keyValPair];
            }
            if (refValue) {
                if ([refValue isEqualToString:@"dosomeoperation"]) {
                    //do some operation here
                }else if ([refValue isEqualToString:@"remove"]){
                    // [newDict setValue:[NSNull null] forKey:key];
                }else{//set the original value
                    [newDict setObject:keyValue forKey:key];
                }
            }else{
                [newDict setObject:[self processDataObject:dataObject refDictionary:refDictionay] forKey:key];
            }
        }
        return newDict;
    }
    //otherwise return the original object
    return dataObject;
}

//intercept json response data, process based on the metadata and return the processed data
+ (NSData *)processWebServiceTag:(NSString *)webServiceTag responseData:(NSData *)responseData{
    NSDictionary *refDictionary = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"JSONResponseDataInterceptorMetaData" ofType:@"json"]] options:kNilOptions error:nil];
    
    NSDictionary *wedServiceTagRefMetaData = [refDictionary objectForKey:webServiceTag];
    if (!wedServiceTagRefMetaData) {
        return responseData;
    }
    NSObject *dataObject = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
    NSObject *processedData = [self processDataObject:dataObject refDictionary:refDictionary];
    return [NSJSONSerialization dataWithJSONObject:processedData options:kNilOptions error:nil];
}

@end

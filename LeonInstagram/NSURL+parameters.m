//
//  NSURL+parameters.m
//  LeonInstagram
//
//  Created by Leon Liang on 1/13/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import "NSURL+parameters.h"

@implementation NSURL (parameters)

-(instancetype) initWithString:(NSString *)URLString relativeToURL:(NSURL *)baseURL withParameterDictionary:(NSDictionary *)parameters
{
    NSMutableArray* params = [NSMutableArray new];
    __block BOOL hasFailed = false;
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if (![key isKindOfClass: [NSObject class]] || ![obj isKindOfClass:[NSObject class]]) {
            hasFailed = true;
        }
        NSObject *oKey = key;
        NSObject *oObj = obj;
        
        NSString *p = [[NSString alloc] initWithFormat: @"%@=%@", oKey, oObj];
        //[params addObject: [p urlEncodedString]];
        [params addObject: p ];
        
        *stop = hasFailed;
    }];
    
    if (hasFailed) {
        return nil;
    }
    
    NSString *url = [@"?" stringByAppendingString: [params componentsJoinedByString: @"&"]];
    
    return [self initWithString: [URLString stringByAppendingString:url] relativeToURL:baseURL];
}


@end

@implementation NSString (URLEscape)

-(NSString *)urlEncodedString
{
    NSString *charactersToEscape = @"!*'();:@&+$,/?%#[]\" ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    
    return [self stringByAddingPercentEncodingWithAllowedCharacters: allowedCharacters];
}

@end
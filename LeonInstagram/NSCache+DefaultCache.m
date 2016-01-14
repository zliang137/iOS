//
//  NSCache+DefaultCache.m
//  LeonInstagram
//
//  Created by Leon Liang on 1/13/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import "NSCache+DefaultCache.h"

@implementation NSCache (DefaultCache)

+(NSCache *)defaultCache
{
    static NSCache* _defaultCache;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultCache = [NSCache new];
    });
    
    return _defaultCache;
}
@end

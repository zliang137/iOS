//
//  InstagramJSONObject.m
//  LeonInstagram
//
//  Created by Leon Liang on 1/13/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import "InstagramJSONObject.h"

#define THUMBNAIL_URL_KEYPATH @"images.thumbnail"
#define LOW_RES_URL_KEYPATH @"images.low_resolution"
#define STANDARD_RES_URL_KEYPATH @"images.standard_resolution"
#define NEXT_URL_KEYPATH @"pagination.next_url"

@interface InstagramJSONObject () {
    NSDictionary *_dict;
}

@end

@implementation InstagramJSONObject


-(instancetype)initWithJSONDictionary: (NSDictionary *)dict
{
    if ((self = [super init])) {
        _dict = dict;
    }
    
    return self;
}

-(NSURL *)imageURLForKeyPath:(NSString *)keyPath
{
    NSString *string = [_dict valueForKeyPath: [keyPath stringByAppendingString:@".url"]];
    return [NSURL URLWithString: string];
}

-(NSURL *)thumbnailURL
{
    return [self imageURLForKeyPath:THUMBNAIL_URL_KEYPATH];
}

-(NSURL *)lowResolutionURL
{
    return [self imageURLForKeyPath:LOW_RES_URL_KEYPATH];
}

-(NSURL *)standardResolutionURL
{
    return [self imageURLForKeyPath:STANDARD_RES_URL_KEYPATH];
}

@end

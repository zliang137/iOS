//
//  InstagramJSONObject.h
//  LeonInstagram
//
//  Created by Leon Liang on 1/13/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstagramJSONObject : NSObject

-(instancetype)initWithJSONDictionary: (NSDictionary *)dict;

@property(nonatomic) NSURL *thumbnailURL;
@property(nonatomic) NSURL *lowResolutionURL;
@property(nonatomic) NSURL *standardResolutionURL;
@end

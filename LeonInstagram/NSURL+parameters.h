//
//  NSURL+parameters.h
//  LeonInstagram
//
//  Created by Leon Liang on 1/13/16.
//  Copyright © 2016 Leon. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface NSURL (parameters)
-(instancetype) initWithString:(NSString *)URLString relativeToURL:(NSURL *)baseURL withParameterDictionary:(NSDictionary *)parameters;


@end

@interface NSString (URLEscape)

-(NSString *)urlEncodedString;

@end
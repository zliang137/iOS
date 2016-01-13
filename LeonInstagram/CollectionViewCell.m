//
//  CollectionViewCell.m
//  LeonInstagram
//
//  Created by Leon Liang on 1/13/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()
@property(nonatomic) NSURLSessionTask *thumbnailTask;
@end

@implementation CollectionViewCell

-(void)configureCell:(NSURL *)url
{
    self.thumbnailTask = [self downloadThumbnail:url];
    [self.thumbnailTask resume];
}

-(NSURLSessionTask *)downloadThumbnail: (NSURL*)url
{
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:[NSURLRequest requestWithURL:url]
completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    UIImage *img = [UIImage imageWithData: data];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.thumbnailImage.image = img;
    });
}];
    return task;
}


-(void)prepareForReuse
{
    [super prepareForReuse];
    [self.thumbnailTask cancel];
}

@end

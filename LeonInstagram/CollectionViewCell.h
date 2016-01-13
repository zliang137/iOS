//
//  CollectionViewCell.h
//  LeonInstagram
//
//  Created by Leon Liang on 1/13/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;

-(void)configureCell:(NSURL *)url;
@end

//
//  ViewController.h
//  LeonInstagram
//
//  Created by Leon Liang on 1/13/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@end


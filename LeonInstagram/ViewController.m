//
//  ViewController.m
//  LeonInstagram
//
//  Created by Leon Liang on 1/13/16.
//  Copyright © 2016 Leon. All rights reserved.
//

#import "ViewController.h"
#import "Keys.h"
#import "NSURL+parameters.h"
#import "InstagramJSONObject.h"
#import "CollectionViewCell.h"
#import "NSCache+DefaultCache.h"

@interface ViewController ()
@property (nonatomic) NSMutableArray* datasource;
@property (nonatomic) NSURL* nextFetchURL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    
    NSURL *urlOfImage = ((InstagramJSONObject *)self.datasource[indexPath.row]).thumbnailURL;
    //NSLog(@"%@", urlOfImage.absoluteString);
    [cell configureCell:urlOfImage];
    
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datasource.count;
}

-(void)fetchJSON: (NSURL *)url
{
    //NSLog(@"%@", url.absoluteString);
    //if ([[NSCache defaultCache] objectForKey:url.absoluteString]) {
    //    return;
    //}
    //[[NSCache defaultCache] setObject:url.absoluteString forKey:url.absoluteString];
    
    NSMutableArray *newIndexPaths = [NSMutableArray new];
    __block NSUInteger startingRow = self.datasource.count;
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    if (error) {
        NSLog(@"%@", error);
    }
    if (res.statusCode >= 400) {
        NSLog(@"Error: status code: %ld", (long)res.statusCode);
    }
    
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    for(NSDictionary* d in (NSArray *)dict[@"data"]) {
        [self.datasource addObject: [[InstagramJSONObject alloc] initWithJSONDictionary: d]];
        [newIndexPaths addObject: [NSIndexPath indexPathForRow:startingRow inSection:0]];
        startingRow ++;
    }
    
    //NSLog(@"Reload Data: count: %ld", self.datasource.count);
    self.nextFetchURL = [NSURL URLWithString:[dict valueForKeyPath: @"pagination.next_url"]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView insertItemsAtIndexPaths: newIndexPaths];
        
    });
    
}];
    
    [task resume];
}

#pragma mark - Scroll view delegates
//infinite scrolling.
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat currentBottomPosition = scrollView.contentOffset.y + scrollView.frame.size.height;
    CGFloat contentBottomPosition = scrollView.contentSize.height;
    static CGFloat lastContentBottomPosition = 0;
    
    if ((currentBottomPosition + scrollView.frame.size.height >= contentBottomPosition)
        && self.nextFetchURL
        && fabs(lastContentBottomPosition - contentBottomPosition) > 1) {
        lastContentBottomPosition = contentBottomPosition;
        [self fetchJSON: self.nextFetchURL];
    }
}

#pragma mark - Searchbar delegates

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.datasource  = [NSMutableArray new];
    NSString *searchString = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *urlStr = [NSString stringWithFormat: BASE_URL, searchString];
    NSURL *baseURL = [[NSURL alloc] initWithString:urlStr];
    
    NSDictionary *dict = @{@"client_id": CLIENT_ID, @"count": BATCH_SIZE};
    NSURL *url = [[NSURL alloc] initWithString:@"" relativeToURL:baseURL withParameterDictionary:dict];
    
    [self fetchJSON: url];
    [searchBar resignFirstResponder];
}

@end

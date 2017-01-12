//
//  TPGCollectionViewDataSource.m
//  Test
//
//  Created by dvt04 on 17/1/12.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "TPGCollectionViewDataSource.h"
#import "TPGTestCollectionViewCell.h"

@implementation TPGCollectionViewDataSource

- (id)initWithDataSource:(NSArray *)arrDataSource cellIdentifier:(NSString *)cellId headerViweIdentifier:(NSString *)headerId
{
    self = [super init];
    if (self) {
        _arrDataSource = arrDataSource;
        _cellId = cellId;
        _headerViewId = headerId;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TPGTestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellId forIndexPath:indexPath];
    [cell reloadTitle:[_arrDataSource objectAtIndex:indexPath.row]];

    return cell;
}

@end
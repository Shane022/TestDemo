//
//  TPGCollectionViewDataSource.m
//  Test
//
//  Created by dvt04 on 17/1/12.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "TPGCollectionViewDataSource.h"
#import "TPGTestCollectionViewCell.h"
#import "TPGHeaderView.h"

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
    return _arrDataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
#if 0
    return _arrDataSource.count-section;
#else
    return 1;
#endif
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TPGTestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellId forIndexPath:indexPath];
    [cell reloadTitle:[_arrDataSource objectAtIndex:indexPath.section]];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TPGHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:_headerViewId forIndexPath:indexPath];
    [headerView reloadTitleName:[_arrDataSource objectAtIndex:indexPath.section]];
    return headerView;
}

@end

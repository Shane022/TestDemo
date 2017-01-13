//
//  TPGCollectionViewDelegate.m
//  Test
//
//  Created by dvt04 on 17/1/12.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "TPGCollectionViewDelegate.h"

@implementation TPGCollectionViewDelegate

- (id)initWithDataSource:(NSArray *)arrDataSource selectBlock:(TapComplete)tapComplete
{
    self = [super init];
    if (self) {
        _arrDataSource = arrDataSource;
        _tapComplete = tapComplete;
    }
    return self;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat gap = 10;
    CGFloat number = 5;
    CGSize size = CGSizeZero;
    size = CGSizeMake((screenSize.width-gap*(number-1+2))/number, 40);
//    size = CGSizeMake(20, 40);
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 40);
    return size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.tapComplete(indexPath, collectionView);
}

@end

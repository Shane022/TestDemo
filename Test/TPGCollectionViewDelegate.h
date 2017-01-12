//
//  TPGCollectionViewDelegate.h
//  Test
//
//  Created by dvt04 on 17/1/12.
//  Copyright © 2017年 suma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^TapComplete)(NSIndexPath *indexPath, UICollectionView *collectionView);
@interface TPGCollectionViewDelegate : NSObject<UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *arrDataSource;
@property (nonatomic, copy) TapComplete tapComplete;

- (id)initWithDataSource:(NSArray *)arrDataSource selectBlock:(TapComplete)tapComplete;

@end

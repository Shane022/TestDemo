//
//  TPGCollectionViewDataSource.h
//  Test
//
//  Created by dvt04 on 17/1/12.
//  Copyright © 2017年 suma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TPGCollectionViewDataSource : NSObject<UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *arrDataSource;
@property (nonatomic, strong) NSString *cellId;
@property (nonatomic, strong) NSString *headerViewId;

- (id)initWithDataSource:(NSArray *)arrDataSource cellIdentifier:(NSString *)cellId headerViweIdentifier:(NSString *)headerId;

@end

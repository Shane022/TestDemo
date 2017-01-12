//
//  TPGTestCollectionViewCell.h
//  Test
//
//  Created by dvt04 on 17/1/12.
//  Copyright © 2017年 suma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPGTestCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;

- (void)reloadTitle:(NSString *)title;

@end

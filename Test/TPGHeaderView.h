//
//  TPGHeaderView.h
//  Test
//
//  Created by dvt04 on 17/1/13.
//  Copyright © 2017年 suma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPGHeaderView : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;

- (void)reloadTitleName:(NSString *)titleName;

@end

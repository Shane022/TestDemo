//
//  TPGHeaderView.m
//  Test
//
//  Created by dvt04 on 17/1/13.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "TPGHeaderView.h"

@implementation TPGHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self= [super initWithFrame:frame];
    if (self) {
        [self setupComponent];
    }
    return self;
}

- (void)setupComponent
{
    self.backgroundColor = [UIColor lightGrayColor];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 0, 120, self.frame.size.height)];
    _titleLabel.textColor = [UIColor blackColor];
    [self addSubview:_titleLabel];
}

- (void)reloadTitleName:(NSString *)titleName
{
    _titleLabel.text = titleName;
}

@end

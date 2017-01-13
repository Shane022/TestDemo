//
//  SecondViewController.m
//  Test
//
//  Created by dvt04 on 17/1/12.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "SecondViewController.h"
#import "TPGCollectionViewDataSource.h"
#import "TPGCollectionViewDelegate.h"
#import "TPGTestCollectionViewCell.h"
#import "TPGHeaderView.h"

static NSString *const cellId = @"cellId";
static NSString *const headerId = @"headerId";

@interface SecondViewController ()

@property (nonatomic, strong) TPGCollectionViewDataSource *dataSource;
@property (nonatomic, strong) TPGCollectionViewDelegate *delegate;
@property (nonatomic, strong) UILabel *alertLabel;

@end

@implementation SecondViewController
{
    UICollectionView *_mainCollectionView;
    NSArray *_arrDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupComponent];
}

- (void)setupComponent
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _arrDataSource = @[@"SourceTree",@"iterm",@"system preference setting",@"sublime text",@"launchpad",@"charles",@"finder",@"google chrome"];
    
    CGFloat labelHeight = 40;
    UIScrollView *baseView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, labelHeight)];
    baseView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:baseView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(baseView.frame)-0.5, baseView.frame.size.width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
    
    CGFloat width = 0;
    CGFloat marginX = 0;
    CGFloat marginTop = 10;
    CGFloat gap = 20;
    for (int i = 0; i < _arrDataSource.count; i++) {
        NSString *str = [_arrDataSource objectAtIndex:i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(marginX, 0, width, labelHeight);
        [btn setTitle:str forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [btn.titleLabel sizeToFit];
        CGRect rect = btn.frame;
        rect.size.width = btn.titleLabel.bounds.size.width;
        [btn setFrame:rect];
        width = rect.size.width+gap;
        marginX += width;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onHitBtnScrollToDesignatedLocation:) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:btn];
        // 加一条分隔线
        if (i == _arrDataSource.count-1) {
            break;
        }
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn.frame)+gap/2, marginTop, 0.5, labelHeight-marginTop*2)];
        lineView.backgroundColor = [UIColor grayColor];
        [baseView addSubview:lineView];
    }
    baseView.contentSize = CGSizeMake(marginX, baseView.contentSize.height);
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(baseView.frame), self.view.frame.size.width, self.view.frame.size.height-64-baseView.frame.size.height) collectionViewLayout:layout];
    _mainCollectionView.backgroundColor = [UIColor clearColor];
    [_mainCollectionView registerClass:[TPGTestCollectionViewCell class] forCellWithReuseIdentifier:cellId];
    [_mainCollectionView registerClass:[TPGHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    _mainCollectionView.dataSource = self.dataSource;
    _mainCollectionView.delegate = self.delegate;
    [self.view addSubview:_mainCollectionView];
    
    _alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    _alertLabel.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [_alertLabel setTextAlignment:NSTextAlignmentCenter];
    [_alertLabel setBackgroundColor:[UIColor lightGrayColor]];
    [_alertLabel setTextColor:[UIColor whiteColor]];
    [_alertLabel setFont:[UIFont systemFontOfSize:14.f]];
    _alertLabel.alpha = 0.0;
    [self.view addSubview:_alertLabel];
}

- (TPGCollectionViewDataSource *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [[TPGCollectionViewDataSource alloc] initWithDataSource:_arrDataSource cellIdentifier:cellId headerViweIdentifier:headerId];
    }
    return _dataSource;
}

- (TPGCollectionViewDelegate *)delegate
{
    if (nil == _delegate) {
        __weak typeof(self) weakSelf = self;
        _delegate = [[TPGCollectionViewDelegate alloc] initWithDataSource:_arrDataSource selectBlock:^(NSIndexPath *indexPath, UICollectionView *collectionView) {
            [weakSelf showAlertWithTitle:[NSString stringWithFormat:@"curIdx %ld",indexPath.section]];
        }];
    }
    return _delegate;
}

- (void)showAlertWithTitle:(NSString *)title
{
    _alertLabel.text = title;
    _alertLabel.alpha = 1;
    [UIView animateWithDuration:1 animations:^{
        _alertLabel.alpha = 0;
    }];
}

- (void)onHitBtnScrollToDesignatedLocation:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:[_arrDataSource indexOfObject:btn.titleLabel.text]];
    UICollectionViewLayoutAttributes *attributes = [_mainCollectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGRect rect = attributes.frame;
    CGFloat headerViewHeight = 40;
    [_mainCollectionView setContentOffset:CGPointMake(_mainCollectionView.frame.origin.x, rect.origin.y - headerViewHeight-10) animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

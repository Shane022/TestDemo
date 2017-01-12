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
    
    _arrDataSource = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    _mainCollectionView.backgroundColor = [UIColor clearColor];
    [_mainCollectionView registerClass:[TPGTestCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
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
        _dataSource = [[TPGCollectionViewDataSource alloc] initWithDataSource:_arrDataSource cellIdentifier:@"cellId" headerViweIdentifier:@"headerId"];
    }
    return _dataSource;
}

- (TPGCollectionViewDelegate *)delegate
{
    if (nil == _delegate) {
        __weak typeof(self) weakSelf = self;
        _delegate = [[TPGCollectionViewDelegate alloc] initWithDataSource:_arrDataSource selectBlock:^(NSIndexPath *indexPath, UICollectionView *collectionView) {
            [weakSelf showAlertWithTitle:[NSString stringWithFormat:@"curIdx %ld",indexPath.row]];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  ViewController.m
//  Test
//
//  Created by dvt04 on 17/1/3.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSOperationQueue *_downloadQueue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if 0
    dispatch_queue_t queue = dispatch_queue_create("com.testProgrect.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"1");
    });
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    
    NSLog(@"i'm mainthread");
#endif

#if 0
    // test for semaphore
    dispatch_semaphore_t signal = dispatch_semaphore_create(2);
    for (int i = 0; i < 6; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_semaphore_wait(signal, DISPATCH_TIME_FOREVER);
            NSLog(@"%d",i);
            [NSThread sleepForTimeInterval:5];
            dispatch_semaphore_signal(signal);
        });
    }
#endif
  
    
//    [self setupComponent];
    
    
    
//    NSString *str = @"1 2 331Te321s4143t3";
//    NSLog(@"original data:%@",str);
////    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
//    NSCharacterSet *characterSet = [NSCharacterSet lowercaseLetterCharacterSet];
//    NSArray *setArr = [str componentsSeparatedByCharactersInSet:characterSet];
//    NSString *resultStr1 = [setArr componentsJoinedByString:@""];
//    NSLog(@"result:%@",resultStr1);
    

}

#pragma mark - TestForCreateDirectory
- (void)setupComponent
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(100, 100, 80, 40)];
    [btn setBackgroundColor:[UIColor orangeColor]];
    [btn setTitle:@"create" forState:UIControlStateNormal];
    [btn setTitle:@"delete" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onHitBtnHandleDirectory:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)onHitBtnHandleDirectory:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *subPath = [path stringByAppendingPathComponent:@"subPath"];
    NSString *filePath = [subPath stringByAppendingPathComponent:@"firstObject"];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    NSError *error;
    NSLog(@"%@",subPath);
    
    if (btn.selected) {
        // delete
        NSArray *arrTem = [manager contentsOfDirectoryAtPath:subPath error:nil];
        NSLog(@"%@",arrTem);
        if ([manager fileExistsAtPath:subPath isDirectory:&isDir]) {
            [arrTem enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *item = (NSString *)obj;
                NSString *pathTem = [subPath stringByAppendingPathComponent:item];
                if ([manager fileExistsAtPath:pathTem]) {
                    [manager removeItemAtPath:pathTem error:nil];
                }
            }];
        } else {
            NSLog(@"no such directory");
        }
    } else {
        // create
        if (![manager fileExistsAtPath:filePath isDirectory:&isDir]) {
            [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        } else {
            NSLog(@"directory is exists");
        }
    }
    btn.selected = !btn.selected;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

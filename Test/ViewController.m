//
//  ViewController.m
//  Test
//
//  Created by dvt04 on 17/1/3.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
#if 0
    // test for GCD serial queue
    dispatch_queue_t queue = dispatch_queue_create("com.testProgrect.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"1");
    });
    dispatch_async(queue, ^{
        NSLog(@"2");
    });
    
    NSLog(@"i'm mainthread");
//    // --------------------------------
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
//    // --------------------------------
#endif
  
//    // test for createDirectory
//    [self setupComponent];
//    // --------------------------------
    
//    // test for NSCharacter
//    NSString *str = @"1 2 331Te321s4143t3";
//    NSLog(@"original data:%@",str);
////    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
//    NSCharacterSet *characterSet = [NSCharacterSet lowercaseLetterCharacterSet];
//    NSArray *setArr = [str componentsSeparatedByCharactersInSet:characterSet];
//    NSString *resultStr1 = [setArr componentsJoinedByString:@""];
//    NSLog(@"result:%@",resultStr1);
//    // --------------------------------

//    // test for hide keyboard
//    [self setupTextField];
//    // --------------------------------
    
//    // test for NSThreadMethod performSelectorInBackground
//    [self setupLaebl];
//    // --------------------------------

    

//    // test for dispatch_priority
//    [self testForGCDpriority];
//    // --------------------------------
    
//    // test ,UIbutton show a part of title without frame in iOS8
//    self.view.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:self.btn];
//    self.btn.frame = CGRectZero;
//    // --------------------------------
}

#pragma mark - UIbutton show a part of title without frame in iOS8
- (UIButton *)btn
{
    if (_btn == nil) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btn.titleLabel setFont:[UIFont systemFontOfSize:16 weight:10]];
        [_btn setTitle:NSLocalizedString(@"墨", @"")  forState:UIControlStateNormal];
    }
    return _btn;
}

#pragma mark - TestForGCDPriority
- (void)testForGCDpriority
{
    dispatch_queue_t queue = dispatch_queue_create("com.test.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSLog(@"Proiority background - 1");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSLog(@"Proiority low - 2");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"Proiority hight - 3");
    });
    
    dispatch_apply(3, queue, ^(size_t index) {
        NSLog(@"index:%zu repeat", index);
    });
    //
    dispatch_time_t time = 5;
    dispatch_after(time, queue, ^{
        NSLog(@"delayed performance");
    });
}

#pragma mark - TestForNSThreadMethod_performSelectorInBackground
- (void)setupLaebl
{
    _label=[[UILabel alloc] initWithFrame:CGRectMake(40, 40, 60, 40)];
    _label.textColor=[UIColor redColor];
    _label.text=@"123";
    [self.view addSubview:_label];
    
    [self performSelectorInBackground:@selector(backWork) withObject:nil];
}

-(void)backWork
{
    NSLog(@"the thread is %@, isMainThread:%@",[NSThread currentThread], [NSThread currentThread].isMainThread ?@"YES":@"NO");
    sleep(2);
    [self performSelectorOnMainThread:@selector(mainWork) withObject:nil waitUntilDone:NO];
}

-(void)mainWork
{
    NSLog(@"the main thread is %@, isMainTHread:%@",[NSThread currentThread], [NSThread currentThread].isMainThread ? @"YES":@"NO");
    
    _label.text=@"456";
    _label.textColor=[UIColor greenColor];
    
}

#pragma mark - TestForHideKeyboard
- (void)setupTextField
{
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, 200, 40)];
    textField.backgroundColor = [UIColor redColor];
    [self.view addSubview:textField];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
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

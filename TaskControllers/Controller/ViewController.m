//
//  ViewController.m
//  TaskControllers
//
//  Created by Екатерина on 10/29/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "ViewController.h"
#import "TableCollectionViewController.h"
#import "Masonry.h"
@interface ViewController ()
@property (nonatomic, strong) TableCollectionViewController * tableCollectionVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"View Will Appear");
}
- (IBAction)presentTableControllerView:(id)sender {
    TableCollectionViewController * tableCollectionVC = [TableCollectionViewController new];
    __weak typeof(self) weakSelf = self;
    tableCollectionVC.onCloseBlock = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:tableCollectionVC animated:YES completion:nil];
}
- (IBAction)presentNavigationController:(id)sender {
    TableCollectionViewController * tableCollectionVC = [TableCollectionViewController new];
    __weak typeof(self) weakSelf = self;
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:tableCollectionVC];
    [nvc setNavigationBarHidden:TRUE];
    tableCollectionVC.onCloseBlock = ^{
        [weakSelf dismissViewControllerAnimated:nvc completion:nil];
    };
    [self presentViewController:nvc animated:YES completion:nil];
}
- (IBAction)presentChildViewController:(id)sender {
    __weak typeof(self) weakSelf = self;
    
    TableCollectionViewController * tableCollectionVC = [TableCollectionViewController new];
    __weak typeof(self) weakTableCollectionVC  = self;
    
    [self addChildViewController:tableCollectionVC];
    [self.view addSubview:tableCollectionVC.view];
    [tableCollectionVC didMoveToParentViewController:self];
    tableCollectionVC.view.alpha = 0.0;
    self.tableCollectionVC = tableCollectionVC;
    [UIView animateWithDuration:1 animations:^{
        weakSelf.tableCollectionVC.view.alpha = 1;
    }];
    
    tableCollectionVC.onCloseBlock = ^{
        [UIView animateWithDuration:1 animations:^{
            weakSelf.tableCollectionVC.view.alpha = 0;

        } completion:^(BOOL finished) {
            [weakSelf.tableCollectionVC willMoveToParentViewController:nil];
            
            [weakSelf.tableCollectionVC.view removeFromSuperview];
            [weakSelf.tableCollectionVC removeFromParentViewController];
        }];
    };

    [tableCollectionVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view.mas_left);
        make.top.equalTo(weakSelf.view.mas_top);
        make.right.equalTo(weakSelf.view.mas_right);
        make.bottom.equalTo(weakSelf.view.mas_bottom);
    }];
}


@end

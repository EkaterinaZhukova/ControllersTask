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
#import "SelectedIndexViewController.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}



- (IBAction)presentTableControllerView:(id)sender {
    TableCollectionViewController * tableCollectionVC = [TableCollectionViewController new];
    __weak typeof(self) weakSelf = self;
    __weak typeof(tableCollectionVC) weakTableCollectionVC = tableCollectionVC;

    tableCollectionVC.onCreateSelectedIndex = ^(NSString * selectedIndex) {
        SelectedIndexViewController * vc = [[SelectedIndexViewController alloc]init];
        vc.currentIndexCount = selectedIndex;
            vc.onCloseBlock = ^{
                [weakTableCollectionVC dismissViewControllerAnimated:YES completion:nil];
            };
            [weakTableCollectionVC presentViewController:vc animated:YES completion:nil];
    };
    tableCollectionVC.onCloseBlock = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:tableCollectionVC animated:YES completion:nil];
}



- (IBAction)presentNavigationController:(id)sender {
    TableCollectionViewController * tableCollectionVC = [TableCollectionViewController new];
    
    __weak typeof(tableCollectionVC) weakTableCollectionVC = tableCollectionVC;
    __weak typeof(self) weakSelf = self;
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:tableCollectionVC];
    [nvc setNavigationBarHidden:TRUE];
    tableCollectionVC.onCreateSelectedIndex = ^(NSString * selectedIndex) {
        SelectedIndexViewController * vc = [[SelectedIndexViewController alloc]init];
        vc.currentIndexCount = selectedIndex;
        vc.onCloseBlock = ^{
            [weakTableCollectionVC.navigationController popViewControllerAnimated:YES];
        };
        [weakTableCollectionVC.navigationController pushViewController:vc animated:YES];
    };
    tableCollectionVC.onCloseBlock = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    [self presentViewController:nvc animated:YES completion:nil];
    
    
}
- (IBAction)presentChildViewController:(id)sender {
    __weak typeof(self) weakSelf = self;
    TableCollectionViewController * tableCollectionVC = [TableCollectionViewController new];
    
    [self addChildViewController:tableCollectionVC];
    [self.view addSubview:tableCollectionVC.view];
    [tableCollectionVC didMoveToParentViewController:self];
    tableCollectionVC.view.alpha = 0.0;
    
    __weak typeof(tableCollectionVC)weakTableCollectionVC = tableCollectionVC;
    [UIView animateWithDuration:1 animations:^{
        weakTableCollectionVC.view.alpha = 1;
    }];
    tableCollectionVC.onCreateSelectedIndex = ^(NSString * selectedIndex) {
        SelectedIndexViewController * vc = [[SelectedIndexViewController alloc]init];
        vc.currentIndexCount = selectedIndex;
        __weak typeof(vc)weakVC = vc;
        vc.onCloseBlock = ^{
            [UIView animateWithDuration:1 animations:^{
                [weakVC.view setFrame:CGRectMake(0, weakVC.view.frame.origin.y - weakVC.view.frame.size.height, weakVC.view.frame.size.width, weakVC.view.frame.size.height)];
                
            } completion:^(BOOL finished) {
                [weakVC willMoveToParentViewController:nil];
                [weakVC.view removeFromSuperview];
                [weakVC removeFromParentViewController];
            }];
        };
        [vc.view setFrame:CGRectMake(0, -vc.view.frame.size.height, vc.view.frame.size.width, vc.view.frame.size.height)];
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
        [vc didMoveToParentViewController:self];
        
        [UIView animateWithDuration:1 animations:^{
            [weakVC.view setFrame:CGRectMake(0, weakVC.view.frame.origin.y + weakVC.view.frame.size.height, weakVC.view.frame.size.width, weakVC.view.frame.size.height)];
        }];
    };
    tableCollectionVC.onCloseBlock = ^{
        [UIView animateWithDuration:1 animations:^{
            weakTableCollectionVC.view.alpha = 0;
            
        } completion:^(BOOL finished) {
            [weakTableCollectionVC willMoveToParentViewController:nil];
            [weakTableCollectionVC.view removeFromSuperview];
            [weakTableCollectionVC removeFromParentViewController];
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

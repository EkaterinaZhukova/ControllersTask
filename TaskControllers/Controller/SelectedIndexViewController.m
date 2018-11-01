//
//  SelectedIndexViewController.m
//  TaskControllers
//
//  Created by Екатерина on 10/31/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "SelectedIndexViewController.h"
#import "Masonry.h"
@interface SelectedIndexViewController ()
@property (nonatomic,retain) UILabel *currentIndexLabel;
@end

@implementation SelectedIndexViewController

-(UIButton*) createCloseButton{
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
    return closeButton;
}
-(void) onCloseAction{
    if(self.onCloseBlock){
        self.onCloseBlock();
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:UIColor.whiteColor];
    
    UIButton *closeButton = [self createCloseButton];
    [closeButton addTarget:self action:@selector(onCloseAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    __weak typeof(self) weakSelf = self;
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(weakSelf.view.safeAreaInsets.bottom + 20));
        make.left.equalTo(weakSelf.view.mas_left).with.offset(20);
        make.height.equalTo(@(50));
    }];
    
    UILabel * currentIndexLabel = [UILabel new];
    self.currentIndexCount ? (currentIndexLabel.text = self.currentIndexCount) : (currentIndexLabel.text = @"Index isn't set up");
    [currentIndexLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:currentIndexLabel];

    [currentIndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.centerY.equalTo(weakSelf.view.mas_centerY);
        make.left.equalTo(weakSelf.view.mas_left).with.offset(20);
        make.right.equalTo(weakSelf.view.mas_right).with.offset(-20);
    }];
    
}
- (void)dealloc{
    NSLog(@"Dealloc SelectedIndexViewController");
}
@end

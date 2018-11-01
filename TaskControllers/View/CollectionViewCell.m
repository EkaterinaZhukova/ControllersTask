//
//  CollectionViewCell.m
//  TaskControllers
//
//  Created by Екатерина on 10/31/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Masonry.h"
@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] init];
        [self.contentView addSubview:_label];
        __weak typeof(self) weakSelf = self;
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView.mas_centerX);
            make.centerY.equalTo(weakSelf.contentView.mas_centerY);
            make.left.equalTo(weakSelf.contentView.mas_left);
            make.left.equalTo(weakSelf.contentView.mas_right);
        }];
        _label.text = @"Label";
    }
    return self;
}
@end

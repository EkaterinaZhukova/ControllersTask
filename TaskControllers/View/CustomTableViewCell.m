//
//  CustomTableViewCell.m
//  TaskControllers
//
//  Created by Екатерина on 10/30/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "Masonry.h"
#import "CollectionViewCell.h"
#import "SelectedIndexViewController.h"

#define collectionReuseCell @"collectionCellId"
@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)prepareForReuse{
    [super prepareForReuse];
    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collection scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(100, 100);
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];

        UICollectionView * myCollection = [[UICollectionView alloc] initWithFrame:self.contentView.frame collectionViewLayout:flowLayout];
        [myCollection registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:collectionReuseCell];
        
        [myCollection setBackgroundColor:UIColor.brownColor];
        myCollection.dataSource = self;
        myCollection.delegate = self;
        
        self.collection = myCollection;
        
        [self.contentView addSubview:self.collection];
        
        __weak typeof(self) weakSelf = self;
        [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left);
            make.right.equalTo(weakSelf.contentView.mas_right);
            make.height.equalTo(weakSelf.contentView.mas_height);
        }];
    }
    
    return self;
}



- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionReuseCell forIndexPath:indexPath];
    cell.backgroundColor = UIColor.lightGrayColor;
    cell.label.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"select");
    SelectedIndexViewController *vc = [[SelectedIndexViewController alloc]init];
    vc.currentIndexCount = [NSString stringWithFormat:@"%ld",indexPath.row];
    if(self.delegate){
        [self.delegate showNewViewController:vc];
    }
}


@end


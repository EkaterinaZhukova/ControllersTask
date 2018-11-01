//
//  CustomTableViewCell.h
//  TaskControllers
//
//  Created by Екатерина on 10/30/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerFromCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collection;
@property (nonatomic,weak) id<ViewControllerFromCell> delegate;
@end

NS_ASSUME_NONNULL_END

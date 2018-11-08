//
//  SelectedIndexViewController.h
//  TaskControllers
//
//  Created by Екатерина on 10/31/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectedIndexViewController : UIViewController

@property(nonatomic,copy) dispatch_block_t onCloseBlock;
@property(strong,nonatomic) NSString * currentIndexCount;

@end

NS_ASSUME_NONNULL_END

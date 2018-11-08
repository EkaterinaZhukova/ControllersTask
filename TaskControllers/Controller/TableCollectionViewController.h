//
//  TableCollectionViewController.h
//  TaskControllers
//
//  Created by Екатерина on 10/30/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableCollectionViewController : UIViewController

@property(nonatomic,copy) dispatch_block_t onCloseBlock;
@property (nonatomic, copy) void (^onCreateSelectedIndex)(NSString*);


@end

NS_ASSUME_NONNULL_END

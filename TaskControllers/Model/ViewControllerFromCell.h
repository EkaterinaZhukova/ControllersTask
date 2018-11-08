//
//  ViewControllerFromCell.h
//  TaskControllers
//
//  Created by Екатерина on 10/31/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ViewControllerFromCell <NSObject>
-(void) showNewViewController :(NSString*) selectedIndex;
@end

NS_ASSUME_NONNULL_END

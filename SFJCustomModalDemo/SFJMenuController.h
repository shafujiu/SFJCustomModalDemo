//
//  SFJMenuController.h
//  SFJCustomModalDemo
//
//  Created by 赵维 on 2018/9/12.
//  Copyright © 2018年 shafujiu.cn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFJMoreMenuCell.h"

@interface SFJMenuController : UIViewController

@property (nonatomic, strong, readonly) UITableView *menuView;

@property (nonatomic, strong, readonly) NSArray<SFJMenuAction *> *actions;

- (void)addAction:(SFJMenuAction *)action;

+ (instancetype)menuControllerAtPoint:(CGPoint)point;


@end

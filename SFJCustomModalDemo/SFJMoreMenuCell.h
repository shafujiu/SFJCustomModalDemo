//
//  SFJMoreMenuCell.h
//  WeInsight
//
//  Created by 赵维 on 2018/8/30.
//  Copyright © 2018年 newrank.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFJMenuAction : NSObject

@property (nonatomic, copy) void(^MenuAction)(void);
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *iconName;

+ (instancetype)actionWithTitle:(NSString *)title
                       iconName:(NSString *)iconName
                         action:(void(^)(void))action;
// 举报
+ (instancetype)reportAction:(void(^)(void))action;
// 搜索
+ (instancetype)searchAction:(void(^)(void))action;
// 分享
+ (instancetype)shareAction:(void(^)(void))action;

@end

static NSString *const SFJMoreMenuCellID = @"SFJMoreMenuCellID";

@interface SFJMoreMenuCell : UITableViewCell

@property (nonatomic, strong) SFJMenuAction *action;

@end

//
//  SFJMoreMenuCell.m
//  WeInsight
//
//  Created by 赵维 on 2018/8/30.
//  Copyright © 2018年 newrank.cn. All rights reserved.
//

#import "SFJMoreMenuCell.h"


@implementation SFJMenuAction

+ (instancetype)actionWithTitle:(NSString *)title
                       iconName:(NSString *)iconName
                         action:(void(^)(void))action{
    SFJMenuAction *act = [[SFJMenuAction alloc] init];
    act.title = title;
    act.iconName = iconName;
    act.MenuAction = action;
    return act;
}

// 举报
+ (instancetype)reportAction:(void(^)(void))action{
    return [self actionWithTitle:@"举报" iconName:@"icon_pro_report" action:action];
}
// 搜索
+ (instancetype)searchAction:(void(^)(void))action{
    return [self actionWithTitle:@"搜索" iconName:@"icon_pro_search" action:action];
}
// 分享
+ (instancetype)shareAction:(void(^)(void))action{
    return [self actionWithTitle:@"分享" iconName:@"icon_pro_share" action:action];
}

@end

@interface SFJMoreMenuCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end

@implementation SFJMoreMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAction:(SFJMenuAction *)action{
    _action = action;
    _iconImgView.image = [UIImage imageNamed:action.iconName];
    _titleLbl.text = action.title;
    
}

- (IBAction)btnAct:(UIButton *)sender {
    !self.action.MenuAction ? : self.action.MenuAction();
}



@end

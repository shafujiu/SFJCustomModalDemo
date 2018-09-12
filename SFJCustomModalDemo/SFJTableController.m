//
//  SFJTableController.m
//  SFJCustomModalDemo
//
//  Created by 赵维 on 2018/9/12.
//  Copyright © 2018年 shafujiu.cn. All rights reserved.
//

#import "SFJTableController.h"
#import "SFJRefreshTopController.h"

static CGFloat const kMinOffsetY = -150;

@interface SFJTableController ()<UIScrollViewDelegate>

@end

@implementation SFJTableController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < kMinOffsetY) {
        NSLog(@"到新的页面");
        SFJRefreshTopController *vc = [[SFJRefreshTopController alloc] init];
        [self presentViewController:vc animated:YES completion:^{
            [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }];
        [scrollView setContentOffset:CGPointMake(0, offsetY) animated:NO];
    }
    NSLog(@"offsetY = %f", offsetY);
}
#pragma mark -
#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld行",indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

@end

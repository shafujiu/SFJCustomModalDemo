//
//  SFJMenuController.m
//  SFJCustomModalDemo
//
//  Created by 赵维 on 2018/9/12.
//  Copyright © 2018年 shafujiu.cn. All rights reserved.
//

#import "SFJMenuController.h"
#import "SFJMoreMenuCell.h"

@interface SFJMenuPresentAnimate : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation SFJMenuPresentAnimate

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    SFJMenuController *toVC = (SFJMenuController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (!toVC || !fromVC) {
        return;
    }
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // 2
    [containerView addSubview:toVC.view];
    toVC.view.frame = containerView.bounds;
    toVC.view.alpha = 0;
    
    toVC.menuView.transform = CGAffineTransformMakeScale(.3, .3);
    [UIView animateWithDuration:duration animations:^{
        toVC.view.alpha = 1;
        toVC.menuView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    // 1
    return 0.3;
}

@end

@interface SFJMenuDismissAnimate : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation SFJMenuDismissAnimate

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (!toVC || !fromVC) {
        return;
    }
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    // 3
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    // 1
    return 0.1;
}

@end


static CGFloat const kCellHeight = 45;
static CGFloat const kMenuViewWidth = 180;

@interface SFJMenuController ()<UIViewControllerTransitioningDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong, readwrite) UITableView *menuView;
@property (nonatomic, strong) NSMutableArray<SFJMenuAction *> *mActions;
@property (nonatomic, assign) CGPoint menuStartPoint;
@end

@implementation SFJMenuController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        [self p_setupUI];
    }
    return self;
}

+ (instancetype)menuControllerAtPoint:(CGPoint)point{
    SFJMenuController *vc = [[self alloc] init];
    
    vc.menuStartPoint = point;
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_setupUI];
}

- (void)p_setupUI{
    [self.view addSubview:self.menuView];
    
    [self p_updateFrame];
    [self.menuView reloadData];
}


- (void)p_updateFrame{
    
    CGFloat height = self.mActions.count * kCellHeight;
    self.menuView.frame = CGRectMake(0, 0, kMenuViewWidth, height);
    
    [self setMenuStartPoint:self.menuStartPoint];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.25];
}

- (void)setMenuStartPoint:(CGPoint)menuStartPoint{
    _menuStartPoint = menuStartPoint;
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin = 15;
    CGFloat popY = self.menuStartPoint.y;
    CGFloat popX = screenW - kMenuViewWidth - margin;
    CGFloat height = self.mActions.count * kCellHeight;
    
    self.menuView.frame = CGRectMake(popX, popY, kMenuViewWidth, height);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

- (NSArray<SFJMenuAction *> *)actions{
    return self.mActions;
}

- (void)addAction:(SFJMenuAction *)action{
    [self.mActions addObject:action];
    [self p_updateFrame];
}

#pragma mark -
#pragma mark - <UITableViewDelegate, UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mActions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SFJMoreMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:SFJMoreMenuCellID forIndexPath:indexPath];
    cell.action = self.mActions[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    !self.mActions[indexPath.row].MenuAction ? : self.mActions[indexPath.row].MenuAction();
//    SFJLog(@"didSelectRowAtIndexPath");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (UITableView *)menuView{
    
    if (!_menuView) {
        UITableView *menuV = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        menuV.delegate = self;
        menuV.dataSource = self;
        menuV.backgroundColor = [UIColor whiteColor];
        menuV.scrollEnabled = NO;
        [menuV registerNib:[UINib nibWithNibName:NSStringFromClass([SFJMoreMenuCell class]) bundle:nil] forCellReuseIdentifier:SFJMoreMenuCellID];
        
        menuV.layer.cornerRadius = 4;
        menuV.layer.shadowOffset = CGSizeMake(0, 2);
        menuV.layer.shadowRadius = 6;
        menuV.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:.19].CGColor;
        menuV.layer.shadowOpacity = 1;
        menuV.layer.masksToBounds = YES;
        _menuView = menuV;
    }
    return _menuView;
}

- (NSMutableArray<SFJMenuAction *> *)mActions{
    
    if (!_mActions) {
        _mActions = [NSMutableArray array];
    }
    return _mActions;
}

#pragma mark -
#pragma mark - <UIViewControllerTransitioningDelegate>

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[SFJMenuPresentAnimate alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[SFJMenuDismissAnimate alloc] init];;
}

@end

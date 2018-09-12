//
//  SFJRefreshTopController.m
//  SFJCustomModalDemo
//
//  Created by 赵维 on 2018/9/12.
//  Copyright © 2018年 shafujiu.cn. All rights reserved.
//

#import "SFJRefreshTopController.h"


@interface SFJRefreshTopPresentAnimate : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation SFJRefreshTopPresentAnimate

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    SFJRefreshTopController *toVC = (SFJRefreshTopController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
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
//    toVC.menuView.transform = CGAffineTransformMakeScale(.3, .3);
    [UIView animateWithDuration:duration animations:^{
        toVC.view.alpha = 1;
        
        [toVC animation];
//        toVC.menuView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    // 1
    return 0.3;
}

@end

@interface SFJRefreshTopDismissAnimate : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation SFJRefreshTopDismissAnimate

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

@interface SFJRefreshTopController ()<UIViewControllerTransitioningDelegate>

@end

@implementation SFJRefreshTopController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    
    
}

- (void)animation{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:view];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2 animations:^{
            view.transform = CGAffineTransformMakeTranslation(0, 300);
        } completion:^(BOOL finished) {
            
        }];
//    });
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - <UIViewControllerTransitioningDelegate>

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[SFJRefreshTopPresentAnimate alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[SFJRefreshTopDismissAnimate alloc] init];;
}

@end

//
//  SFJMenuController.m
//  KTAlertController
//
//  Created by 沙缚柩 on 2018/9/11.
//  Copyright © 2018年 Kevin. All rights reserved.
//

#import "SFJAlertController.h"


@interface SFJPresentAnimate : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation SFJPresentAnimate

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    SFJAlertController *toVC = (SFJAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
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
        
        toVC.contentView.transform = CGAffineTransformMakeScale(.3, .3);
        [UIView animateWithDuration:duration animations:^{
            toVC.view.alpha = 1;
            toVC.contentView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    // 1
    return 0.3;
}

@end

@interface SFJDismissAnimate : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation SFJDismissAnimate

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    
    SFJAlertController *toVC = (SFJAlertController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
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

@interface SFJAlertController ()<UIViewControllerTransitioningDelegate>

@end

@implementation SFJAlertController

+ (instancetype)alertController{
    SFJAlertController *vc = [[SFJAlertController alloc] init];
    return vc;
}

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
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.3];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissViewControllerAnimated:completion:)];
    [self.view addGestureRecognizer:tap];
    
    [self.view addSubview:self.contentView];
}


- (void)p_dismiss{
    
}

- (UIView *)contentView{
    
    if (!_contentView) {
        CGFloat h = 200;
        CGFloat w = CGRectGetWidth(self.view.bounds) - 30;
        CGFloat x = 15;
        CGFloat y = (CGRectGetHeight(self.view.bounds) - h) * .5;
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
        _contentView.backgroundColor = [UIColor whiteColor];
//        _contentView.userInteractionEnabled = YES;
        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_dismiss)];
//        [_contentView addGestureRecognizer:tap];
    }
    return _contentView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - <UIViewControllerTransitioningDelegate>

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[SFJPresentAnimate alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[SFJDismissAnimate alloc] init];;
}


@end




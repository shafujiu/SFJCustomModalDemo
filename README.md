# SFJCustomModalDemo
自定义modal 模仿UIAlertController的弹出方式

# 用意

我们在使用alert 的时候经常会为了简单，采用一个简单的view 弹出到keywind上面，但是这是存在隐患的，
本文旨在，模仿系统UIAlertcontroller的方式去做更好的弹窗，并且避免keywind的乱用。
第一步 仅仅实现了模态的自定义

我们也可用通过这种方式去实现，更多菜单关于更多菜单的的位置计算我们可以参考

[YCMenuView](https://github.com/WellsYC/YCMenuView) 作者模仿了一个类似于QQ的弹出菜单，但是个人认为不是很完美，如果能用到模态的方式，势必会更完美一些、、、单纯个人意见、、、 


# SFJMenuController

```
- (void)addAction:(SFJMenuAction *)action;
// point 是 右上角的位置 后期改进
+ (instancetype)menuControllerAtPoint:(CGPoint)point;
```

模仿UIAlertController 采用 命令模式。通过 SFJMenuAction 添加 菜单的项。



``` 
// 调用示例：
 SFJMenuController *vc = [SFJMenuController menuControllerAtPoint:CGPointMake(300, 80)];
    
    SFJMenuAction *action1 = [SFJMenuAction actionWithTitle:@"action1" iconName:nil action:^{
        NSLog(@"action1");
    }];
    SFJMenuAction *action2 = [SFJMenuAction actionWithTitle:@"action2" iconName:nil action:^{
        NSLog(@"action2");
    }];
    SFJMenuAction *action3 = [SFJMenuAction actionWithTitle:@"action3" iconName:nil action:^{
        NSLog(@"action3");
    }];
    [vc addAction: action1];
    [vc addAction: action2];
    [vc addAction: action3];
    [self presentViewController:vc animated:YES completion:nil];
```
//
//  ViewController.m
//  SFJCustomModalDemo
//
//  Created by 沙缚柩 on 2018/9/12.
//  Copyright © 2018年 shafujiu.cn. All rights reserved.
//

#import "ViewController.h"
#import "SFJAlertController.h"
#import "SFJMenuController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)show:(id)sender {
    
    SFJAlertController *vc = [[SFJAlertController alloc] init];
//    SFJMenuController *vc = [SFJMenuController menuControllerAtPoint:CGPointMake(300, 80)];
//
//    SFJMenuAction *action1 = [SFJMenuAction actionWithTitle:@"action1" iconName:nil action:^{
//        NSLog(@"action1");
//    }];
//    SFJMenuAction *action2 = [SFJMenuAction actionWithTitle:@"action2" iconName:nil action:^{
//        NSLog(@"action2");
//    }];
//    SFJMenuAction *action3 = [SFJMenuAction actionWithTitle:@"action3" iconName:nil action:^{
//        NSLog(@"action3");
//    }];
//    [vc addAction: action1];
//    [vc addAction: action2];
//    [vc addAction: action3];
    [self presentViewController:vc animated:YES completion:nil];
}

@end

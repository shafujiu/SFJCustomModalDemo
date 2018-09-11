//
//  ViewController.m
//  SFJCustomModalDemo
//
//  Created by 沙缚柩 on 2018/9/12.
//  Copyright © 2018年 shafujiu.cn. All rights reserved.
//

#import "ViewController.h"
#import "SFJAlertController.h"

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
    
    SFJAlertController *alert = [[SFJAlertController alloc] init];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end

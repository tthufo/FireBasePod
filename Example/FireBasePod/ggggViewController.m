//
//  ggggViewController.m
//  FireBasePod_Example
//
//  Created by Mac on 7/10/18.
//  Copyright © 2018 tthufo@gmail.com. All rights reserved.
//

#import "ggggViewController.h"

#import "FirePush.h"

@interface ggggViewController ()

@end

@implementation ggggViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[FirePush shareInstance] completion:^(firebaseState state, NSDictionary *info) {
        
        NSLog(@"%i --- %@", state, info);
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

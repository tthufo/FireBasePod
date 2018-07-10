//
//  FireBaseViewController.m
//  FireBasePod
//
//  Created by tthufo@gmail.com on 07/10/2018.
//  Copyright (c) 2018 tthufo@gmail.com. All rights reserved.
//

#import "FireBaseViewController.h"

#import "FirePush.h"

@interface FireBaseViewController ()

@end

@implementation FireBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[FirePush shareInstance] completion:^(firebaseState state, NSDictionary *info) {
        
        NSLog(@"%i --- %@", state, info);
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

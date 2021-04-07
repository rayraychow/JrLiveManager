//
//  JRViewController.m
//  JrLiveManager
//
//  Created by rayraychow on 04/07/2021.
//  Copyright (c) 2021 rayraychow. All rights reserved.
//

#import "JRViewController.h"
#import "JrLiveManager.h"

@interface JRViewController ()

@end

@implementation JRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    JrLiveManager *manager = [[JrLiveManager alloc] initWithBundleID:@"com.jravity.hjlive.ios" cdKey:@"CX5M3PEPZ" sdkVersion:@"v1.10"];
    [manager openWithUrlString:@"https://nfjj-1253740179.cos.ap-guangzhou.myqcloud.com/AHPNT_1.mp4"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

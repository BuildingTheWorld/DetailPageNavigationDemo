//
//  ViewController.m
//  detailTabelView
//
//  Created by I on 2017/5/4.
//  Copyright © 2017年 QT. All rights reserved.
//

#import "ViewController.h"

#import "DetailTabelVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor orangeColor];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    DetailTabelVC * detailVC = [[DetailTabelVC alloc] init];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end

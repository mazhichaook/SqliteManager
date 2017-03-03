//
//  ViewController.m
//  SqliteManager
//
//  Created by 马志超 on 2017/3/3.
//  Copyright © 2017年 ziqiang. All rights reserved.
//

#import "ViewController.h"
#import "SqliteManager.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    BOOL b = [[SqliteManager shareSqliteManage]createTableWithClass:[Person class]];
    
    NSLog(@"%d",b);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

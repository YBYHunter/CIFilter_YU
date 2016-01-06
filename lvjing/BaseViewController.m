//
//  BaseViewController.m
//  lvjing
//
//  Created by apple on 15/12/3.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "BaseViewController.h"
#import "ViewController.h"
#import "ViewController2.h"
@interface BaseViewController ()
{
    ViewController *viewcontroller;
    ViewController2 *viewcontroller2;
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addbtn];
}
- (void)addbtn{
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *planBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [planBtn setFrame:CGRectMake(self.view.frame.origin.x+100, self.view.frame.origin.y+200, self.view.frame.size.width-200, 50)];
    planBtn.backgroundColor = [UIColor whiteColor];
    [planBtn setTitle:@"CICategaryColorAdjustment" forState:UIControlStateNormal];
    [planBtn addTarget:self action:@selector(CICategaryColorAdjustment) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:planBtn];
    
    
    UIButton *groupBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [groupBtn setFrame:CGRectMake(self.view.frame.origin.x+100, self.view.frame.origin.y+300, self.view.frame.size.width-200, 50)];
    groupBtn.backgroundColor = [UIColor whiteColor];
    [groupBtn setTitle:@"CICategoryColorEffect" forState:UIControlStateNormal];
    [groupBtn addTarget:self action:@selector(CICategoryColorEffect) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:groupBtn];
}

- (void)CICategaryColorAdjustment{
    viewcontroller = [[ViewController alloc]init];
    [self presentViewController:viewcontroller animated:YES completion:nil];
}

- (void)CICategoryColorEffect{
    viewcontroller2 = [[ViewController2 alloc]init];
    [self presentViewController:viewcontroller2 animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
